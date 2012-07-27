//
//  FSKTerminalAppDelegate.h
//  FSK Terminal
//
//  Created by George Dean on 12/21/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TerminalController, TypePadController, AudioSignalAnalyzer, FSKSerialGenerator, FSKRecognizer;

@interface FSKTerminalAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate> {
    UIWindow *window;
	UITabBarController* tabController;
    TerminalController *terminalController;
	TypePadController* typeController;
	UINavigationController* typePadNavController;
	AudioSignalAnalyzer* analyzer;
	FSKSerialGenerator* generator;
	FSKRecognizer* recognizer;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController* tabController;
@property (nonatomic, retain) IBOutlet TerminalController *terminalController;
@property (nonatomic, retain) IBOutlet TypePadController* typeController;
@property (nonatomic, retain) IBOutlet UINavigationController* typePadNavController;
@property (nonatomic, retain) AudioSignalAnalyzer* analyzer;
@property (nonatomic, retain) FSKSerialGenerator* generator;

+ (FSKTerminalAppDelegate*) getInstance;

@end

