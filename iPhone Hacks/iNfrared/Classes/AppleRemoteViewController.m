//
//  AppleRemoteViewController.m
//  iNfrared
//
//  Created by George Dean on 1/11/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import "AppleRemoteViewController.h"


@implementation AppleRemoteViewController

@synthesize remoteBase;
@synthesize leftHighlight, rightHighlight, upHighlight, downHighlight;
@synthesize centerHighlight, menuHighlight;


- (void) adjustHighlights
{
	self.leftHighlight.hidden = !(recentActivity && lastButton == RBPrevious);
	self.rightHighlight.hidden = !(recentActivity && lastButton == RBNext);
	self.upHighlight.hidden = !(recentActivity && lastButton == RBVolumeUp);
	self.downHighlight.hidden = !(recentActivity && lastButton == RBVolumeDown);
	self.centerHighlight.hidden = !(recentActivity && lastButton == RBPlayPause);
	self.menuHighlight.hidden = !(recentActivity && lastButton == RBMenu);
}


- (void) buttonRefreshTimer: (NSTimer*) theTimer
{
	if(!recentActivity)
		[self adjustHighlights];
	recentActivity = NO;
}


- (id)initWithCoder: (NSCoder*) decoder {
    if (self = [super initWithCoder:decoder]) {
		[NSTimer scheduledTimerWithTimeInterval:0.8
										 target:self
									   selector:@selector(buttonRefreshTimer:)
									   userInfo:nil
										repeats:YES];
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void) buttonPressed: (RemoteButton) button
{
	lastButton = button;
	recentActivity = YES;
	[self adjustHighlights];
}


- (void) buttonHeld: (RemoteButton)button
{
	if (lastButton != button || !recentActivity)
		[self buttonPressed:button];
	else
		recentActivity = YES;
}


- (void)dealloc {
    [super dealloc];
}


@end
