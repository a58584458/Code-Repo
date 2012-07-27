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

#import "BarcodeDetailController.h"
#import "FolderSelectController.h"
#import "SettingsController.h"
#import "TextEditController.h"
#import "Settings.h"
#import "Barcode.h"
#import "Action.h"
#import "BarcodeEmail.h"

#define DEBUG_MODULE Detail
#import "util.h"

enum {
    DATA_SECTION = 0,
    ACTION_SECTION,
    NUM_SECTIONS
};


@implementation BarcodeDetailController

@synthesize context, barcode;

- (id) init
{
    return([self initWithBarcode: nil]);
}

- (id) initWithBarcode: (Barcode*) _barcode
{
    self = [super initWithStyle: UITableViewStyleGrouped];
    if(!self)
        return(nil);

    editRow = -1;
    if(_barcode) {
        barcode = [_barcode retain];
        context = [[_barcode managedObjectContext] retain];
    }

    self.title = @"Barcode Detail";
    self.navigationItem.backBarButtonItem =
        [[[UIBarButtonItem alloc]
             initWithTitle: @"Barcode"
             style: UIBarButtonItemStyleBordered
             target: nil
             action: nil]
            autorelease];

    return(self);
}

- (void) initActions
{
    UITableView *view = self.tableView;
    BOOL prevHadActions =
      [self numberOfSectionsInTableView: view] > ACTION_SECTION;

    [actions release];
    actions = nil;
    assert(barcode);

    if(!self.editing && barcode)
        actions = [barcode applyActions];
    else
        actions = [Action allActions];
    [actions retain];

    NSIndexSet *sections = [NSIndexSet indexSetWithIndex: ACTION_SECTION];
    BOOL nextHasActions =
      [self numberOfSectionsInTableView: view] > ACTION_SECTION;
    if(prevHadActions && nextHasActions)
        [view reloadSections: sections
              withRowAnimation: UITableViewRowAnimationFade];
    else if(nextHasActions)
        [view insertSections: sections
              withRowAnimation: UITableViewRowAnimationFade];
    else if(prevHadActions)
        [view deleteSections: sections
              withRowAnimation: UITableViewRowAnimationFade];
}

- (void) initHeader
{
    UITableView *view = self.tableView;
    CGFloat width = view.bounds.size.width;

    UIView *header = [[UIView alloc]
                         initWithFrame: CGRectMake(0, 0, width, 88)];
    header.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    thumb = [[UIImageView alloc]
                initWithFrame: CGRectMake(8, 8, 64, 64)];
    thumb.backgroundColor = [UIColor whiteColor];
    thumb.contentMode = UIViewContentModeScaleAspectFill;
    CALayer *layer = thumb.layer;
    layer.masksToBounds = YES;
    layer.cornerRadius = 8;
    layer.borderWidth = 1;
    layer.borderColor = [UIColor lightGrayColor].CGColor;
    [header addSubview: thumb];

    CGFloat w = width - 88;
    titleButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    titleButton.frame = CGRectMake(80, 8, w, 44);
    titleButton.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    titleButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleButton.contentHorizontalAlignment =
        UIControlContentHorizontalAlignmentLeft;
    titleButton.alpha = 0;
    titleButton.enabled = NO;
    UILabel *label = titleButton.titleLabel;
    label.font = [UIFont boldSystemFontOfSize: 20];
    label.numberOfLines = 0;
    [header addSubview: titleButton];
    [titleButton retain];

    [titleButton addTarget: self
                 action: @selector(showTitleEditor)
                 forControlEvents: UIControlEventTouchUpInside];

    titleLabel = [[UILabel alloc]
                initWithFrame: CGRectMake(80, 8, w, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    titleLabel.font = [UIFont boldSystemFontOfSize: 19];
    titleLabel.numberOfLines = 0;
    [header addSubview: titleLabel];

    typeLabel = [[UILabel alloc]
                    initWithFrame: CGRectMake(80, 58, w / 3, 14)];
    typeLabel.backgroundColor = [UIColor clearColor];
    typeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    typeLabel.font = [UIFont systemFontOfSize: 13];
    [header addSubview: typeLabel];

    w = (int)w * 2 / 3 - 8;
    dateLabel = [[UILabel alloc]
                    initWithFrame: CGRectMake(width - w - 8, 58, w, 14)];
    dateLabel.backgroundColor = [UIColor clearColor];
    dateLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    dateLabel.font = [UIFont systemFontOfSize: 13];
    dateLabel.textAlignment = UITextAlignmentRight;
    [header addSubview: dateLabel];

    view.tableHeaderView = header;
    [header release];
}

- (void) viewDidLoad
{
    [super viewDidLoad];

    // workaround bug in super
    BOOL editing = self.editing;
    UITableView *view = self.tableView;
    if(view.editing != editing)
        view.editing = editing;

    UINavigationItem *navit = self.navigationItem;
    navit.rightBarButtonItem = self.editButtonItem;
    view.allowsSelectionDuringEditing = YES;

    [self initHeader];

    dataCell = [[UITableViewCell alloc]
                   initWithStyle: UITableViewCellStyleDefault
                   reuseIdentifier: nil];
    dataCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    UILongPressGestureRecognizer *press =
        [[UILongPressGestureRecognizer alloc]
	    initWithTarget: self
	    action: @selector(didLongPress:)];
    [dataCell addGestureRecognizer: press];
    [press release];

    UILabel *label = dataCell.textLabel;
    label.font = [UIFont systemFontOfSize: 18];
    label.lineBreakMode = UILineBreakModeCharacterWrap;
    label.numberOfLines = 3;

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
                 initWithBarButtonSystemItem: UIBarButtonSystemItemOrganize
                 target: self
                 action: @selector(organize)]
                autorelease],
            nil];

    dateFormat = [NSDateFormatter new];
    [dateFormat setDateStyle: NSDateFormatterShortStyle];
    [dateFormat setTimeStyle: NSDateFormatterShortStyle];
}

- (void) cleanup
{
    self.toolbarItems = nil;
    [thumb release];
    thumb = nil;
    [titleButton release];
    titleButton = nil;
    [titleLabel release];
    titleLabel = nil;
    [typeLabel release];
    typeLabel = nil;
    [dateLabel release];
    dateLabel = nil;
    [dataCell release];
    dataCell = nil;
    [actions release];
    actions = nil;
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
    [barcode release];
    barcode = nil;
    [context release];
    context = nil;
    [self cleanup];
    [super dealloc];
}

- (void) didLongPress: (UIGestureRecognizer*) press
{
    if(press.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];

        UIMenuController *theMenu = [UIMenuController sharedMenuController];
        [theMenu setTargetRect:dataCell.frame inView:self.view];
        [theMenu setMenuVisible:YES animated:YES];
    }
}

- (BOOL) canBecomeFirstResponder
{
    return(YES);
}

- (void) copy: (id) sender
{
    UIPasteboard *gpBoard = [UIPasteboard generalPasteboard];
    gpBoard.string = dataCell.textLabel.text;
}

- (void) updateData
{
    NSString *name = barcode.title;
    NSString *data = barcode.data;

    titleLabel.text = name;
    [titleButton setTitle: name
                 forState: UIControlStateNormal];
    thumb.image = barcode.thumb;

    dataCell.textLabel.text = data;
    [dataCell setNeedsLayout];

    typeLabel.text =
        [ZBarSymbol nameForType: [barcode.type intValue]];
    dateLabel.text =
        [dateFormat stringForObjectValue: barcode.date];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];

    assert(barcode);

    [barcode addObserver: self
             forKeyPath: @"name"
             options: 0
             context: NULL];
    [barcode addObserver: self
             forKeyPath: @"thumb"
             options: NSKeyValueObservingOptionInitial
             context: NULL];

    [self initActions];
}

- (void) viewWillDisappear: (BOOL) animated
{
    @try {
        [barcode removeObserver: self
                 forKeyPath: @"thumb"];
    }
    @catch(...) { }
    @try {
        [barcode removeObserver: self
                 forKeyPath: @"name"];
    }
    @catch(...) { }
    [super viewWillDisappear: animated];
}


- (id) saveState
{
    NSManagedObjectID *pid = [barcode objectID];
    assert(pid);
    assert(![pid isTemporaryID]);
    if(!pid || [pid isTemporaryID])
        return(nil);

    NSMutableDictionary *state =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
            NSStringFromClass([self class]), @"class",
            [[pid URIRepresentation] absoluteString], @"barcode",
            nil];
    return(state);
}

- (BOOL) restoreState: (id) state
{
    if(!state || !context ||
       ![state isKindOfClass: [NSDictionary class]])
        return(NO);

    NSString *url = [state objectForKey: @"barcode"];
    if(!url || ![url isKindOfClass: [NSString class]])
        return(NO);

    NSManagedObjectID *pid =
        [[context persistentStoreCoordinator]
            managedObjectIDForURIRepresentation:
                [NSURL URLWithString: url]];
    if(!pid)
        return(NO);

    NSError *err = nil;
    Barcode *_barcode = (id)[context existingObjectWithID: pid
                                     error: &err];
    if(!_barcode)
        [err logWithMessage: @"fetching barcode"];
    else
        DBLog(@"restored barcode=%@", _barcode);

    if([_barcode isKindOfClass: [Barcode class]])
        barcode = [_barcode retain];

    return(!!barcode);
}

- (void) observeValueForKeyPath: (NSString*) key
                       ofObject: (id) object
                         change: (NSDictionary*) change
                        context: (void*) ctx
{
    [self updateData];
}

- (void) showLinkDetailForRow: (NSInteger) row
{
    Action *action = nil;
    int n = actions.count;
    if(row < 0 || row >= n) {
        editRow = n;
        action = [LinkAction new];
    }
    else {
        editRow = row;
        action = [[actions objectAtIndex: row]
                     copy];
    }

    SettingsController *detail =
        [[SettingsController alloc]
            initWithObject: action
            schemaName: @"editlink"];
    [action release];
    detail.delegate = self;

    UINavigationController *nav =
        [[UINavigationController alloc]
            initWithRootViewController: detail];
    [detail release];

    [self.view.window.rootViewController
         adPresentModalViewController: nav
         animated: YES];
    [nav release];
}

- (void) settingsController: (SettingsController*) settings
         didDismissWithSave: (BOOL) save
{
    assert(editRow >= 0);
    if(save) {
        NSMutableArray *allActions = [Action allActions];
        NSObject *action = settings.object;
        if(editRow < 0 || editRow >= allActions.count)
            [allActions addObject: action];
        else
            [allActions replaceObjectAtIndex: editRow
                        withObject: action];
    }

    [settings.view.window.rootViewController
         adDismissModalViewController: settings.navigationController
         animated: YES];
    editRow = -1;
}

- (void) showTitleEditor
{
    TextEditController *editor =
        [[TextEditController alloc]
            initWithObject: barcode
            keyPath: @"name"];
    editor.title = @"Edit Description";

    [self.navigationController
         pushViewController: editor
         animated: YES];
    [editor release];
}

- (void) setEditing: (BOOL) editing
           animated: (BOOL) animated
{
    BOOL toggle = (self.editing != editing);
    [super setEditing: editing
           animated: animated];
    if(!toggle)
        return;

    [self.navigationItem setHidesBackButton: editing
         animated: animated];
    [self.navigationController
         setToolbarHidden: editing
         animated: animated];

    [self initActions];

    if(animated)
        [UIView beginAnimations: nil
                context: nil];
    titleLabel.alpha = !editing;
    titleButton.alpha = editing;
    titleButton.enabled = editing;

    dataCell.accessoryType =
        ((editing)
         ? UITableViewCellAccessoryNone
         : UITableViewCellAccessoryDisclosureIndicator);
    if(animated)
        [UIView commitAnimations];

    if(!editing) {
        [Action saveActions];
        [UIApplication saveAfterDelay: 0];
    }
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) sendEmail
{
    BarcodeEmail *email =
        [[BarcodeEmail alloc]
            initWithIntro: @"This is a barcode"];
    email.enableCSV = NO;

    [email addBarcode: barcode];

    NSString *subject = barcode.name;
    if(!subject || !subject.length)
        subject = [NSString stringWithFormat: @"Barcode: %@", barcode.data];

    [self.view.window.rootViewController
         presentModalViewController:
             [email mailerWithSubject: subject]
         animated: YES];
    [email release];
}

- (void) organize
{
    FolderSelectController *sel = [FolderSelectController new];
    sel.delegate = self;
    sel.context = context;
    sel.folder = barcode.folder;
    sel.navigationItem.prompt = @"Move this barcode to a new folder";

    UINavigationController *nav =
        [[UINavigationController alloc]
            initWithRootViewController: sel];
    [sel release];

    [self.view.window.rootViewController
         adPresentModalViewController: nav
         animated: YES];
    [nav release];
}


// FolderSelectControllerDelegate (informal)

- (void) folderSelectController: (FolderSelectController*) sel
                didSelectFolder: (Folder*) folder
{
    if(folder && folder != barcode.folder) {
        barcode.folder = folder;
        [self.navigationController popViewControllerAnimated: NO];
    }

    [sel.view.window.rootViewController
         adDismissModalViewController: sel.navigationController
         animated: YES];
}


// UITableViewDelegate

- (NSIndexPath*) tableView: (UITableView*) view
  willSelectRowAtIndexPath: (NSIndexPath*) path
{
    NSInteger row = path.row;
    if(self.editing &&
       (path.section == DATA_SECTION ||
        ((row < actions.count) &&
         !((Action*)[actions objectAtIndex: row]).canEdit)))
        return(nil);
    return(path);
}

- (void)        tableView: (UITableView*) view
  didSelectRowAtIndexPath: (NSIndexPath*) path
{
    int row = path.row;

    switch(path.section) {
    case DATA_SECTION: {
        assert(!row);
        assert(!self.editing);
        TextEditController *detail =
            [[TextEditController alloc]
                initWithObject: barcode
                keyPath: @"data"];
        detail.editable = NO;

        [self.navigationController
             pushViewController: detail
             animated: YES];
        [detail release];
        break;
    }

    case ACTION_SECTION: {
        int rows = actions.count;
        if(!self.editing) {
            assert(row < rows);
            Action *action = [actions objectAtIndex: row];
            UINavigationController *nav = self.navigationController;
            if(![action activateWithNavigationController: nav
                        animated: YES])
                [view deselectRowAtIndexPath: path
                      animated: YES];
        }
        else {
            assert(row <= rows);
            [self showLinkDetailForRow: (row < rows) ? row : -1];
        }
        break;
    }

    default:
        assert(0);
    }
}

- (UITableViewCellEditingStyle) tableView: (UITableView*) view
            editingStyleForRowAtIndexPath: (NSIndexPath*) path
{
    NSInteger row = path.row;
    if(!self.editing || path.section != ACTION_SECTION ||
       ((row < actions.count) &&
        !((Action*)[actions objectAtIndex: row]).canEdit))
        return(UITableViewCellEditingStyleNone);
    else if(row < actions.count)
        return(UITableViewCellEditingStyleDelete);
    else
        return(UITableViewCellEditingStyleInsert);
}

- (NSIndexPath*)                 tableView: (UITableView*) view
  targetIndexPathForMoveFromRowAtIndexPath: (NSIndexPath*) src
                       toProposedIndexPath: (NSIndexPath*) dst
{
    assert(src.section == ACTION_SECTION);
    if(dst.section < ACTION_SECTION)
        return([NSIndexPath indexPathForRow: 0
                            inSection: ACTION_SECTION]);

    int rows = actions.count;
    if(dst.row >= rows)
        return([NSIndexPath indexPathForRow: rows - 1
                            inSection: ACTION_SECTION]);
    return(dst);
}

- (CGFloat)     tableView: (UITableView*) view
  heightForRowAtIndexPath: (NSIndexPath*) path
{
  if(path.section != DATA_SECTION)
    return(44);

  UILabel *label = dataCell.textLabel;
    CGSize size =
      CGSizeMake(view.bounds.size.width - 60, label.font.pointSize * 3.5);
    size = [label.text
               sizeWithFont: label.font
               constrainedToSize: size
               lineBreakMode: UILineBreakModeCharacterWrap];
    size.height += 16;
    if(size.height < 44)
      size.height = 44;
    return(size.height);
}


// UITableViewDataSource

- (NSInteger) numberOfSectionsInTableView: (UITableView *) view
{
    if(actions && actions.count)
        return(NUM_SECTIONS);
    return(NUM_SECTIONS - 1);
}

- (NSInteger) tableView: (UITableView*) view
  numberOfRowsInSection: (NSInteger) idx
{
    int rows;
    switch(idx) {
    case DATA_SECTION:
        return(1);

    case ACTION_SECTION:
        rows = actions.count;
        if(self.editing)
            rows++;
        return(rows);

    default:
        assert(0);
    }
    return(0);
}

- (UITableViewCell*) tableView: (UITableView*) view
         cellForRowAtIndexPath: (NSIndexPath*) path
{
    if(path.section == DATA_SECTION)
        return(dataCell);
    assert(path.section == ACTION_SECTION);

    NSString *ruid = @"BarcodeDetail";
    UITableViewCell *cell = [view dequeueReusableCellWithIdentifier: ruid];
    if(!cell)
        cell = [[[UITableViewCell alloc]
                    initWithStyle: UITableViewCellStyleSubtitle
                    reuseIdentifier: ruid]
                   autorelease];

    int selectionStyle = UITableViewCellSelectionStyleBlue;
    UIView *accView = nil;
    int row = path.row;
    if(row < actions.count) {
        Action *action = [actions objectAtIndex: path.row];
        cell.textLabel.text = action.name;

        if(!action.canEdit)
            selectionStyle = UITableViewCellSelectionStyleNone;

        ActionOpenMode openMode = action.openMode;
        if(openMode == ActionOpenModeExternal ||
           (openMode == ActionOpenModeDefault &&
            ![Settings globalSettings].enableBrowser))
            accView = [[[UIImageView alloc]
                           initWithImage: [UIImage imageNamed: @"external"]]
                          autorelease];
    }
    else
        cell.textLabel.text = @"Add new link";

    cell.selectionStyle = selectionStyle;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.accessoryView = accView;

    return(cell);
}

- (NSString*)   tableView: (UITableView*) view
  titleForHeaderInSection: (NSInteger) idx
{
    if(idx == ACTION_SECTION && actions.count) {
        NSString *detail = barcode.classificationText;
        if(detail && detail.length)
            return([@"Found " stringByAppendingString: detail]);
    }
    return(nil);
}

- (BOOL)      tableView: (UITableView*) view
  canEditRowAtIndexPath: (NSIndexPath*) path
{
    return(path.section == ACTION_SECTION);
}

- (void)   tableView: (UITableView*) view
  commitEditingStyle: (UITableViewCellEditingStyle) style
   forRowAtIndexPath: (NSIndexPath*) path
{
    assert(path.section == ACTION_SECTION);
    if(style == UITableViewCellEditingStyleDelete) {
        NSMutableArray *allActions = [Action allActions];
        assert(actions == allActions);
        [allActions removeObjectAtIndex: path.row];
        [view deleteRowsAtIndexPaths: [NSArray arrayWithObject: path]
              withRowAnimation: UITableViewRowAnimationFade];
    }
    else if(style == UITableViewCellEditingStyleInsert)
        [self showLinkDetailForRow: -1];
}

- (BOOL)      tableView: (UITableView*) view
  canMoveRowAtIndexPath: (NSIndexPath*) path
{
    return(path.section == ACTION_SECTION &&
           path.row < actions.count);
}

- (void)   tableView: (UITableView*) view
  moveRowAtIndexPath: (NSIndexPath*) src
         toIndexPath: (NSIndexPath*) dst
{
    assert(src.section == ACTION_SECTION);
    assert(dst.section == ACTION_SECTION);
    int start = src.row;
    int end = dst.row;
    if(start == end)
        return;

    NSMutableArray *allActions = [Action allActions];
    assert(actions == allActions);
    Action *action = [[allActions objectAtIndex: start]
                         retain];
    [allActions removeObjectAtIndex: start];
    [allActions insertObject: action
                atIndex: end];
    [action release];

    // NB should *not* need to reload section...
}

@end
