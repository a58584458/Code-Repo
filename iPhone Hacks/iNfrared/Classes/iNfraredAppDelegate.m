//
//  iNfraredAppDelegate.m
//  iNfrared
//
//  Created by George Dean on 11/27/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import "iNfraredAppDelegate.h"
#import "AppleRemoteRecognizer.h"
#import "RemoteEventsManager.h"
#import "RawPulseLogger.h"


void interruptionListenerCallback (
								   void	*inUserData,
								   UInt32	interruptionState
) {
	// This callback, being outside the implementation block, needs a reference 
	//	to the AudioViewController object
	iNfraredAppDelegate *delegate = (iNfraredAppDelegate *) inUserData;
	
	if (interruptionState == kAudioSessionBeginInterruption) {
		
		NSLog (@"Interrupted. Stopping recording.");
		
		[delegate.analyzer stop];
	} else if (interruptionState == kAudioSessionEndInterruption) {
		// if the interruption was removed, resume recording
		[delegate.analyzer record];
	}
}

@implementation iNfraredAppDelegate

@synthesize window;
@synthesize tabBarController;
@synthesize pulseLog;
@synthesize eventsLog;
@synthesize remoteController;
@synthesize analyzer;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	// Set cocoa to multithreaded mode by launching a no-op thread
	[[[[NSThread alloc] init] autorelease] start];
	
	[RemoteEventsManager addReceiver:self.remoteController];

	// initialize the audio session object for this application,
	//		registering the callback that Audio Session Services will invoke 
	//		when there's an interruption
	AudioSessionInitialize (NULL,
							NULL,
							interruptionListenerCallback,
							self);
	
	// before instantiating the recording audio queue object, 
	//	set the audio session category
	UInt32 sessionCategory = kAudioSessionCategory_RecordAudio;
	AudioSessionSetProperty (kAudioSessionProperty_AudioCategory,
							 sizeof (sessionCategory),
							 &sessionCategory);
	
	analyzer = [[AudioSignalAnalyzer alloc] init];
	[analyzer addRecognizer:[[AppleRemoteRecognizer alloc] init]];
	[analyzer addRecognizer:[[RawPulseLogger alloc] init]];
	AudioSessionSetActive (true);
	[analyzer record];
    
    // Add the tab bar controller's current view as a subview of the window
    [window addSubview:tabBarController.view];
}


/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
}
*/

/*
// Optional UITabBarControllerDelegate method
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed {
}
*/


- (void)dealloc {
	[analyzer stop];
	[analyzer release];
    [tabBarController release];
    [window release];
    [super dealloc];
}

@end

