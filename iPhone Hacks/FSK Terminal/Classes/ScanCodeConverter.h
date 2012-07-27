//
//  ScanCodeConverter.h
//  FSK Terminal
//
//  Created by George Dean on 1/18/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharReceiver.h"

typedef struct {
	UInt16 reqModFlags;
	UInt8 code;
	UInt16 result;
} ScanCodeEntry;

#define MOD_HOLD_SET     0x1000
#define MOD_HOLD_TOGGLE  0x2000
#define MOD_PRESS_TOGGLE 0x4000

#define SHIFT_BIT      0x01
#define CAPS_BIT       0x02
#define NUMLOCK_BIT    0x04
#define CTRL_BIT       0x08
#define CMD_BIT        0x10
#define ALT_BIT        0x20
#define LSHIFT_BIT     0x40
#define RSHIFT_BIT     0x80

#define SCE_SHIFTPAIR(__code__, __normal__, __shifted__)  {0, __code__, __normal__}, \
                                                          {SHIFT_BIT, __code__, __shifted__}

#define SCE_ALPHA(__code__, __ucase__)  {0, __code__, __ucase__ + 0x20}, \
										{CAPS_BIT, __code__, __ucase__}, \
										{SHIFT_BIT, __code__, __ucase__}, \
                                        {CAPS_BIT + SHIFT_BIT, __code__, __ucase__ + 0x20}

@class MultiDelegate, ScanCodeConverterKeyTracker;

@interface ScanCodeConverter : NSObject <CharReceiver>
{
	ScanCodeConverterKeyTracker* keyTrackers[128];
	UInt16 modFlags;
	MultiDelegate<CharReceiver>* receivers;
}

- initWithCodeTable:(ScanCodeEntry*)table
			  count:(int)tableCount;

- (void) addReceiver:(id<CharReceiver>)receiver;

@end
