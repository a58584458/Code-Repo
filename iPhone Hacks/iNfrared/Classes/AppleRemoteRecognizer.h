//
//  AppleRemoteRecognizer.h
//  iNfrared
//
//  Created by George Dean on 11/28/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "PulseCodeRecognizer.h"
#import "RemoteEventsManager.h"


@interface AppleRemoteRecognizer : PulseCodeRecognizer {
	unsigned recState;
	UInt64 bits;
	int bitCount;
	RemoteButton lastButton;
	UInt64 lastSepLength;
}

@end
