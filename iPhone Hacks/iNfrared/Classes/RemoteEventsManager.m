//
//  RemoteEventsManager.m
//  iNfrared
//
//  Created by George Dean on 11/29/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "RemoteEventsManager.h"

volatile static NSMutableSet* globalReceiverSet = nil;

@implementation RemoteEventsManager

+ (void) initialize
{
	globalReceiverSet = [[NSMutableSet alloc] init];
}

+ (void) addReceiver: (id <RemoteEventsReceiver>) receiver
{
	[globalReceiverSet addObject:receiver];
}

+ (void) buttonPressed: (RemoteButton)button
{
	for (id<RemoteEventsReceiver> receiver in globalReceiverSet) {
		[receiver buttonPressed:button];
	}
}

+ (void) buttonHeld: (RemoteButton)button
{
	for (id<RemoteEventsReceiver> receiver in globalReceiverSet) {
		if([receiver respondsToSelector:@selector(buttonHeld:)])
			[receiver buttonHeld:button];
	}
}

@end
