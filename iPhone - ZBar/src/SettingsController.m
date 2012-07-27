//------------------------------------------------------------------------
//  Copyright 2011 (c) Lisa Huang <lisah000@users.sourceforge.net>
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

#import "SettingsController.h"
#import "SettingsCell.h"

@interface NSObject ()
- (void) settingsController: (SettingsController *)settings
         didDismissWithSave: (BOOL) save;
@end

@implementation SettingsController
@synthesize delegate, completion, object, autoDismiss;

- (SettingsCell*) cellForSchema: (NSDictionary*) cellSchema
{
    NSString *cellType = [cellSchema objectForKey: @"type"];
    Class cellClass = NSClassFromString(cellType);
    if(!cellClass)
        cellClass = [SettingsCell class];

    SettingsCell *cell = [[cellClass alloc]
                             initWithObject: object
                             schema: cellSchema];
    if(!cell)
        return(nil);

    cell.textLabel.text = [cellSchema objectForKey: @"title"];
    return([cell autorelease]);
}

- (void) initSections
{
    NSArray* sschema = [schema objectForKey: @"sections"];

    sections = [[NSMutableArray alloc]
                   initWithCapacity: sschema.count];

    for(NSDictionary* sec in sschema) {
        NSArray *cschema = [sec objectForKey: @"cells"];
        NSMutableArray *cells =
            [NSMutableArray arrayWithCapacity: cschema.count];

        for(NSDictionary* cell in cschema) {
            SettingsCell *sc = [self cellForSchema: cell];
            assert(sc);
            if(sc)
                [cells addObject: sc];
        }

        [sections addObject: cells];
    }
}

- (void) save: (id) sender
{
    if(delegate)
        [delegate settingsController: self
                  didDismissWithSave: YES];
    if(completion)
        completion(self, YES);
}

- (void) cancel: (id) sender
{
    if(delegate)
        [delegate settingsController: self
                  didDismissWithSave: NO];
    if(completion)
        completion(self, NO);
}

- (id) initWithObject: (NSObject*) _object
               schema: (NSDictionary*) _schema
{
    if(self = [super initWithStyle: UITableViewStyleGrouped]) {
        object = [_object retain];
        schema = [_schema retain];
        self.title = [schema objectForKey: @"title"];
    }
    return(self);
}

- (id) initWithObject: (NSObject*) _object
           schemaName: (NSString*) schemaName
{
    NSString* schemaPath =
        [[NSBundle mainBundle]
            pathForResource: schemaName
            ofType: @"plist"];
    NSDictionary* _schema =
        [NSDictionary dictionaryWithContentsOfFile: schemaPath];

    return([self initWithObject: _object
                 schema: _schema]);
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // Only display cancel and save button for top view controller
    if([self.navigationController.viewControllers objectAtIndex: 0] == self) {
        UINavigationItem *nav = self.navigationItem;

        UIBarButtonItem *btn =
            [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                target: self
                action: @selector(cancel:)];
        nav.leftBarButtonItem = btn;
        [btn release];

        if(!autoDismiss) {
            save = [[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem: UIBarButtonSystemItemSave
                       target: self
                       action: @selector(save:)];
            nav.rightBarButtonItem = save;
        }
    }

    [self initSections];
}

- (void) cleanup
{
    UINavigationItem *navit = self.navigationItem;
    navit.leftBarButtonItem = nil;
    navit.rightBarButtonItem = nil;
    [sections release];
    sections = nil;
    [save release];
    save = nil;
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (void) dealloc
{
    [self cleanup];
    [completion release];
    completion = nil;
    [object release];
    object = nil;
    [schema release];
    schema = nil;
    [super dealloc];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

// UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView: (UITableView *) view
{
    return(sections.count);
}

- (NSInteger) tableView: (UITableView*) view
  numberOfRowsInSection: (NSInteger) idx
{
    NSArray* cells = [sections objectAtIndex: idx];
    return(cells.count);
}

- (NSString*)   tableView: (UITableView*) view
  titleForHeaderInSection: (NSInteger) idx
{
    NSArray* sschema = [schema objectForKey: @"sections"];
    NSDictionary* section = [sschema objectAtIndex: idx];

    return([section objectForKey: @"title"]);
}

- (UITableViewCell*) tableView: (UITableView*) view
         cellForRowAtIndexPath: (NSIndexPath*) path
{
    return([[sections objectAtIndex: path.section] objectAtIndex: path.row]);
}

// UITableViewDelegate

- (void)        tableView: (UITableView*) view
  didSelectRowAtIndexPath: (NSIndexPath*) path
{
    SettingsCell *cell = (id)[view cellForRowAtIndexPath: path];
    [cell settingsControllerDidSelectCell: self];

    if(autoDismiss) {
        UINavigationController *nav = self.navigationController;
        if([nav.viewControllers objectAtIndex: 0] == self)
            [self save: nil];
        else
            [nav popViewControllerAnimated: YES];
    }
}

@end

