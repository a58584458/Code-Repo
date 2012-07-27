//
//  AppleRemoteViewController.h
//  iNfrared
//
//  Created by George Dean on 1/11/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RemoteEventsManager.h"

@interface AppleRemoteViewController : UIViewController <RemoteEventsReceiver> {
	UIImageView* remoteBase;
	UIImageView* leftHighlight;
	UIImageView* rightHighlight;
	UIImageView* upHighlight;
	UIImageView* downHighlight;
	UIImageView* centerHighlight;
	UIImageView* menuHighlight;
	
	RemoteButton lastButton;
	BOOL recentActivity;
}

@property (nonatomic, retain) IBOutlet UIImageView* remoteBase;
@property (nonatomic, retain) IBOutlet UIImageView* leftHighlight;
@property (nonatomic, retain) IBOutlet UIImageView* rightHighlight;
@property (nonatomic, retain) IBOutlet UIImageView* upHighlight;
@property (nonatomic, retain) IBOutlet UIImageView* downHighlight;
@property (nonatomic, retain) IBOutlet UIImageView* centerHighlight;
@property (nonatomic, retain) IBOutlet UIImageView* menuHighlight;

@end
