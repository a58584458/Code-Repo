//
//  RemoteEventsManager.h
//  iNfrared
//
//  Created by George Dean on 11/29/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum
	{
		RBNone,
		RBPlayPause,
		RBNext,
		RBPrevious,
		RBVolumeUp,
		RBVolumeDown,
		RBMenu
	} RemoteButton;


@protocol RemoteEventsReceiver <NSObject>

- (void) buttonPressed: (RemoteButton)button;

@optional
- (void) buttonHeld: (RemoteButton)button;

@end



@interface RemoteEventsManager : NSObject {

}

+ (void) addReceiver: (id <RemoteEventsReceiver>)receiver;

+ (void) buttonPressed: (RemoteButton)button;
+ (void) buttonHeld: (RemoteButton)button;

@end
