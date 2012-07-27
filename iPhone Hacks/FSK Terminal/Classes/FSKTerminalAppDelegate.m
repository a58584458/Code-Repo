//
//  FSK_TerminalAppDelegate.m
//  FSK Terminal
//
//  Created by George Dean on 12/21/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import "FSKTerminalAppDelegate.h"
#import "FSKTerminalAppDelegateIRScanCodes.h"
#import "TerminalController.h"
#import "TypePadController.h"
#import "AudioSignalAnalyzer.h"
#import "FSKRecognizer.h"
#import "FSKSerialGenerator.h"

void interruptionListenerCallback (
								   void	*inUserData,
								   UInt32	interruptionState
) {
	// This callback, being outside the implementation block, needs a reference 
	//	to the AudioViewController object
	FSKTerminalAppDelegate *delegate = (FSKTerminalAppDelegate *) inUserData;
	
	if (interruptionState == kAudioSessionBeginInterruption) {
		
		NSLog (@"Interrupted. Stopping recording/playback.");
		
		[delegate.analyzer stop];
		[delegate.generator pause];
	} else if (interruptionState == kAudioSessionEndInterruption) {
		// if the interruption was removed, resume recording
		[delegate.analyzer record];
		[delegate.generator resume];
	}
}

@implementation FSKTerminalAppDelegate

@synthesize window;
@synthesize tabController;
@synthesize terminalController;
@synthesize typeController;
@synthesize typePadNavController;
@synthesize analyzer;
@synthesize generator;

+ (FSKTerminalAppDelegate*) getInstance
{
	return (FSKTerminalAppDelegate*)[UIApplication sharedApplication].delegate;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	// Set cocoa to multithreaded mode by launching a no-op thread
	[[[[NSThread alloc] init] autorelease] start];
    
    // Override point for customization after app launch    
    [window addSubview:tabController.view];
    [window makeKeyAndVisible];
	
	// initialize the audio session object for this application,
	//		registering the callback that Audio Session Services will invoke 
	//		when there's an interruption
	AudioSessionInitialize (NULL,
							NULL,
							interruptionListenerCallback,
							self);
	
	// before instantiating the recording audio queue object, 
	//	set the audio session category
	UInt32 sessionCategory = kAudioSessionCategory_PlayAndRecord;
	AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
							 sizeof (sessionCategory),
							 &sessionCategory);
	
	recognizer = [[FSKRecognizer alloc] init];
	analyzer = [[AudioSignalAnalyzer alloc] init];
	[analyzer addRecognizer:recognizer];
	[recognizer addReceiver:terminalController];
	[recognizer addReceiver:typeController];
	[self buildScanCodes];
	generator = [[FSKSerialGenerator alloc] init];
	AudioSessionSetActive (true);
	[analyzer record];
	[generator play];
}


- (void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	if(viewController == (UIViewController*) typePadNavController)
		[generator pause];
	else
		[generator resume];
}


- (void)dealloc {
	[analyzer stop];
	[analyzer release];
	[generator stop];
	[generator release];
    [tabController release];
	[terminalController release];
	[typeController release];
    [window release];
    [super dealloc];
}


@end
