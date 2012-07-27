//------------------------------------------------------------------------
//  Copyright 2009-2011 (c) Jeff Brown <spadix@users.sourceforge.net>
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

#import "BarcodeListController.h"
#import "BarcodeDetailController.h"
#import "TintedBarButtonItem.h"
#import "Folder.h"
#import "Barcode.h"
#import "BarcodeEmail.h"
#import "util.h"


@implementation BarcodeListController

@synthesize context, folder;

- (id) initWithFolder: (Folder*) _folder
{
    self = [super initWithStyle: UITableViewStylePlain];
    if(!self)
        return(nil);

    savedRow = -1;
    folder = [_folder retain];
    context = [[_folder managedObjectContext]
                  retain];
    self.title = _folder.name;
    return(self);
}

- (void) initFetch
{
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:
        [NSEntityDescription entityForName: @"Barcode"
                             inManagedObjectContext: context]];
    [request setPredicate:
        [NSPredicate predicateWithFormat: @"folder == %@", folder]];
    [request setSortDescriptors:
        [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey: @"date"
                              ascending: NO]]];

    NSString *cache = (folder.index) ? nil : @"Barcodes: Unfiled Barcodes";
    results = [[NSFetchedResultsController alloc]
                  initWithFetchRequest: request
                  managedObjectContext: context
                  sectionNameKeyPath: nil
                  cacheName: cache];
    results.delegate = self;

    [request release];

    NSError *error = nil;
    if(![results performFetch: &error])
        [error logWithMessage: @"fetching barcodes"];
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

    view.rowHeight = 64.0;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    clearButton = [[TintedBarButtonItem alloc]
                      initWithTitle: @"Clear"
                      target: self
                      action: @selector(clearAll:)
                      tintColor: [UIColor colorWithRed: 189 / 255.
                                          green: 20 / 255.
                                          blue: 33 / 255.
                                          alpha: 1]];

    dateFormat = [NSDateFormatter new];
    [dateFormat setDateStyle: NSDateFormatterShortStyle];
    [dateFormat setTimeStyle: NSDateFormatterShortStyle];

    self.toolbarItems =
        [NSArray arrayWithObjects:
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem: UIBarButtonSystemItemCompose
                 target: self
                 action: @selector(sendEmail)]
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
                 action: @selector(addBarcode)]
                autorelease],
            nil];

    if(!results)
        [self initFetch];
}

- (void) addBarcode
{
    UIActionSheet *confirm =
        [[UIActionSheet alloc]
            initWithTitle: @"Add Barcode"
            delegate: self
            cancelButtonTitle: @"Cancel"
            destructiveButtonTitle: nil
            otherButtonTitles:
                @"Scan from image file",
                nil];
    [confirm showInView: self.navigationController.view];
    [confirm release];
}

- (void) cleanup
{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    self.toolbarItems = nil;
    if(observing) {
        for(NSObject *object in observing) {
            @try {
                [object removeObserver: self
                        forKeyPath: @"thumb"];
            }
            @catch(...) { }
        }
        [observing release];
        observing = nil;
    }
    [clearButton release];
    clearButton = nil;
    [results release];
    results = nil;
    [dateFormat release];
    dateFormat = nil;
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
    [folder release];
    folder = nil;
    [super dealloc];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];

    UITableView *view = self.tableView;
    int lastRow = [self rows] - 1;
    if(savedRow > lastRow)
        savedRow = lastRow;
    if(savedRow >= 0) {
        BOOL found = NO;
        NSArray *visibleRows = [view indexPathsForVisibleRows];
        for(NSIndexPath *path in visibleRows)
            if(found = (path.row == savedRow))
                break;
        if(!found) {
            int rows = [self rows];
            if(savedRow >= rows)
                savedRow = rows - 1;
            [view scrollToRowAtIndexPath:
                      [NSIndexPath indexPathForRow: savedRow
                                   inSection: 0]
                  atScrollPosition: UITableViewScrollPositionMiddle
                  animated: NO];
        }
    }
    savedRow = -1;
}

- (void) savePosition
{
    if(savedRow >= 0)
        return;
    UITableView *view = self.tableView;
    if(!view)
        return;
    NSArray *paths = [view indexPathsForVisibleRows];
    int n = paths.count;
    if(!paths || !n)
        return;
    NSIndexPath *path = [paths objectAtIndex: 0];
    if(!path.row) {
        savedRow = 0;
        return;
    }
    path = [paths lastObject];
    int lastRow = [self rows] - 1;
    if(path.row >= lastRow) {
        savedRow = lastRow;
        return;
    }
    path = [paths objectAtIndex: n / 2];
    savedRow = path.row;
}

- (void) viewWillDisappear: (BOOL) animated
{
    [self savePosition];
    [super viewWillDisappear: animated];
}

- (void) viewDidDisappear: (BOOL) animated
{
    [super viewDidDisappear: animated];
    [self setEditing: NO
          animated: NO];
}

- (void) showDetailFor: (Barcode*) barcode
              animated: (BOOL) animated
{
    UINavigationController *nav = self.navigationController;
    [nav popToViewController: self
         animated: NO];
    BarcodeDetailController *detail =
        [[BarcodeDetailController alloc]
            initWithBarcode: barcode];
    [nav pushViewController: detail
         animated: animated];
    [detail release];
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

- (void) clearAll: (UISegmentedControl*) clearSegs
{
    UIActionSheet *confirm =
        [[UIActionSheet alloc]
            initWithTitle: @"Erase folder contents?"
            delegate: self
            cancelButtonTitle: @"Cancel"
            destructiveButtonTitle: @"Delete All"
            otherButtonTitles: nil];
    [confirm showInView: self.navigationController.view];
    [confirm release];
}

- (void) sendEmail
{
    BarcodeEmail *email =
        [[BarcodeEmail alloc]
            initWithIntro: @"These are the barcodes"];

    for(Barcode *barcode in [results fetchedObjects])
        [email addBarcode: barcode];

    NSString *subject = @"Barcodes";

    [self.view.window.rootViewController
         presentModalViewController:
             [email mailerWithSubject: subject]
         animated: YES];
    [email release];
}


// PersistentState

- (id) saveState
{
    [self savePosition];
    NSManagedObjectID *pid = [folder objectID];
    assert(pid);
    assert(![pid isTemporaryID]);
    if(!pid || [pid isTemporaryID])
        return(nil);

    NSMutableDictionary *state =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
            NSStringFromClass([self class]), @"class",
            [NSNumber numberWithInteger: savedRow], @"row",
            [[pid URIRepresentation] absoluteString], @"folder",
            nil];
    return(state);
}

- (BOOL) restoreState: (id) state
{
    if(!state ||
       ![state isKindOfClass: [NSDictionary class]])
        return(NO);

    NSNumber *row = [state objectForKey: @"row"];
    if(row && [row isKindOfClass: [NSNumber class]])
        savedRow = [row intValue];

    NSString *url = [state objectForKey: @"folder"];
    if(!url || ![url isKindOfClass: [NSString class]])
        return(NO);

    NSManagedObjectID *pid =
        [[context persistentStoreCoordinator]
            managedObjectIDForURIRepresentation:
                [NSURL URLWithString: url]];
    if(!pid)
        return(NO);

    NSError *err = nil;
    Folder *_folder = (id)[context existingObjectWithID: pid
                                   error: &err];
    if(!_folder)
        [err logWithMessage: @"fetching barcode"];
    else
        DBLog(@"restored folder=%@", _folder);

    if([_folder isKindOfClass: [Folder class]]) {
        folder = [_folder retain];
        self.title = _folder.name;
    }

    return(!!folder);
}

// UIActionSheetDelegate

- (void)   actionSheet: (UIActionSheet*) confirm
  clickedButtonAtIndex: (NSInteger) idx
{
    if(idx == confirm.destructiveButtonIndex) {
        for(Barcode *barcode in results.fetchedObjects)
            [context deleteObject: barcode];

        [self setEditing: NO
              animated: YES];
    }
    else if(idx == confirm.firstOtherButtonIndex)
        [[UIApplication sharedApplication].delegate
            performSelector: @selector(scanFromPhoto)];
}

// UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView: (UITableView *) view
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
    Barcode *barcode = [results objectAtIndexPath: path];
    assert(barcode.data);
    cell.textLabel.text = barcode.title;
    cell.detailTextLabel.text = barcode.classificationText;

    UIImageView *imageView = cell.imageView;
    if(barcode.thumb)
        imageView.image = barcode.thumb;
    else {
        if(!observing)
            observing = [NSMutableSet new];
        if(![observing containsObject: barcode]) {
            [observing addObject: barcode];
            [barcode addObserver: self
                     forKeyPath: @"thumb"
                     options: 0
                     context: NULL];
        }
    }
}

- (UITableViewCell*) tableView: (UITableView*) view
         cellForRowAtIndexPath: (NSIndexPath*) path
{
    UITableViewCell *cell =
        [view dequeueReusableCellWithIdentifier: @"Barcode"];
    if(!cell) {
        cell = [[[UITableViewCell alloc]
                    initWithStyle: UITableViewCellStyleSubtitle
                    reuseIdentifier: @"Barcode"]
                   autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *imageView = cell.imageView;
        imageView.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleHeight);
        imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    [self configureCell: cell
          atIndexPath: path];
    return(cell);
}

// UITableViewDelegate

- (void)        tableView: (UITableView*) view
  didSelectRowAtIndexPath: (NSIndexPath*) path
{
    savedRow = path.row;
    [self showDetailFor: [results objectAtIndexPath: path]
          animated: YES];
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

- (void)   tableView: (UITableView*) view
  commitEditingStyle: (UITableViewCellEditingStyle) style
   forRowAtIndexPath: (NSIndexPath*) path
{
    if(style != UITableViewCellEditingStyleDelete)
        return;

    [context deleteObject: [results objectAtIndexPath: path]];
    [UIApplication saveAfterDelay: 0.01];
}


- (void) observeValueForKeyPath: (NSString*) key
                       ofObject: (id) object
                         change: (NSDictionary*) change
                        context: (void*) ctx
{
    assert(observing && [observing containsObject: object]);
    [observing removeObject: object];
    @try {
        [object removeObserver: self
                forKeyPath: key];
    }
    @catch(...) { }

    NSIndexPath *path = nil;
    UITableViewCell *cell = nil;
    @try {
        path = [results indexPathForObject: object];
        cell = [self.tableView cellForRowAtIndexPath: path];
    }
    @catch(...) { }

    if(!path || !cell)
        return;

    [self configureCell: cell
          atIndexPath: path];
    [cell setNeedsLayout];
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
        if(self.navigationController.visibleViewController != self)
            savedRow = newPath.row;
        break;

    case NSFetchedResultsChangeDelete:
        [view deleteRowsAtIndexPaths: [NSArray arrayWithObject: path]
              withRowAnimation: UITableViewRowAnimationFade];
        break;

    case NSFetchedResultsChangeUpdate:
        [self configureCell: [view cellForRowAtIndexPath: path]
              atIndexPath: path];
        break;

    case NSFetchedResultsChangeMove:
        [view deleteRowsAtIndexPaths: [NSArray arrayWithObject: path]
              withRowAnimation: UITableViewRowAnimationFade];
        [view reloadSections: [NSIndexSet indexSetWithIndex: newPath.section]
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
