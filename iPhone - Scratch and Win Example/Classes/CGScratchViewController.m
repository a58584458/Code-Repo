//
//  CGScratchViewController.m
//  CGScratch
//
//  Created by Olivier Yiptong on 11-01-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CGScratchViewController.h"

@implementation CGScratchViewController

-(void) viewDidAppear:(BOOL)animated {
	[self.view becomeFirstResponder];
	[super viewDidAppear:animated];
}
-(void) myResetAction:(id)sender {
	[self.view awakeFromNib];
}

//make sure this view controller's view in IB is of class ShakeView (look at ShakeView.m for changes)
//the following 3 methods handle shake detection if first responder is set up for the view (in this case it is ScratchView)
-(void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake) {
		//[self.view awakeFromNib];
	}
}
	
-(void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
		if (event.subtype == UIEventSubtypeMotionShake) {
		}
}
-(void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
	if (event.subtype == UIEventSubtypeMotionShake) {
		[self.view awakeFromNib];
	}
}


/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

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
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
