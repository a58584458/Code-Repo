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

#import "TextEditController.h"
#import "SettingsController.h"

#define DEBUG_MODULE TextEdit
#import "util.h"


@interface NSObject ()
- (void) textEditController: (TextEditController*) editor
         didDismissWithSave: (BOOL) save;
@end


@implementation TextEditController

@synthesize delegate, object, editable;

- (id) initWithObject: (NSObject*) _object
              keyPath: (NSString*) _keyPath
{
    self = [super init];
    if(!self)
        return(nil);

    editable = YES;
    shouldRestoreSelection = YES;
    object = [_object retain];
    keyPath = [_keyPath retain];
    savedSelection = NSMakeRange(0, NSIntegerMax);

    [object addObserver: self
            forKeyPath: keyPath
            options: NSKeyValueObservingOptionInitial
            context: NULL];

    return(self);
}

- (void) cleanup
{
    [[NSNotificationCenter defaultCenter]
        removeObserver: self];

    UINavigationItem *navit = self.navigationItem;
    navit.leftBarButtonItem = nil;
    navit.rightBarButtonItem = nil;
    [textView release];
    textView = nil;
    [save release];
    save = nil;
}

- (void) dealloc
{
    [self cleanup];

    @try {
        [object removeObserver: self
                forKeyPath: keyPath];
    }
    @catch(...) { }

    [keyPath release];
    keyPath = nil;
    [object release];
    object = nil;
    [savedText release];
    savedText = nil;
    [super dealloc];
}

- (void) updateObject: (NSString*) text
{
    if(text && text.length)
        [object setValue: text
                forKeyPath: keyPath];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    UIView *view = self.view;
    view.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;

    textView = [[UITextView alloc]
                   initWithFrame: view.bounds];
    textView.delegate = self;
    textView.editable = editable;
    textView.autocapitalizationType = UITextAutocapitalizationTypeWords;
    textView.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;
    textView.font = [UIFont systemFontOfSize: 17];
    NSString *text = savedText;
    if(text) {
        textView.text = text;
        [savedText release];
        savedText = nil;
    }
    if(editable)
        shouldRestoreSelection = YES;
    [view addSubview: textView];

    // only display cancel and save button for top view controller
    if([self.navigationController.viewControllers objectAtIndex: 0] == self) {
        UINavigationItem *navit = self.navigationItem;
        UIBarButtonSystemItem leftItem =
            (editable)
            ? UIBarButtonSystemItemCancel
            : UIBarButtonSystemItemDone;
        navit.leftBarButtonItem =
            [[[UIBarButtonItem alloc]
                 initWithBarButtonSystemItem: leftItem
                 target: self
                 action: @selector(cancel)]
                autorelease];

        if(editable) {
            save = [[UIBarButtonItem alloc]
                       initWithBarButtonSystemItem: UIBarButtonSystemItemSave
                       target: self
                       action: @selector(save)];
            save.enabled = text && text.length;
        }
        navit.rightBarButtonItem = save;
    }

    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver: self
            selector: @selector(willChangeKeyboard:)
            name: UIKeyboardWillShowNotification
            object: nil];
    [notify addObserver: self
            selector: @selector(willChangeKeyboard:)
            name: UIKeyboardWillHideNotification
            object: nil];
}

- (void) viewDidUnload
{
    // need to save/restore selection and text when view unloads
    assert(!savedText);
    savedSelection = textView.selectedRange;
    [savedText release];
    savedText = [textView.text retain];

    [self cleanup];
    [super viewDidUnload];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    if(editable)
        [textView becomeFirstResponder];
    if(shouldRestoreSelection) {
        shouldRestoreSelection = NO;
        if(editable)
            [self performSelector: @selector(restoreSelection)
                  withObject: nil
                  afterDelay: 0.001];
        else
            [textView performSelector: @selector(selectAll:)
                      withObject: self
                      afterDelay: 0.001];
    }
}

- (void) viewWillDisappear: (BOOL) animated
{
    if(editable)
        [self updateObject: textView.text];
    [super viewWillDisappear: animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) restoreSelection
{
    NSString *text = textView.text;
    NSInteger n = text.length;
    NSRange sel = NSMakeRange(0, n);
    sel = NSIntersectionRange(sel, savedSelection);
    if(!sel.length)
        sel.location = n;
    textView.selectedRange = sel;
}

- (void) willChangeKeyboard: (NSNotification*) note
{
    NSDictionary *info = note.userInfo;
    NSValue *val = [info objectForKey: UIKeyboardFrameEndUserInfoKey];
    if(!val || ![val isKindOfClass: [NSValue class]])
        return;
    CGRect skbd = val.CGRectValue;

    // convert keyboard locaiton to view coordinates
    UIView *view = self.view;
    CGRect vkbd = [view convertRect: skbd
                        fromView: nil];

    // size text view to top of keyboard
    CGRect bounds = view.bounds;
    bounds.size.height = vkbd.origin.y - bounds.origin.y;
    textView.frame = bounds;
}

- (void) cancel
{
    [textView resignFirstResponder];
    [delegate textEditController: self
              didDismissWithSave: NO];
}

- (void) save
{
    assert(editable);
    [textView resignFirstResponder];
    [self updateObject: textView.text];
    [delegate textEditController: self
              didDismissWithSave: YES];
}


// NSKeyValueObserving

- (void) observeValueForKeyPath: (NSString*) _keyPath
                       ofObject: (id) _object
                         change: (NSDictionary*) change
                        context: (void*) ctx
{
    NSString *text = [object valueForKeyPath: keyPath];
    if(text && ![text isKindOfClass: [NSString class]]) {
        assert(0);
        return;
    }
    if([self isViewLoaded])
        textView.text = text;
    else {
        [savedText release];
        savedText = [text retain];
    }
    save.enabled = text && text.length;
}


// UITextViewDelegate

- (void) textViewDidChange: (UITextView*) view
{
    if(save) {
        NSString *text = view.text;
        save.enabled = text && text.length;
    }
}

@end


@implementation TemplateEditController

- (void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem =
        [[[UIBarButtonItem alloc]
             initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
             target: self
             action: @selector(addTag)]
            autorelease];

    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textView.keyboardType = UIKeyboardTypeURL;
    textView.returnKeyType = UIReturnKeyDone;
}

- (void) addTag
{
    SettingsController *tags =
        [[SettingsController alloc]
            initWithObject: self
            schemaName: @"classifications"];
    tags.autoDismiss = YES;

    [self.navigationController
         pushViewController: tags
         animated: YES];
    [tags release];
}

- (NSString*) tag
{
    return(nil);
}

- (void) setTag: (NSString*) tag
{
    // force view to load
    (void)self.view;

    NSString *text = textView.text;
    NSRange sel = textView.selectedRange;
    NSUInteger n = text.length;
    if(sel.location > n) {
        sel.location = n;
        sel.length = 0;
    }
    NSString *newText =
        [text stringByReplacingCharactersInRange: sel
              withString: tag];
    DBLog(@"tag=%@ @{%d,%d} \"%@\" => \"%@\"",
          tag, sel.location, sel.length, text, newText);
    textView.text = newText;
    // FIXME update selection?
}

- (NSRange) rangeOfString: (NSString*) text
   includingTagsFromRange: (NSRange) sel
{
    if(sel.location > text.length)
        return(sel);

    NSRange start = [text rangeOfString: @"{"
                          options: NSBackwardsSearch
                          range: NSMakeRange(0, sel.location)];
    NSUInteger n = text.length;
    if(start.length) {
        NSRange prefix;
        prefix.location = start.location + start.length;
        prefix.length = n - prefix.location;
        assert(prefix.location >= 0 && prefix.location + prefix.length <= n);
        NSRange end = [text rangeOfString: @"}"
                            options: 0
                            range: prefix];
        if(!end.length || end.location < sel.location)
            return(sel);
        if(end.location >= sel.location + sel.length) {
            NSRange r =
                NSMakeRange(start.location,
                            end.location - start.location + end.length);
            assert(r.location >= 0 && r.location + r.length <= n);
            return(r);
        }
        sel.length += sel.location - start.location;
        sel.location = start.location;
        assert(sel.location >= 0 && sel.location + sel.length <= n);
    }

    NSRange suffix;
    suffix.location = sel.location + sel.length;
    suffix.length = n - suffix.location;
    assert(suffix.location >= 0 && suffix.location + suffix.length <= n);
    NSRange end = [text rangeOfString: @"}"
                        options: 0
                        range: suffix];
    if(end.length) {
        suffix = NSMakeRange(sel.location, end.location - sel.location);
        assert(suffix.location >= 0 && suffix.location + suffix.length <= n);
        start = [text rangeOfString: @"{"
                      options: NSBackwardsSearch
                      range: suffix];
        if(start.length && start.location < sel.location + sel.length)
            sel.length = end.location - sel.location + end.length;
    }
    assert(sel.location >= 0 && sel.location + sel.length <= n);
    return(sel);
}


// UITextViewDelegate

- (BOOL)         textView: (UITextView*) view
  shouldChangeTextInRange: (NSRange) sel
          replacementText: (NSString*) replacement
{
    if([replacement rangeOfString: @"\n"].length) {
        if([replacement isEqualToString: @"\n"])
            [self.navigationController popViewControllerAnimated: YES];
        return(NO);
    }
    if(!sel.length)
        return(YES);

    NSString *text = view.text;
    NSRange r = [self rangeOfString: text
                      includingTagsFromRange: sel];
    //DBLog(@"change={%d,%d} \"%@\" => {%d,%d} \"%@\"",
    //      sel.location, sel.length, [view.text substringWithRange: sel],
    //      r.location, r.length, [view.text substringWithRange: r]);
    if(NSEqualRanges(sel, r))
        return(YES);

    text = [text stringByReplacingCharactersInRange: r
                 withString: replacement];
    view.text = text;
    save.enabled = text && text.length;
    return(NO);
}

- (void) textViewDidChangeSelection: (UITextView*) view
{
    NSRange sel = view.selectedRange;
    NSString *text = view.text;
    if(sel.location > text.length)
        return;
    NSRange r = [self rangeOfString: text
                      includingTagsFromRange: sel];
    //DBLog(@"selection={%d,%d} \"%@\" => {%d,%d} \"%@\"",
    //      sel.location, sel.length, [view.text substringWithRange: sel],
    //      r.location, r.length, [view.text substringWithRange: r]);

    if(!NSEqualRanges(sel, r))
        view.selectedRange = r;
}

@end
