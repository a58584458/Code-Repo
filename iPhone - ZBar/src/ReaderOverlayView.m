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

#import "ReaderOverlayView.h"
#import "GradientView.h"
#import "ShapeView.h"

#define DEBUG_MODULE ReaderOverlay
#import "util.h"

#define GUIDE_WIDTH 4
#define GUIDE_LENGTH 32

@implementation ReaderOverlayView;

@synthesize delegate, enableLandscapeCrop, tipShowDelay, tipHideDelay;

- (void) initTip
{
    tipView = [[UIView alloc]
                  initWithFrame: CGRectMake(4, 0, 312, 118)];
    tipView.backgroundColor = [UIColor colorWithWhite: 0
                                       alpha: .5];
    CALayer *layer = tipView.layer;
    layer.cornerRadius = 16;
    layer.borderColor = [UIColor grayColor].CGColor;
    layer.borderWidth = 2;

    UILabel *label =
        [[UILabel alloc]
            initWithFrame: CGRectMake(48, 8, 312 - 2 * 48, 48)];
    label.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleTopMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    label.text = @"No barcode detected!  Tap here for help";
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize: 18];
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumFontSize = 10;
    label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    [tipView addSubview: label];
    [label release];

    label = [[UILabel alloc]
                initWithFrame: CGRectMake(4, 4, 24, 24)];
    label.autoresizingMask =
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleBottomMargin;
    label.text = @"\u00d7"; // 'x' (multiply symbol)
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize: 18];
    label.userInteractionEnabled = YES;
    [tipView addSubview: label];
    [label release];

    UIButton *button =
        [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 64, 64);
    button.autoresizingMask =
        UIViewAutoresizingFlexibleRightMargin |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleBottomMargin;
    [button addTarget: self
            action: @selector(hideTipAnimated)
            forControlEvents: UIControlEventTouchUpInside];
    [tipView addSubview: button];

    button = [UIButton buttonWithType: UIButtonTypeCustom];
    button.frame = CGRectMake(64, 0, 248, 64);
    button.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleBottomMargin;
    [button addTarget: self
            action: @selector(info)
            forControlEvents: UIControlEventTouchUpInside];
    [tipView addSubview: button];
}

- (id) init
{
    self = [super initWithFrame: CGRectMake(0, 0, 320, 480)];
    if(!self)
        return(nil);

    enableLandscapeCrop = YES;
    enableTip = YES;
    tipVisible = NO;
    tipShowDelay = 5;
    tipHideDelay = 5;

    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight;

    topMask = [GradientView new];
    NSArray *gradColors =
        [NSArray arrayWithObjects:
            (id)[UIColor colorWithWhite: 0
                         alpha: 3 / 4.].CGColor,
            (id)[UIColor colorWithWhite: 0
                         alpha: 1 / 4.].CGColor,
            nil];
    topMask.gradientLayer.colors = gradColors;
    [self addSubview: topMask];

    bottomMask = [GradientView new];
    CAGradientLayer *grad = bottomMask.gradientLayer;
    grad.colors = gradColors;
    grad.startPoint = CGPointMake(.5, 1);
    grad.endPoint = CGPointMake(.5, 0);
    [self addSubview: bottomMask];

    guidePath = [UIBezierPath new];
    [guidePath moveToPoint: CGPointMake(GUIDE_LENGTH, 0)];
    [guidePath addLineToPoint: CGPointMake(0, 0)];
    [guidePath addLineToPoint: CGPointMake(0, GUIDE_LENGTH)];

    for(int i = 0; i < 4; i++) {
        cropGuide[i] = [ShapeView new];
        CAShapeLayer *shape = cropGuide[i].shapeLayer;
        shape.path = guidePath.CGPath;
        shape.fillColor = nil;
        shape.strokeColor = [UIColor colorWithRed: 1 / 9.
                                     green: 1.0
                                     blue: 1 / 3.
                                     alpha: 1].CGColor;
        shape.lineCap = kCALineCapRound;
        shape.lineJoin = kCALineJoinRound;
        shape.lineWidth = GUIDE_WIDTH;
        shape.path = guidePath.CGPath;
        shape.transform = CATransform3DMakeRotation(i * M_PI_2, 0, 0, 1);
        [self addSubview: cropGuide[i]];
    }


    [self initTip];
    [self addSubview: tipView];

    toolbar = [[UIToolbar alloc]
                  initWithFrame: CGRectMake(0, 480 - 54, 320, 54)];
    toolbar.barStyle = UIBarStyleBlackOpaque;
    toolbar.autoresizingMask =
        UIViewAutoresizingFlexibleWidth |
        UIViewAutoresizingFlexibleHeight |
        UIViewAutoresizingFlexibleTopMargin;
    [self addSubview: toolbar];

    doneBtn =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemDone
            target: self
            action: @selector(dismiss)];
    cancelBtn =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
            target: self
            action: @selector(dismiss)];
    space =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
            target: nil
            action: nil];

    infoBtn = [[UIButton buttonWithType: UIButtonTypeInfoLight]
                  retain];
    [infoBtn addTarget: self
             action: @selector(info)
             forControlEvents: UIControlEventTouchUpInside];
    [self addSubview: infoBtn];

    [self layoutSubviews];
    return(self);
}

- (void) dealloc
{
    [toolbar release];
    toolbar = nil;
    [doneBtn release];
    doneBtn = nil;
    [cancelBtn release];
    cancelBtn = nil;
    [infoBtn release];
    infoBtn = nil;
    [space release];
    space = nil;
    [tipView release];
    tipView = nil;
    [topMask release];
    topMask = nil;
    [bottomMask release];
    bottomMask = nil;
    [guidePath release];
    guidePath = nil;
    for(int i = 0; i < 4; i++) {
        [cropGuide[i] release];
        cropGuide[i] = nil;
    }
    [super dealloc];
}

- (UIView*) hitTest: (CGPoint) point
          withEvent: (UIEvent*) event
{
    UIView *hitView = [super hitTest: point
                             withEvent: event];
    if(hitView == self)
        return(nil);
    else
        return(hitView);
}

- (void) showTip: (BOOL) show
        animated: (BOOL) animated
{
    if(show == tipVisible ||
       (show && !enableTip))
        return;
    else if(show)
        enableTip = NO;
    DBLog(@"showTip: %d anim=%d", show, animated);

    tipVisible = show;
    [self setNeedsLayout];

    if(animated)
        [UIView animateWithDuration: .5
                animations: ^{ [self layoutIfNeeded]; }];

    if(show && tipHideDelay > 0)
        [self performSelector: @selector(hideTipAnimated)
              withObject: nil
              afterDelay: tipHideDelay];
}

- (void) showTipAnimated
{
    [self showTip: YES
          animated: YES];
}

- (void) hideTipAnimated
{
    [self showTip: NO
          animated: YES];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    CGRect bounds = self.bounds;
    int h = toolbar.frame.size.height;
    int x1 = bounds.origin.x + bounds.size.width - 54;
    int y1 = bounds.origin.y + bounds.size.height - h;
    infoBtn.transform = CGAffineTransformIdentity;
    infoBtn.frame = CGRectMake(x1, y1, 54, h);

    CGFloat hs = bounds.size.width * 480 / (640 * 3);
    CGFloat hm = (bounds.size.height - h - hs) / 2;

    const int w2 = GUIDE_WIDTH / 2;
    const int l = GUIDE_LENGTH;
    int yg1, yg2, xg2 = bounds.size.width - w2 - l;
    if(!enableLandscapeCrop || bounds.size.width <= bounds.size.height) {
        topMask.frame = CGRectMake(0, -hm, bounds.size.width, hm);
        bottomMask.frame =
            CGRectMake(0, bounds.size.height - h, bounds.size.width, hm);
        yg1 = w2;
        yg2 = bounds.size.height - h - w2 - l;
    }
    else {
        topMask.frame = CGRectMake(0, 0, bounds.size.width, hm);
        bottomMask.frame =
            CGRectMake(0, bounds.size.height - h - hm, bounds.size.width, hm);
        yg1 = w2 + hm;
        yg2 = bounds.size.height - h - hm - w2 - l;
    }
    cropGuide[0].frame = CGRectMake(w2, yg1, l, l);
    cropGuide[1].frame = CGRectMake(xg2, yg1, l, l);
    cropGuide[2].frame = CGRectMake(xg2, yg2, l, l);
    cropGuide[3].frame = CGRectMake(w2, yg2, l, l);

    int t = (bounds.size.width <= bounds.size.height) ? 64 : 48;
    tipView.transform = CGAffineTransformIdentity;
    CGRect r = CGRectMake(bounds.origin.x + 4, y1 - t,
                          bounds.size.width - 8, h + t - 2);
    tipView.frame = r;
    if(tipVisible) {
        tipView.transform = CGAffineTransformIdentity;
        infoBtn.transform =
            CGAffineTransformMakeTranslation(0, -t - h / 2 + 18);
    }
    else {
        // squeeze the tip into the info button as it pops down
        x1 = x1 + 54 / 2 - r.origin.x;
        y1 = y1 + h / 2 - r.origin.y;
        tipView.transform = CGAffineTransformMake(.05, 0,
                                                  2, 1,
                                                  x1, y1);
        infoBtn.transform = CGAffineTransformIdentity;
    }

    DBLog(@"layoutSubviews: bounds=%@ toolbar=%@ tip=%@ xform=%@",
          NSStringFromCGRect(bounds), NSStringFromCGRect(toolbar.frame),
          NSStringFromCGRect(tipView.frame),
          NSStringFromCGAffineTransform(tipView.transform));
}

- (void) willAppear
{
    [self showTip: NO
          animated: NO];
    if(tipShowDelay > 0)
        [self performSelector: @selector(showTipAnimated)
              withObject: nil
              afterDelay: tipShowDelay];
}

- (void) willDisappear
{
    [NSObject cancelPreviousPerformRequestsWithTarget: self
              selector: @selector(showTipAnimated)
              object: nil];
    [NSObject cancelPreviousPerformRequestsWithTarget: self
              selector: @selector(hideTipAnimated)
              object: nil];
    [self showTip: NO
          animated: YES];
}

- (void) setMode: (ReaderOverlayMode) mode
{
    UIBarButtonItem *dismissBtn;
    if(mode == OVERLAY_MODE_DONE)
        dismissBtn = doneBtn;
    else
        dismissBtn = cancelBtn;
    toolbar.items = [NSArray arrayWithObjects: dismissBtn, space, nil];
}

- (void) dismiss
{
    [delegate performSelector: @selector(readerOverlayDidDismiss)
          withObject: nil
          afterDelay: 0.001];
}

- (void) info
{
    [delegate readerOverlayDidRequestHelp];
}

@end
