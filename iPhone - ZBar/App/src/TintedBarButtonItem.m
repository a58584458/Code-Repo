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

#import "TintedBarButtonItem.h"


@implementation TintedBarButtonItem

@synthesize tintColor;

- (id) initWithTitle: (NSString*) title
              target: (id) target
              action: (SEL) action
           tintColor: (UIColor*) color
{
    // use a segmented control for a tinted button because
    // UIButton does not support tinting
    UISegmentedControl *segs =
        [[UISegmentedControl alloc]
            initWithItems: [NSArray arrayWithObject: title]];
    segs.segmentedControlStyle = UISegmentedControlStyleBar;
    [segs addTarget: self
          action: @selector(didChangeSegment:)
          forControlEvents: UIControlEventValueChanged];
    segs.tintColor = color;

    self = [super initWithCustomView: segs];
    [segs release];
    if(!self)
        return(nil);

    self.target = target;
    self.action = action;
    tintColor = [color retain];
    return(self);
}

- (void) dealloc
{
    [tintColor release];
    tintColor = nil;
    [super dealloc];
}

- (void) setTintColor: (UIColor*) newColor
{
    UIColor *oldColor = tintColor;
    tintColor = [newColor retain];
    [oldColor release];

    UISegmentedControl *segs = (id)self.customView;
    segs.tintColor = tintColor;
}

- (void) didChangeSegment: (UISegmentedControl*) segs
{
    // return segment to de-selected state
    if(segs.selectedSegmentIndex == UISegmentedControlNoSegment)
        return;
    segs.selectedSegmentIndex = UISegmentedControlNoSegment;

    [self.target performSelector: self.action
                 withObject: self];
}

@end
