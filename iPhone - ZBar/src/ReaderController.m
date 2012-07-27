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

#import "ReaderController.h"
#import "ReaderOverlayView.h"

#define DEBUG_MODULE ReaderController
#import "util.h"


@implementation ReaderController

@synthesize optimizeLandscape;

- (id) init
{
    self = [super init];
    if(!self)
        return(nil);

    optimizeLandscape = YES;
    self.showsZBarControls = NO;
    return(self);
}

- (void) cleanup
{
   self.cameraOverlayView = nil;
    [overlay release];
    overlay = nil;
}

- (void) dealloc
{
    [self cleanup];
    [super dealloc];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
#ifndef NDEBUG
    readerView.showsFPS = YES;
#endif
    _interfaceOrientation = UIInterfaceOrientationPortrait;

    if(!self.wantsFullScreenLayout) {
        // account for controls
        CGRect r = readerView.frame;
        r.size.height -= 54;
        readerView.frame = r;
        readerView.autoresizingMask |= UIViewAutoresizingFlexibleBottomMargin;
    }

    // use a custom overlay
    overlay = [ReaderOverlayView new];
    overlay.delegate = (NSObject<ReaderOverlayDelegate>*)self;
}

- (void) viewDidUnload
{
    [self cleanup];
    [super viewDidUnload];
}

- (void) updateScanCrop: (UIInterfaceOrientation) orient
{
    // update crop box
    if(optimizeLandscape &&
       UIInterfaceOrientationIsLandscape(orient))
        self.scanCrop = CGRectMake(0, 1 / 3., 1, 1 / 3.);
    else
        self.scanCrop = CGRectMake(0, 0, 1, 1);
}

- (void) updateScanDensity
{
    BOOL hires = readerView.zoom < 1.5;
    int dy, dx;
    if(optimizeLandscape &&
       UIInterfaceOrientationIsLandscape(_interfaceOrientation))
    {
        dy = (hires) ? 2 : 1;
        dx = 0;
    }
    else {
        dy = (hires) ? 3 : 2;
        dx = dy;
    }

    @synchronized(scanner) {
        [scanner setSymbology: 0
                 config: ZBAR_CFG_X_DENSITY
                 to: dx];
        [scanner setSymbology: 0
                 config: ZBAR_CFG_Y_DENSITY
                 to: dy];
    }
    DBLog(@"scan opt=%d orient=%d density=%d,%d scanner=%@",
          optimizeLandscape, _interfaceOrientation, dx, dy, scanner);
}

- (void) viewWillAppear: (BOOL) animated
{
    overlay.enableLandscapeCrop = optimizeLandscape;

    [self updateScanCrop: _interfaceOrientation];
    [self updateScanDensity];

    [super viewWillAppear: animated];

    // another custom container hack... (no interfaceOrientation prop)
    [self.readerView
         willRotateToInterfaceOrientation: _interfaceOrientation
         duration: 0];

    // use a custom overlay
    self.showsCameraControls = NO;
    [overlay setMode: OVERLAY_MODE_CANCEL];
    self.cameraOverlayView = overlay;
    CGSize size = self.view.bounds.size;
    overlay.frame = CGRectMake(0, 0, size.width, size.height);
    [overlay willAppear];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [overlay willDisappear];
    [super viewWillDisappear: animated];
}

- (BOOL) shouldAutorotateToInterfaceOrientation: (UIInterfaceOrientation) orient
{
    return(YES);
}

- (void) willRotateToInterfaceOrientation: (UIInterfaceOrientation) orient
                                 duration: (NSTimeInterval) duration
{
    // pause reader during rotation
    readerView.captureReader.enableReader = NO;

    [self updateScanCrop: orient];

    [super willRotateToInterfaceOrientation: orient
           duration: duration];
}

- (void) willAnimateRotationToInterfaceOrientation: (UIInterfaceOrientation) orient
                                          duration: (NSTimeInterval) duration
{
    // NB have to manually track interfaceOrientation if we want to
    // nest this controller in a custom container view controller
    _interfaceOrientation = orient;
    [super willAnimateRotationToInterfaceOrientation: orient
           duration: duration];
}

- (void) didRotateFromInterfaceOrientation: (UIInterfaceOrientation) orient
{
    [super didRotateFromInterfaceOrientation: orient];

    [self updateScanDensity];

    // resume scanning
    readerView.captureReader.enableReader = YES;
}


// ReaderOverlayDelegate

- (void) readerOverlayDidDismiss
{
    [overlay willDisappear];
    [self.view.window.rootViewController
         adDismissModalViewController: self
         animated: YES];
}

- (void) readerOverlayDidRequestHelp
{
    [overlay willDisappear];
    [self showHelpWithReason: @"INFO"];
}


// ADBannerViewDelegate (via AdController)

- (BOOL) bannerViewActionShouldBegin: (ADBannerView*) _ad
                willLeaveApplication: (BOOL) willLeave
{
    DBLog(@"adBegin");
    [readerView stop];
    return(YES);
}

- (void) bannerViewActionDidFinish: (ADBannerView*) _ad
{
    DBLog(@"adFinish");
    [readerView start];
}

@end
