//
//  RawPulseLogger.m
//  iNfrared
//
//  Created by George Dean on 12/22/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "RawPulseLogger.h"
#import "iNfraredAppDelegate.h"

#define PULSE_BUFFER_MAX		1024

@implementation RawPulseLogger

- (id) init
{
	if(self = [super init])
	{
		buffer = [[NSMutableString alloc] initWithCapacity:1024];
	}
	return self;
}

- (void) flushBuffer
{
	iNfraredAppDelegate* delegate = (iNfraredAppDelegate*)[UIApplication sharedApplication].delegate;
	[delegate.pulseLog addEntry:buffer];
	[buffer setString:@""];
}

- (void) idle: (UInt64)nanosec
{
	if(buffer.length)
		[self flushBuffer];
}

- (void) reset
{
	if(buffer.length)
		[self flushBuffer];
}

- (void) pulse: (UInt64)nanosec
{
	[buffer appendFormat:@" %d", (unsigned)(nanosec / 1000)];
}

- (void) pause: (UInt64)nanosec
{
	if(!buffer.length)
	{
		[buffer appendFormat:@"======(%d)\n", (unsigned)(nanosec / 1000)];
		return;
	}
	else
	{
		if(buffer.length > PULSE_BUFFER_MAX)
		{
			[self flushBuffer];
			[buffer appendString:@"..."];
		}
		[buffer appendFormat:@" (%d)", (unsigned)(nanosec / 1000)];
	}
}

- (void) dealloc
{
	[buffer release];
	
	[super dealloc];
}

@end
