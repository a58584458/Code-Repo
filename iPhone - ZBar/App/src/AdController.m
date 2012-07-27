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

#import "AdController.h"
#import "AdWrapperView.h"

#define DEBUG_MODULE AdController
#import "util.h"

@interface UIViewController ()
- (BOOL) bannerViewActionShouldBegin: (ADBannerView*) _ad
                willLeaveApplication: (BOOL) willLeave;
- (void) bannerViewActionDidFinish: (ADBannerView*) _ad;
@end


@implementation AdController

@dynamic visibleViewController;

- (id) initWithContentController: (UIViewController*) _content
{
    self = [super init];
    if(!self)
        return(nil);

    controllers = [NSMutableArray new];
    [controllers addObject: _content];

    self.wantsFullScreenLayout = YES;
    return(self);
}

- (void) loadView
{
    wrapperView = [AdWrapperView new];
    wrapperView.delegate = self;
    self.view = wrapperView;
}

- (void) cleanup
{
    for(UIViewController *controller in controllers)
        if([controller isViewLoaded]) {
            [controller.view removeFromSuperview];
            controller.view = nil;
        }
    wrapperView.delegate = nil;
    [wrapperView release];
    wrapperView = nil;
}

- (void) dealloc
{
    [self cleanup];
    [controllers release];
    controllers = nil;
    [super dealloc];
}

- (UIViewController*) visibleViewController
{
    if(controllers.count)
        return([controllers lastObject]);
    else
        assert(0);
    return(nil);
}

- (void) viewDidLoad
{
    DBLog(@"didLoad");
    [super viewDidLoad];

    UIView *topView = self.visibleViewController.view;
    assert(wrapperView);
    [wrapperView addContentSubview: topView
                 belowSubview: nil];
}

- (void) viewDidUnload
{
    DBLog(@"didUnload");
    [self cleanup];
    [super viewDidUnload];
}

- (void) didReceiveMemoryWarning
{
    // unload all but top-most view controller
    UIViewController *top = self.visibleViewController;
    for(UIViewController *controller in controllers) {
        if(controller != top && [controller isViewLoaded]) {
            [controller.view removeFromSuperview];
            controller.view = nil;
        }
        [controller didReceiveMemoryWarning];
    }

    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    DBLog(@"willAppear: anim=%d frame=%@",
          animated, NSStringFromCGRect(wrapperView.frame));

    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify addObserver: self
            selector: @selector(willChangeStatusBarFrame:)
            name: UIApplicationWillChangeStatusBarFrameNotification
            object: nil];
    // NB status bar state may not be updated yet

    wrapperView.adHidden = NO;
    UIViewController *visibleVC = self.visibleViewController;
    [visibleVC viewWillAppear: animated];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear: animated];
    DBLog(@"didAppear: anim=%d", animated);
    [self.visibleViewController viewDidAppear: animated];
}

- (void) viewWillDisappear: (BOOL) animated
{
    DBLog(@"willDisappear: removeAd");
    [wrapperView setAdHidden: YES
                 animated: animated];

    NSNotificationCenter *notify = [NSNotificationCenter defaultCenter];
    [notify removeObserver: self];

    [self.visibleViewController viewWillDisappear: animated];
    [super viewWillDisappear: animated];
}

- (void) viewDidDisappear: (BOOL) animated
{
    DBLog(@"didDisappear: anim=%d", animated);
    [self.visibleViewController viewDidDisappear: animated];
    [super viewDidDisappear: animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    BOOL rotate = [self.visibleViewController
                       shouldAutorotateToInterfaceOrientation: orient];
    DBLog(@"shouldRotate: orient=%d %s", orient, (rotate) ? "YES" : "NO");
    return(rotate);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    DBLog(@"willRotate: orient=%d #%g", orient, duration);
    rotating = YES;
    if(!duration) {
        // more hacked-up view controller hidden magic nonsense:
        // when a modal VC is presented that does not support the current
        // orientation, this VC is first rotated to an orientation it does
        // support (non-animated, duration=0).  however, the actual rotation
        // is suppressed, presumably by the animation block.  the problem is
        // that this rotation suppression mechanism apparently does not cover
        // ADBannerView.currentContentSizeIdentifier, so the ad ends up
        // rotating while the rest of the view does not - very messy.
        // we'll just hide the banner in this case to avoid the problem
        wrapperView.adHidden = YES;
    }

    [self.visibleViewController
         willRotateToInterfaceOrientation: orient
         duration: duration];
}

- (void) willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation) orient
                                          duration: (NSTimeInterval) duration
{
    DBLog(@"willAnimateRotation: orient=%d #%g", orient, duration);
    [self.visibleViewController
         willAnimateRotationToInterfaceOrientation: orient
         duration: duration];
}

- (void) didRotateFromInterfaceOrientation: (UIInterfaceOrientation) orient
{
    DBLog(@"didRotate: fromOrient=%d", orient);
    [self.visibleViewController didRotateFromInterfaceOrientation: orient];
    rotating = NO;
}

- (void) willChangeStatusBarFrame: (NSNotification*) note
{
    DBLog(@"statusBarFrame=%@", note);
    [wrapperView setNeedsLayout];

    if(!rotating)
        [UIView animateWithDuration: 1 / 3.
                delay: 0
                options:
                    UIViewAnimationOptionLayoutSubviews |
                    UIViewAnimationOptionBeginFromCurrentState |
                    UIViewAnimationOptionCurveEaseInOut
                animations: ^{ [wrapperView layoutIfNeeded]; }
                completion: NULL];
}

- (void) adPresentModalViewController: (UIViewController*) next
                             animated: (BOOL) animated
{
    if([next isKindOfClass: [UIImagePickerController class]]) {
        [self presentModalViewController: next
              animated: animated];
        return;
    }

    UIView *view = next.view;
    UIViewController *prev = self.visibleViewController;
    [controllers addObject: next];

    assert([prev isViewLoaded]);
    [prev viewWillDisappear: animated];

    // ensure the new controller is rotated to the correct orientation
    // NB supporting differing orientations would imply that the old
    // controller is first rotated (without actually changing appearance) to
    // the new orientation.  no API to force rotation(?), so all controllers
    // using this interface must currently support the same orientations
    UIInterfaceOrientation orient = self.interfaceOrientation;
    assert([next shouldAutorotateToInterfaceOrientation: orient]);
    [next willRotateToInterfaceOrientation: orient
          duration: 0];
    [next willAnimateRotationToInterfaceOrientation: orient
          duration: 0];
    [next didRotateFromInterfaceOrientation: orient];
    [next viewWillAppear: animated];

    [wrapperView addContentSubview: view
                 belowSubview: nil];
    NSTimeInterval duration;
    if(animated) {
        duration = 1 / 3.;
        CGRect frame = view.frame;
        frame.origin.y += frame.size.height;
        view.frame = frame;
    }
    else
        duration = 0;

    [UIView animateWithDuration: duration
            delay: 0
            options:
                UIViewAnimationOptionLayoutSubviews |
                UIViewAnimationOptionBeginFromCurrentState |
                UIViewAnimationOptionCurveEaseInOut
            animations: ^{ [wrapperView layoutIfNeeded]; }
            completion: ^(BOOL finished) {
                [prev viewDidDisappear: animated];
                [next viewDidAppear: animated];
            }];
}

- (void) adDismissModalViewController: (UIViewController*) controller
                             animated: (BOOL) animated
{
    if([controller isKindOfClass: [UIImagePickerController class]]) {
        [controller dismissModalViewControllerAnimated: animated];
        return;
    }

    int i;
    for(i = controllers.count - 1; i > 0; i--)
        if([controllers objectAtIndex: i] == controller)
            break;
    DBLog(@"adDismissModal[%d]: %@\ncontrollers=%@\nsubviews=%@",
          i, controller, controllers, wrapperView.subviews);
    if(i <= 0) {
        i = controllers.count - 1;

        if(i <=0) {
            assert(0);
            return;
        }
    }

    UIViewController *prev = [[controllers lastObject]
                                 retain];
    [controllers removeLastObject];

    while(controllers.count > i) {
        UIViewController *inner = [controllers lastObject];
        if([inner isViewLoaded]) {
            [inner.view removeFromSuperview];
            inner.view = nil;
        }
        [controllers removeLastObject];
    }

    UIViewController *next = self.visibleViewController;
    UIView *view = prev.view;
    [prev viewWillDisappear: animated];
    if(![next isViewLoaded] || !next.view.superview) {
        [wrapperView addContentSubview: next.view  // loads view
                     belowSubview: view];
        [wrapperView layoutIfNeeded];
    }
    // ensure the new controller is rotated to the correct orientation
    UIInterfaceOrientation orient = self.interfaceOrientation;
    assert([next shouldAutorotateToInterfaceOrientation: orient]);
    [next willRotateToInterfaceOrientation: orient
          duration: 0];
    [next willAnimateRotationToInterfaceOrientation: orient
          duration: 0];
    [next didRotateFromInterfaceOrientation: orient];
    [next viewWillAppear: animated];

    NSTimeInterval duration = (animated) ? 1 / 3. : 0;
    [UIView animateWithDuration: duration
            delay: 0
            options:
                UIViewAnimationOptionLayoutSubviews |
                UIViewAnimationOptionBeginFromCurrentState |
                UIViewAnimationOptionCurveEaseInOut
            animations: ^{
                CGRect frame = view.frame;
                frame.origin.y += frame.size.height;
                view.frame = frame;
            }
            completion: ^(BOOL finished) {
                [view removeFromSuperview];
                [prev viewDidDisappear: animated];
                [next viewDidAppear: animated];
                [prev release];
            }];
}


// ADBannerViewDelegate

- (BOOL) bannerViewActionShouldBegin: (ADBannerView*) _ad
                willLeaveApplication: (BOOL) willLeave
{
    // allow content controller to override
    UIViewController *top = self.visibleViewController;
    if([top respondsToSelector:
                @selector(bannerViewActionShouldBegin:willLeaveApplication:)])
        return([top bannerViewActionShouldBegin: _ad
                    willLeaveApplication: willLeave]);

    // always allow banner actions by default
    return(YES);
}

- (void) bannerViewActionDidFinish: (ADBannerView*) _ad
{
    UIViewController *top = self.visibleViewController;
    if([top respondsToSelector:
                @selector(bannerViewActionDidFinish:)])
        [top bannerViewActionDidFinish: _ad];
}

@end
