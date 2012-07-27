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

#import "FolderSelectController.h"
#import "Folder.h"

#define DEBUG_MODULE FolderSelect
#import "util.h"


@interface NSObject ()
- (void) folderSelectController: (FolderSelectController*) sel
                didSelectFolder: (Folder*) folder;
@end


@implementation FolderSelectController

@synthesize delegate, context, folder;

- (id) init
{
    self = [super initWithStyle: UITableViewStylePlain];
    if(!self)
        return(nil);

    self.title = @"Folders";
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

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem =
        [[[UIBarButtonItem alloc]
             initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
             target: self
             action: @selector(cancel)]
            autorelease];
    if(!results)
        [self initFetch];
}

- (void) cleanup
{
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
    [folder release];
    folder = nil;
    [super dealloc];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    if(folder) {
        NSIndexPath *path = [results indexPathForObject: folder];
        if(path)
            [self.tableView selectRowAtIndexPath: path
                     animated: animated
                     scrollPosition: UITableViewScrollPositionMiddle];
        else {
            assert(0);
            self.folder = nil;
        }
    }
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) cancel
{
    [delegate folderSelectController: self
              didSelectFolder: nil];
}


// UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView: (UITableView*) view
{
    return(results.sections.count);
}

- (NSInteger) tableView: (UITableView*) view
  numberOfRowsInSection: (NSInteger) idx
{
    NSArray *sections = results.sections;
    if(idx < sections.count)
        return([[sections objectAtIndex: idx]
                   numberOfObjects]);
    return(0);
}

- (void) configureCell: (UITableViewCell*) cell
           atIndexPath: (NSIndexPath*) path
{
    Folder *_folder = [results objectAtIndexPath: path];
    assert(_folder.index == path.row);
    cell.textLabel.text = _folder.name;

    UITableViewCellSelectionStyle style;
    if(_folder == folder)
        style = UITableViewCellSelectionStyleGray;
    else
        style = UITableViewCellSelectionStyleBlue;
    cell.selectionStyle = style;
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
    }
    [self configureCell: cell
          atIndexPath: path];
    return(cell);
}


// UITableViewDelegate

- (void)        tableView: (UITableView*) view
  didSelectRowAtIndexPath: (NSIndexPath*) path
{
    self.folder = [results objectAtIndexPath: path];
    [delegate folderSelectController: self
              didSelectFolder: folder];
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
