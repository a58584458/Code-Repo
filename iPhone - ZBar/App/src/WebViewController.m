//------------------------------------------------------------------------
//  Copyright 2010-2011 (c) Jeff Brown <spadix@users.sourceforge.net>
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

#import "WebViewController.h"
#import "util.h"

static NSSet *supportedSchemes = NULL;

@implementation WebViewController

+ (BOOL) canOpenInternal: (NSURL*) url
{
    if(!supportedSchemes)
        supportedSchemes =
            [[NSSet setWithObjects: @"http", @"https", nil]
                retain];

    NSString *scheme = [[url scheme] lowercaseString];
    return([supportedSchemes containsObject: scheme]);
}

+ (BOOL) openExternalURL: (NSURL*) url
{
    BOOL opened = NO;
    if(url)
        opened = [[UIApplication sharedApplication] openURL: url];

    if(!opened) {
        UIAlertView *alert =
            [[UIAlertView alloc]
                initWithTitle: @"Invalid URL"
                message: @"Unable to open the selected link"
                delegate: nil
                cancelButtonTitle: @"Cancel"
                otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    return(opened);
}

- (id) init
{
    self = [super initWithNibName: nil
                  bundle: nil];
    return(self);
}

- (void) cleanup
{
    self.toolbarItems = nil;
    [backBtn release];
    backBtn = nil;
}

- (void) dealloc
{
    [self cleanup];
    [history release];
    history = nil;
    if([self isViewLoaded])
        ((UIWebView*)self.view).delegate = nil;
    [super dealloc];
}

- (void) setView: (UIView*) view
{
    if([self isViewLoaded])
        // ensure the delegate ref doesn't leak
        ((UIWebView*)self.view).delegate = nil;
    [super setView: view];
}

- (void) loadView
{
    self.view = [[UIWebView new]
                    autorelease];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    UIWebView *view = (UIWebView*)self.view;
    view.delegate = self;

    backBtn = [[UIBarButtonItem alloc]
                  initWithImage: [UIImage imageNamed: @"zbar-back.png"]
                  style: UIBarButtonItemStylePlain
                  target: self
                  action: @selector(goBack)];
    backBtn.enabled = NO;

    self.toolbarItems =
        [NSArray arrayWithObjects:
            backBtn,
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
                 initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                 target: self
                 action: @selector(showActions)]
                autorelease],
            nil];
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (void) refreshRequest
{
    UIWebView *view = (UIWebView*)self.view;

    // display a local resource if there is no network
    BOOL reachable = IsNetworkReachable();
    view.scalesPageToFit = reachable;

    NSURL *url = nil;
    if(!reachable) {
        NSString *path = [[NSBundle mainBundle]
                             pathForResource: @"unreachable"
                             ofType: @"xhtml"];
        if(path)
            url = [NSURL fileURLWithPath: path
                         isDirectory: NO];

    } else
        url = [NSURL URLWithString: history];

    NSURLRequest *req =
        [NSURLRequest requestWithURL: url];
    [view loadRequest: req];
}

- (void) viewWillAppear: (BOOL) animated
{
    UIWebView *view = (UIWebView*)self.view;
    if(!view.request)
        [self refreshRequest];
}

- (void) viewWillDisappear: (BOOL) animated
{
    UIWebView *view = (UIWebView*)self.view;
    if(view.loading)
        NetworkActivityUpdate(-1);
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) showActions
{
    UIActionSheet *actions =
        [[UIActionSheet alloc]
            initWithTitle: nil
            delegate: self
            cancelButtonTitle: @"Cancel"
            destructiveButtonTitle: nil
            otherButtonTitles:
                @"Reload",
                @"Open in Safari",
                @"Mail link to this page",
                nil];
    [actions showInView: self.navigationController.view];
    [actions release];
}

- (void) loadURL: (NSURL*) url
{
    url = [url standardizedURL];

    history = [[url absoluteString] retain];

    backBtn.enabled = NO;
    [self refreshRequest];
}

- (void) goBack
{
    UIWebView *view = (UIWebView*)self.view;
    if(view.canGoBack)
        [view goBack];
}

// PersistentState

- (id) saveState
{
    NSMutableDictionary *state =
        [NSMutableDictionary dictionaryWithObjectsAndKeys:
            NSStringFromClass([self class]), @"class",
            history, @"history",
            nil];
    return(state);
}

- (BOOL) restoreState: (id) state
{
    if(!state || !IsNetworkReachable() ||
       ![state isKindOfClass: [NSDictionary class]])
        return(NO);

    history = [[state objectForKey: @"history"]
                  retain];
    if(!history ||
       ![history isKindOfClass: [NSString class]])
        return(NO);

    NSURL *url = [NSURL URLWithString: history];
    if(!url)
        return(NO);
    return(YES);
}

// UIWebViewDelegate

- (void) webViewDidStartLoad: (UIWebView*) view
{
    DBLog(@"start load: loading=%d back=%d", view.loading, view.canGoBack);
    NetworkActivityUpdate(1);
}

- (void) webViewDidFinishLoad: (UIWebView*) view
{
    NetworkActivityUpdate(-1);
    backBtn.enabled = view.canGoBack;
    NSString *title =
        [view stringByEvaluatingJavaScriptFromString:
                  @"document.title"];
    if(title)
        self.title = title;
    DBLog(@"finish load: back=%d", view.canGoBack);
}

- (void)       webView: (UIWebView*) view
  didFailLoadWithError: (NSError*) err
{
    DBLog(@"fail load: loading=%d back=%d", view.loading, view.canGoBack);

    // treat same as finish
    NetworkActivityUpdate(-1);
    backBtn.enabled = view.canGoBack;

    if(view.loading ||
       ([err.domain isEqualToString: @"NSURLErrorDomain"] &&
        err.code == NSURLErrorCancelled))
        // ignore this one, comes from eg hitting "back" too fast
        return;

    NSString *msg = [err localizedFailureReason];
    if(!msg) {
        NSString *desc = [err localizedDescription];
        if(desc)
            msg = desc;
        else
            msg = @"Unknown error";
    }

    UIAlertView *alert =
        [[UIAlertView alloc]
            initWithTitle: @"Failed to open link"
            message: msg
            delegate: nil
            cancelButtonTitle: @"Cancel"
            otherButtonTitles: nil];
    [alert show];
    [alert release];
}

- (BOOL)             webView: (UIWebView*) view
  shouldStartLoadWithRequest: (NSURLRequest*) req
              navigationType: (UIWebViewNavigationType) type
{
    if(view.loading)
        // this is a redirect/subrequest
        return(YES);

    NSURL *url = [[req URL] standardizedURL];
    DBLog(@"should load: type=%d loading=%d back=%d url=%.40@",
          type, view.loading, view.canGoBack, [url absoluteString]);

    BOOL result = YES;
    switch(type)
    {
    case UIWebViewNavigationTypeLinkClicked: // 0
        if(![WebViewController canOpenInternal: url]) {
            [WebViewController openExternalURL: url];
            result = NO;
        }
        break;

    case UIWebViewNavigationTypeBackForward: // 2
        backBtn.enabled = view.canGoBack;
        break;

    case UIWebViewNavigationTypeReload:
    case UIWebViewNavigationTypeFormSubmitted:
    case UIWebViewNavigationTypeFormResubmitted:
    case UIWebViewNavigationTypeOther:
    default:
        // ignore
        break;
    }

    if(result)
        self.title = [url absoluteString];
    return(result);
}

// UIActionSheetDelegate

- (void)   actionSheet: (UIActionSheet*) sheet
  clickedButtonAtIndex: (NSInteger) idx
{
    if(idx == sheet.cancelButtonIndex)
        return;

    UIWebView *view = (UIWebView*)self.view;
    NSURL *url = [view.request URL];

    idx -= sheet.firstOtherButtonIndex;
    switch(idx)
    {
    // reload
    case 0:
        [view reload];
        break;

    // open in Safari
    case 1:
        [WebViewController openExternalURL: url];
        break;

    // email link
    case 2: {
        MFMailComposeViewController *mailer =
            [MFMailComposeViewController new];
        mailer.mailComposeDelegate = [MailerCompletionHandler new];

        [mailer setSubject: @"Barcode link"];
        [mailer setMessageBody: [url absoluteString]
                isHTML: NO];

        [view.window.rootViewController
             presentModalViewController: mailer
             animated: YES];
        [mailer release];
        break;
    }
    }
}

@end
