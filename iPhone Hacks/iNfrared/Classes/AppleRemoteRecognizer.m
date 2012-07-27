//
//  AppleRemoteRecognizer.m
//  iNfrared
//
//  Created by George Dean on 11/28/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "AppleRemoteRecognizer.h"
#import "iNfraredAppDelegate.h"


typedef enum {
	RSStart,
	RSPause,
	RSHoldEnd,
	RSHoldSuccess,
	RSPressBitSep,
	RSPressBit,
	RSFail
} RecState;


BOOL ApproximatelyEqual(unsigned v1, unsigned v2)
{
	if(v1>v2)
	{
		// XOR swap trick
		v1 ^= v2;
		v2 ^= v1;
		v1 ^= v2;
	}
	return (v1 * 10 / v2) >= 8;
}


unsigned ParitySum(unsigned bits)
{
	unsigned parity = 0;
	
	while (bits) {
		parity ^= (bits & 1);
		bits >>= 1;
	}
	
	return parity;
}


@implementation AppleRemoteRecognizer

- (id) init
{
	if (self = [super init])
	{
		[self reset];
	}
	
	return self;
}

- (void) reset
{
	bits = 0;
	bitCount = 0;
	recState = RSStart;
}


- (void) idle: (UInt64)nanosec
{
	if (nanosec < 15000000)
		return;
	iNfraredAppDelegate* appDelegate = (iNfraredAppDelegate*)[UIApplication sharedApplication].delegate;
	if (recState == RSHoldSuccess)
	{
		[appDelegate.eventsLog addEntry:@"Hold"];
		[RemoteEventsManager buttonHeld:lastButton];
	}
	else if(recState == RSPressBit && bits)
	{
		unsigned remoteID = (unsigned)(bits >> 24);
		unsigned buttonID = (unsigned)(bits >> 17) & 0x7F;
		unsigned parity = (unsigned)(bits >> 16) & 0x1;
		unsigned checkCode = (unsigned)(bits & 0xFFFF);
		[appDelegate.eventsLog addEntry:[NSString stringWithFormat:@"Press: button %02X remote %02X parity %X check code %04X", buttonID, remoteID, parity, checkCode]];
		
		RemoteButton button = RBNone;
		if (ParitySum((remoteID << 15) | buttonID) ^ parity) switch (buttonID) {
			case 0x1:
				button = RBMenu;
				break;
			case 0x2:
				button = RBPlayPause;
				break;
			case 0x3:
				button = RBNext;
				break;
			case 0x4:
				button = RBPrevious;
				break;
			case 0x5:
				button = RBVolumeUp;
				break;
			case 0x6:
				button = RBVolumeDown;
				break;
			default:
				break;
		}
		lastButton = button;
		if (button != RBNone)
			[RemoteEventsManager buttonPressed:button];
	}
	[self reset];
}


- (void) pulse: (UInt64)nanosec
{
	RecState newRecState = RSFail;
	switch(recState)
	{
		case RSStart:
			if(ApproximatelyEqual(nanosec, 9066000))
				newRecState = RSPause;
			break;
		case RSHoldEnd:
			if(ApproximatelyEqual(nanosec, 566000))
				newRecState = RSHoldSuccess;
			break;
		case RSPressBitSep:
			lastSepLength = nanosec;
			newRecState = RSPressBit;
			break;
	}
	recState = newRecState;
}


- (void) pause: (UInt64)nanosec
{
	if (nanosec > 15000000)
		return;
	RecState newRecState = RSFail;
	switch(recState)
	{
		case RSPause:
			if(ApproximatelyEqual(nanosec, 4533000))
				newRecState = RSPressBitSep;
			else if(ApproximatelyEqual(nanosec, 2266000))
				newRecState = RSHoldEnd;
			break;
		case RSPressBit:
			if(ApproximatelyEqual(nanosec + lastSepLength, 1133000))
			{
				newRecState = RSPressBitSep;
				bitCount++;
			}
			else if(ApproximatelyEqual(nanosec + lastSepLength, 2266000))
			{
				newRecState = RSPressBitSep;
				bits |= (((UInt64) 1) << bitCount);
				bitCount++;
			}
			break;
	}
	recState = newRecState;
}

@end
