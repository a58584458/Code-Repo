//
//  CodeRecognizer.m
//  iNfrared
//
//  Created by George Dean on 11/28/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "PulseCodeRecognizer.h"


@implementation PulseCodeRecognizer

- (void) edge: (int)height width:(UInt64)nsWidth interval:(UInt64)nsInterval
{
	int edgeSign = height < 0 ? -1 : 1;

	// Remember the +/- direction of the first significant edge
	if(firstEdgeSign == 0)
		firstEdgeSign = edgeSign;
	
	// Log the pulse or pause that this edge is terminating
	if(edgeSign == firstEdgeSign)
		[self pause:nsInterval];
	else
		[self pulse:nsInterval];
	
	// Save the edge sign
	lastEdgeSign = edgeSign;
}

- (void) idle: (UInt64)nanosec
{
}

- (void) pulse: (UInt64)nanosec
{
}

- (void) pause: (UInt64)nanosec
{
}

- (void) reset
{
	firstEdgeSign = lastEdgeSign = 0;
}

@end
