//
//  RawPulseLogger.h
//  iNfrared
//
//  Created by George Dean on 12/22/08.
//  Copyright 2008 Perceptive Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PulseCodeRecognizer.h"


@interface RawPulseLogger : PulseCodeRecognizer {
	NSMutableString* buffer;
}

- (void) idle: (UInt64)nanosec;
- (void) reset;

- (void) pulse: (UInt64)nanosec;
- (void) pause: (UInt64)nanosec;

@end
