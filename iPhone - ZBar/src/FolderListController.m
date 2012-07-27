//------------------------------------------------------------------------
//  Copyright 2011 (c) Jeff Brown <spadix@users.sourceforge.net>
//
//  This file is part of the ZBar iPhone App.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  http://zbar.sourceforge.net/iphone
//------------------------------------------------------------------------

#import "FolderListController.h"
#import "BarcodeListController.h"
#import "TextEditController.h"
#import "TintedBarButtonItem.h"
#import "Folder.h"
#import "Barcode.h"
#import "Settings.h"
#import "SettingsController.h"

#define DEBUG_MODULE FolderList
#import "util.h"


@implementation FolderListController

@synthesize context;

- (id) init
{
    self = [super initWithStyle: UITableViewStylePlain];
    if(!self)
        return(nil);

    self.title = @"Barcode Folders";
    self.navigationItem.backBarButtonItem =
        [[[UIBarButtonItem alloc]
             initWithTitle: @"Folders"
             style: UIBarButtonItemStyleBordered
             target: nil
             action: nil]
            autorelease];

    return(self);
}

- (void) initFetch
{
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:
        [NSEntityDescription
            entityForName: @"Folder"
            inManagedObjectContext: context]];
    [request setSortDescriptors:
        [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey: @"index"
                              ascending: YES]]];

    results = [[NSFetchedResultsController alloc]
                  initWithFetchRequest: request
                  managedObjectContext: context
                  sectionNameKeyPath: nil
                  cacheName: @"Folders"];
    results.delegate = self;

    [request release];

    NSError *error = nil;
    if(![results performFetch: &error])
        [error logWithMessage: @"fetching folders"];
}

- (NSInteger) rows
{
    NSArray *sections = results.sections;
    if(sections.count)
        return([[sections objectAtIndex: 0]
                   numberOfObjects]);
    return(0);
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    UITableView *view = self.tableView;
    view.allowsSelectionDuringEditing = YES;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    clearButton = [[TintedBarButtonItem alloc]
                      initWithTitle: @"Clear"
                      target: self
                      action: @selector(clearAll)
                      tintColor: [UIColor colorWithRed: 189 / 255.
                                          green: 20 / 255.
                                          blue: 33 / 255.
                                          alpha: 1]];

    self.toolbarItems =
        [NSArray arrayWithObjects:
            [[[UIBarButtonItem alloc]
                 initWithImage: [UIImage imageNamed: @"gear"]
                 style: UIBarButtonItemStylePlain
                 target: self
                 action: @selector(updateSettings)]
                autorelease],
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:
                     UIBarButtonSystemItemFlexibleSpace
                 target: nil
                 action: nil]
                autorelease],
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem: UIBarButtonSystemItemCamera
                 target: [UIApplication sharedApplication].delegate
                 action: @selector(scanFromCamera)]
                autorelease],
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem:
                     UIBarButtonSystemItemFlexibleSpace
                 target: nil
                 action: nil]
                autorelease],
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                 target: self
                 action: @selector(addFolder)]
                autorelease],
            nil];

    if(!results)
        [self initFetch];
}

- (void) cleanup
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.toolbarItems = nil;
    [clearButton release];
    clearButton = nil;
    [results release];
    results = nil;
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (void) dealloc
{
    // workaround tableView reference bug
    if(self.isViewLoaded) {
        UITableView *view = self.tableView;
        view.delegate = nil;
        view.dataSource = nil;
    }
    [self cleanup];
    [context release];
    context = nil;
    [super dealloc];
}

- (void) viewDidDisappear: (BOOL) animated
{
    [super viewDidDisappear: animated];
    [self setEditing: NO
          animated: NO];
}

- (void) setEditing: (BOOL) editing
           animated: (BOOL) animated
{
    BOOL toggle = (self.editing != editing);
    [super setEditing: editing
           animated: animated];
    if(!toggle)
        return;

    if(!swiping || !editing) {
        [self.navigationItem
             setLeftBarButtonItem: (editing) ? clearButton : nil
             animated: animated];
        [self.navigationController
             setToolbarHidden: editing
             animated: animated];
        if(editing)
            // NB have to reset color here or it is overridden by bar
            clearButton.tintColor = clearButton.tintColor;
    }

    if(!editing)
        [UIApplication saveAfterDelay: .01];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) clearAll
{
    UIActionSheet *confirm =
        [[UIActionSheet alloc]
            initWithTitle: @"Erase all application data?"
            delegate: self
            cancelButtonTitle: @"Cancel"
            destructiveButtonTitle: @"Delete All"
            otherButtonTitles: nil];
    [confirm showInView: self.navigationController.view];
    [confirm release];
}

- (void) addFolder
{
    NSMutableDictionary *folder =
        [NSMutableDictionary dictionaryWithCapacity: 1];
    NSDateFormatter *fmt = [NSDateFormatter new];
    [fmt setDateStyle: NSDateFormatterMediumStyle];
    [fmt setTimeStyle: NSDateFormatterShortStyle];
    [folder setObject: [fmt stringFromDate: [NSDate date]]
            forKey: @"name"];
    [fmt release];

    TextEditController *editor =
        [[TextEditController alloc]
            initWithObject: folder
            keyPath: @"name"];
    editor.delegate = self;
    editor.title = @"Folder Name";

    UINavigationController *nav =
        [[UINavigationController alloc]
            initWithRootViewController: editor];
    [editor release];

    [self.view.window.rootViewController
         adPresentModalViewController: nav
         animated: YES];
    [nav release];
}

- (void) textEditController: (TextEditController*) editor
         didDismissWithSave: (BOOL) save
{
    if(save) {
        Folder *folder =
            [NSEntityDescription
                insertNewObjectForEntityForName: @"Folder"
                inManagedObjectContext: context];
        NSInteger row = [self rows];
        folder.index = row;
        folder.name = [editor.object valueForKey: @"name"];

        BarcodeListController *list =
            [[BarcodeListController alloc]
                initWithFolder: folder];
        [self.navigationController
             pushViewController: list
             animated: NO];
        [list release];
    }

    [editor.view.window.rootViewController
         adDismissModalViewController: editor.navigationController
         animated: YES];
}

- (void) updateSettings
{
    Settings *globalSettings = [Settings globalSettings];
    NSObject* settings = [globalSettings encodeAsPropertyList];

    SettingsController *svc =
        [[SettingsController alloc]
            initWithObject: settings
            schemaName: @"settings"];

    UIViewController *root = self.view.window.rootViewController;

    svc.completion = ^(SettingsController *settings, BOOL save) {
        if(save) {
            Settings *globalSettings = [Settings globalSettings];
            [globalSettings updateWithPropertyList: settings.object];

            NSObject* writeSettings = [globalSettings encodeAsPropertyList];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject: writeSettings
                      forKey: @"Settings"];

            // force changes to disk in case app is terminated
            [defaults synchronize];
        }

        [root adDismissModalViewController: settings.navigationController
              animated: YES];
    };

    UINavigationController *nav =
        [[UINavigationController alloc]
            initWithRootViewController: svc];
    [svc release];

    [root adPresentModalViewController: nav
          animated: YES];
    [nav release];
}


// PersistentState

- (id) saveState
{
    NSMutableDictionary *state =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
            NSStringFromClass([self class]), @"class",
            nil];
    return(state);
}

- (BOOL) restoreState: (id) state
{
    if(!state ||
       ![state isKindOfClass: [NSDictionary class]])
        return(NO);
    return(YES);
}


// UIActionSheetDelegate

- (void)   actionSheet: (UIActionSheet*) confirm
  clickedButtonAtIndex: (NSInteger) buttonIndex
{
    if(buttonIndex == confirm.destructiveButtonIndex) {
        for(Folder *folder in results.fetchedObjects)
            if(!folder.sticky)
                [context deleteObject: folder];
            else
                for(Barcode *barcode in folder.barcodes)
                    [context deleteObject: barcode];

        [self setEditing: NO
              animated: YES];
    }
}


// UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView: (UITableView*) view
{
    return(results.sections.count);
}

- (NSInteger) tableView: (UITableView*) view
  numberOfRowsInSection: (NSInteger) idx
{
    if(idx)
        return(0);
    return([self rows]);
}

- (void) configureCell: (UITableViewCell*) cell
           atIndexPath: (NSIndexPath*) path
{
    Folder *folder = [results objectAtIndexPath: path];
    cell.textLabel.text = folder.name;
    assert(folder.index == path.row);
}

- (UITableViewCell*) tableView: (UITableView*) view
         cellForRowAtIndexPath: (NSIndexPath*) path
{
    NSString *ruid = @"Folder";
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier: ruid];
    if(!cell) {
        cell = [[[UITableViewCell alloc]
                    initWithStyle: UITableViewCellStyleDefault
                    reuseIdentifier: ruid]
                   autorelease];
        cell.imageView.image = [UIImage imageNamed: @"folder"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    [self configureCell: cell
          atIndexPath: path];
    return(cell);
}

- (UITableViewCellEditingStyle) tableView: (UITableView*) view
            editingStyleForRowAtIndexPath: (NSIndexPath*) path
{
    Folder *folder = [results objectAtIndexPath: path];
    if(folder.sticky)
        return(UITableViewCellEditingStyleNone);
    return(UITableViewCellEditingStyleDelete);
}

- (void)   tableView: (UITableView*) view
  commitEditingStyle: (UITableViewCellEditingStyle) style
   forRowAtIndexPath: (NSIndexPath*) path
{
    if(style != UITableViewCellEditingStyleDelete)
        return;

    Folder *folder = [results objectAtIndexPath: path];
    if(folder.sticky) {
        assert(0);
        return;
    }

    [view beginUpdates];

    NSInteger n = [self rows];
    NSInteger section = path.section;
    [context deleteObject: folder];
    for(NSInteger i = path.row; i < n - 1; i++) {
        NSIndexPath *p = [NSIndexPath indexPathForRow: i + 1
                                      inSection: section];
        Folder *f = [results objectAtIndexPath: p];
        f.index = i;
    }

    [view endUpdates];
}

- (BOOL)      tableView: (UITableView*) view
  canMoveRowAtIndexPath: (NSIndexPath*) path
{
    Folder *folder = [results objectAtIndexPath: path];
    return(!folder.sticky);
}

- (void)   tableView: (UITableView*) view
  moveRowAtIndexPath: (NSIndexPath*) src
         toIndexPath: (NSIndexPath*) dst
{
    int section = src.section;
    int start = src.row;
    int end = dst.row;
    if(start == end || section != dst.section)
        return;

    [view beginUpdates];

    Folder *folder = [results objectAtIndexPath: src];
    assert(start == folder.index);
    folder.index = end;

    NSInteger di = (start < end) ? 1 : -1;
    NSInteger i = start;
    do {
        assert(i >= 0 && i < [self rows]);
        NSIndexPath *path = [NSIndexPath indexPathForRow: i + di
                                         inSection: section];
        Folder *folder = [results objectAtIndexPath: path];
        folder.index = i;
        i += di;
    } while(i != end);

    [view endUpdates];
}


// UITableViewDelegate

- (void)        tableView: (UITableView*) view
  didSelectRowAtIndexPath: (NSIndexPath*) path
{
    Folder *folder = [results objectAtIndexPath: path];
    assert(folder);

    if(!self.editing) {
        BarcodeListController *next =
            [[BarcodeListController alloc]
                initWithFolder: folder];
        [self.navigationController
             pushViewController: next
             animated: YES];
        [next release];
    }
    else {
        NSMutableDictionary *object =
            [NSMutableDictionary dictionaryWithObjectsAndKeys:
                folder.name, @"name",
                nil];
        SettingsController *edit =
            [[SettingsController alloc]
                initWithObject: object
                schemaName: @"editfolder"];

        UIViewController *root = self.view.window.rootViewController;

        edit.completion = ^(SettingsController *settings, BOOL save) {
            if(save) {
                NSDictionary *object = (id)settings.object;
                [folder setValuesForKeysWithDictionary: object];
            }

            [root adDismissModalViewController: settings.navigationController
                  animated: YES];
            [UIApplication saveAfterDelay: .01];
        };

        UINavigationController *nav =
            [[UINavigationController alloc]
                initWithRootViewController: edit];
        [edit release];

        [root adPresentModalViewController: nav
              animated: YES];
        [nav release];
    }
}

- (void)               tableView: (UITableView*) view
  willBeginEditingRowAtIndexPath: (NSIndexPath*) path
{
    swiping = YES;
}

- (void)            tableView: (UITableView*) view
  didEndEditingRowAtIndexPath: (NSIndexPath*) path
{
    swiping = NO;
}

- (NSIndexPath*)                 tableView: (UITableView*) view
  targetIndexPathForMoveFromRowAtIndexPath: (NSIndexPath*) src
                       toProposedIndexPath: (NSIndexPath*) dst
{
    NSInteger section = src.section;
    if(section != dst.section) {
        assert(0);
        return(src);
    }

    NSInteger n = [self rows];
    for(int i = dst.row; i <= n; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForRow: i
                                         inSection: section];
        Folder *folder = [results objectAtIndexPath: path];
        if(!folder.sticky)
            return(path);
    }
    return(src);
}


// NSFetchedResultsControllerDelegate

- (void) controllerWillChangeContent: (NSFetchedResultsController*) fetcher
{
    [self.tableView beginUpdates];
}

- (void) controllerDidChangeContent: (NSFetchedResultsController*) fetcher
{
    [self.tableView endUpdates];
}

- (void) controller: (NSFetchedResultsController*) fetcher
    didChangeObject: (id) object
        atIndexPath: (NSIndexPath*) path
      forChangeType: (NSFetchedResultsChangeType) type
       newIndexPath: (NSIndexPath*) newPath
{
    UITableView *view = self.tableView;
    switch(type) {
    case NSFetchedResultsChangeInsert:
        [view insertRowsAtIndexPaths: [NSArray arrayWithObject: newPath]
              withRowAnimation: UITableViewRowAnimationFade];
        break;

    case NSFetchedResultsChangeDelete:
        [view deleteRowsAtIndexPaths: [NSArray arrayWithObject: path]
              withRowAnimation: UITableViewRowAnimationFade];
        break;

    case NSFetchedResultsChangeUpdate: {
        UITableViewCell *cell = [view cellForRowAtIndexPath: path];
        if(cell)
            [self configureCell: cell
                  atIndexPath: path];
        break;
    }

    case NSFetchedResultsChangeMove:
        [view deleteRowsAtIndexPaths: [NSArray arrayWithObject: path]
              withRowAnimation: UITableViewRowAnimationFade];
        [view insertRowsAtIndexPaths: [NSArray arrayWithObject: newPath]
              withRowAnimation: UITableViewRowAnimationFade];
        break;
    }
}

- (void) controller: (NSFetchedResultsController*) fetcher
   didChangeSection: (id <NSFetchedResultsSectionInfo>) info
            atIndex: (NSUInteger) idx
      forChangeType: (NSFetchedResultsChangeType) type
{
    UITableView *view = self.tableView;
    NSIndexSet *sections = [NSIndexSet indexSetWithIndex: idx];

    switch(type) {
    case NSFetchedResultsChangeInsert:
        [view insertSections: sections
              withRowAnimation: UITableViewRowAnimationFade];
        break;

    case NSFetchedResultsChangeDelete:
        [view deleteSections: sections
              withRowAnimation:UITableViewRowAnimationFade];
        break;
    }
}

@end
