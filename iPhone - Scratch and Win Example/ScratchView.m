//
//  ScratchView.m
//  CGScratch
//
//  Created by Olivier Yiptong on 11-01-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ScratchView.h"
#import "ScratchableView.h"

@implementation ScratchView
@synthesize myResetButton;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code.
    }
    return self;
}

- (void)awakeFromNib {
	
	//I created myImageRect because the previous self.frame code was causing the view to drop 20px or so
	//not sure why that is but this avoids that problem
	CGRect myImageRect = CGRectMake(0.0f, 0.0f, 320.0f, 480.0f);
	ScratchableView *scratchableView = [[ScratchableView alloc] initWithFrame:myImageRect];
	[self addSubview:scratchableView];
	
	UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
	[self addSubview:background];
	[self addSubview:myResetButton];
	[self bringSubviewToFront:scratchableView];
	[self bringSubviewToFront:myResetButton];
}

- (void)dealloc {
	[myResetButton release];
    [super dealloc];
}

//!!!!!this is critical.!!!!!!!!!!!!
//This view handles the shake but it must be set up to become first responder
//that is not by default. If other items can become first responder like a text field 
//you must set this view as first responder when you are done with those views that are 
//tempoarily first responder.
- (BOOL) canBecomeFirstResponder {
	return YES;
}

@end
