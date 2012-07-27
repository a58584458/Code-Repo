//
//  iNfraredAppDelegate.h
//  iNfrared
//
//  Created by George Dean on 11/27/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LogViewController.h"
#import "AudioSignalAnalyzer.h"
#import "AppleRemoteViewController.h"

@interface iNfraredAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
    UITabBarController *tabBarController;
	LogViewController *pulseLog;
	LogViewController *eventsLog;
	AppleRemoteViewController *remoteController;
	
	AudioSignalAnalyzer* analyzer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet LogViewController *pulseLog;
@property (nonatomic, retain) IBOutlet LogViewController *eventsLog;
@property (nonatomic, retain) IBOutlet AppleRemoteViewController *remoteController;

@property (nonatomic, retain) AudioSignalAnalyzer *analyzer;

@end
