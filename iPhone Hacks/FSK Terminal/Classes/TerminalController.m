//
//  TerminalController.m
//  FSK Terminal
//
//  Created by George Dean on 12/21/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import "TerminalController.h"
#import "FSKTerminalAppDelegate.h"
#import "FSKSerialGenerator.h"

@implementation TerminalController

@synthesize textReceived, textSent;

/*
// Override initWithNibName:bundle: to load the view using a nib file then perform additional customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.textSent.autocorrectionType = UITextAutocorrectionTypeNo;
	highestLocation = -1;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}

- (void)receivedChar:(char)input
{
	textReceived.text = [textReceived.text stringByAppendingFormat:@"%c", input];
}

- (BOOL)textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range
											   replacementText:(NSString*)text
{
	if([text length] == 0 || range.length > 0 || (int)range.location < highestLocation)
		return NO;
	if(range.location == highestLocation)
		return YES;
	highestLocation = range.location;
	const char *bytes = [text UTF8String];
	while (*bytes) {
		[[FSKTerminalAppDelegate getInstance].generator writeByte:(UInt8)*bytes];
		++bytes;
	}
	return YES;
}

- (void)dealloc {
    [super dealloc];
}

@end
