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

#import "AdWrapperView.h"

#define DEBUG_MODULE AdWrapper
#import "util.h"

@interface NSObject ()
- (BOOL) bannerViewActionShouldBegin: (ADBannerView*) _ad
                willLeaveApplication: (BOOL) willLeave;
- (void) bannerViewActionDidFinish: (ADBannerView*) _ad;
@end


@implementation AdWrapperView

@synthesize delegate, fullScreen, adHidden;

- (id) init
{
    CGRect frame = [UIScreen mainScreen].applicationFrame;
    self = [super initWithFrame: frame];
    if(!self)
        return(nil);

    self.backgroundColor = [UIColor blackColor];
    self.autoresizingMask = (UIViewAutoresizingFlexibleWidth |
                             UIViewAutoresizingFlexibleHeight);
    self.autoresizesSubviews = NO;

    contentSubviews = [NSMutableArray new];

    adView = [ADBannerView new];
    adView.delegate = self;
    [self addSubview: adView];

    return(self);
}

- (void) dealloc
{
    adView.delegate = nil;
    [adView removeFromSuperview];
    [adView release];
    adView = nil;
    [super dealloc];
}

- (CGRect) effectiveBounds
{
    CGRect bounds = self.bounds;
    if(!fullScreen) {
        CGRect sframe = [UIApplication sharedApplication].statusBarFrame;
        if(sframe.size.height > sframe.size.width)
            sframe.size.height = sframe.size.width;
        bounds.origin.y += sframe.size.height;
        bounds.size.height -= sframe.size.height;
    }
    return(bounds);
}

- (void) layoutSubviews
{
    [super layoutSubviews];

    CGRect bounds = self.bounds;
    NSString *adOrient =
        (bounds.size.width < bounds.size.height)
        ? ADBannerContentSizeIdentifierPortrait
        : ADBannerContentSizeIdentifierLandscape;
    if(!adHidden)
        adView.currentContentSizeIdentifier = adOrient;

    CGRect cframe = [self effectiveBounds];
    CGRect aframe;
    aframe.size = [ADBannerView sizeFromBannerContentSizeIdentifier: adOrient];
    aframe.origin = CGPointMake((cframe.size.width - aframe.size.width) / 2,
                                cframe.origin.y);

    if(adVisible) {
        // place ad above content at top of screen
        cframe.size.height -= aframe.size.height;
        cframe.origin.y += aframe.size.height;
    }
    else
        // place ad just above screen
        aframe.origin.y = -aframe.size.height;

    DBLog(@"layout: bounds=%@ ad=%@ content=%@\nsubviews=%@",
          NSStringFromCGRect(bounds), NSStringFromCGRect(aframe),
          NSStringFromCGRect(cframe), self.subviews);

    for(UIView *view in self.subviews)
        if(view != adView)
            view.frame = cframe;

    adView.frame = aframe;
    [self bringSubviewToFront: adView];
}

- (void) setAdVisible: (BOOL) visible
             animated: (BOOL) animated
{
    adVisible = adVisible && !adHidden;
    if(adVisible == visible)
        return;
    adVisible = visible;
    [self setNeedsLayout];

    if(animated)
        [UIView animateWithDuration: .25
                delay: 0
                options:
                    UIViewAnimationOptionLayoutSubviews |
                    UIViewAnimationOptionBeginFromCurrentState |
                    UIViewAnimationOptionCurveEaseInOut
                animations: ^{ [self layoutIfNeeded]; }
                completion: NULL];
}

- (void) setAdVisible: (BOOL) visible
{
    [self setAdVisible: visible
          animated: NO];
}

- (void) setAdHidden: (BOOL) hidden
            animated: (BOOL) animated
{
    if(adHidden == hidden)
        return;
    if(!hidden) {
        adHidden = NO;
        adView.delegate = self;
    }
    else
        adView.delegate = nil;
    [self setAdVisible: !hidden && adView.bannerLoaded
          animated: animated];
    if(hidden)
        adHidden = YES;
}

- (void) setAdHidden: (BOOL) hidden
{
    [self setAdHidden: hidden
          animated: NO];
}

- (void) setFullScreen: (BOOL) full
{
    if(fullScreen == full)
        return;

    fullScreen = full;
    [self setNeedsLayout];
}

- (void) addContentSubview: (UIView*) contentView
              belowSubview: (UIView*) otherView
{
    // NB didAdd occurs too late for this
    contentView.frame = [self effectiveBounds];
    [contentSubviews addObject: contentView];

    if(!otherView)
        otherView = adView;
    [self insertSubview: contentView
          belowSubview: otherView];

    [self setNeedsLayout];
}

- (void) willRemoveSubview: (UIView*) subview
{
    DBLog(@"willRemoveSubview: %@", subview);
    [contentSubviews removeObjectIdenticalTo: subview];
}


// ADBannerViewDelegate

- (void) bannerViewDidLoadAd: (ADBannerView*) ad
{
    DBLog(@"didLoadAd");
    assert(!adHidden);
    [self setAdVisible: YES
          animated: YES];
}

- (void)           bannerView: (ADBannerView*) ad
  didFailToReceiveAdWithError: (NSError*) error
{
    DBLog(@"didFailAd");
    [self setAdVisible: NO
          animated: YES];
}

- (BOOL) bannerViewActionShouldBegin: (ADBannerView*) ad
                willLeaveApplication: (BOOL) willLeave
{
    return([delegate bannerViewActionShouldBegin: ad
                     willLeaveApplication: willLeave]);
}

- (void) bannerViewActionDidFinish: (ADBannerView*) ad
{
    [delegate bannerViewActionDidFinish: ad];
}

@end
