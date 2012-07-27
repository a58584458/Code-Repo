//
//  CodeRecognizer.h
//  iNfrared
//
//  Created by George Dean on 11/28/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import "PatternRecognizer.h"

@interface PulseCodeRecognizer: NSObject <PatternRecognizer> {
	int	firstEdgeSign;
	int	lastEdgeSign;
}

- (void) edge: (int)height width:(UInt64)nsWidth interval:(UInt64)nsInterval;
- (void) idle: (UInt64)nanosec;
- (void) reset;

- (void) pulse: (UInt64)nanosec;
- (void) pause: (UInt64)nanosec;

@end
