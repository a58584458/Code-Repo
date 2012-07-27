//
//  ScanCodeConverter.m
//  FSK Terminal
//
//  Created by George Dean on 1/18/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import "ScanCodeConverter.h"
#import "MultiDelegate.h"

@interface ScanCodeConverterKeyTracker : NSObject
{
	NSMutableData* entries;
	int activeEntry;
}

- (id) initWithEntry:(ScanCodeEntry*)entry;
- (void) addEntry:(ScanCodeEntry*)entry;

- (UInt16) pressKeyWithModifiers:(UInt16)modFlags;
- (UInt16) releaseKey;

@end


typedef struct {
	UInt16 reqModFlags;
	UInt16 result;
} ScanCodeInternalEntry;


@implementation ScanCodeConverterKeyTracker

- (id) initWithEntry:(ScanCodeEntry*)entry
{
	if(self = [super init])
	{
		entries = [[NSMutableData alloc] initWithCapacity:sizeof(ScanCodeInternalEntry)];
		activeEntry = -1;
		[self addEntry:entry];
	}
	
	return self;
}

- (void) addEntry:(ScanCodeEntry*)entry
{
	ScanCodeInternalEntry e = {entry->reqModFlags, entry->result};
	[entries appendBytes:&e length:sizeof(ScanCodeInternalEntry)];
}

- (UInt16) pressKeyWithModifiers:(UInt16)modFlags
{
	if(activeEntry != -1)
		return 0;
	
	const ScanCodeInternalEntry *pEntry = [entries bytes];
	int numEntries = [entries length] / sizeof(ScanCodeInternalEntry);
	
	int leastExtraBits, matchIndex = -1;
	UInt16 bestResult = 0;
	
	for(int i=0; i<numEntries; i++, pEntry++)
	{
		if((pEntry->reqModFlags & modFlags) == pEntry->reqModFlags)
		{
			int extraBitCount = 0;
			UInt16 extraBits = modFlags & ~pEntry->reqModFlags;
			while (extraBits)
			{
				if(extraBits & 1)
					extraBitCount++;
				extraBits >>= 1;
			}
			
			if (matchIndex == -1 || extraBitCount < leastExtraBits)
			{
				matchIndex = i;
				leastExtraBits = extraBitCount;
				bestResult = pEntry->result;
			}
		}
	}
	
	activeEntry = matchIndex;
	return bestResult;
}

- (UInt16) releaseKey
{
	if(activeEntry == -1)
		return 0;
	
	const ScanCodeInternalEntry *pEntry = [entries bytes];
	pEntry += activeEntry;
	activeEntry = -1;
	return pEntry->result;
}

@end



@implementation ScanCodeConverter

- initWithCodeTable:(ScanCodeEntry*)table
			  count:(int)tableCount
{
	if(self = [super init])
	{
		ScanCodeEntry* entry = table;
		for(int i=0; i<tableCount; i++, entry++)
		{
			char code = entry->code;
			if(keyTrackers[code])
				[keyTrackers[code] addEntry:entry];
			else
				keyTrackers[code] = [[ScanCodeConverterKeyTracker alloc] initWithEntry:entry];
		}
		receivers = [[MultiDelegate alloc] init];
	}
	
	return self;
}

- (void) addReceiver:(id<CharReceiver>)receiver
{
	[receivers addDelegate:receiver];
}

- (void) receivedChar:(char)input
{
	BOOL release = (input&0x80)?YES:NO;
	char baseCode = input & 0x7F;
	if(!release)
	{
		UInt16 result = [keyTrackers[baseCode] pressKeyWithModifiers:modFlags];
		if(!result) return;
		UInt16 data = result & 0xfff;
		switch (result & 0xf000) {
			case 0:
				// Plain character
				[receivers receivedChar:(char)result];
				break;
			case MOD_HOLD_SET:
				modFlags |= data;
				break;
			case MOD_HOLD_TOGGLE:
			case MOD_PRESS_TOGGLE:
				modFlags ^= data;
				break;
		}
	}
	else
	{
		UInt16 result = [keyTrackers[baseCode] releaseKey];
		if(!result) return;
		UInt16 data = result & 0xfff;
		switch (result & 0xf000) {
			case 0:
			case MOD_PRESS_TOGGLE:
				// No release action for plain presses or mod presses
				break;
			case MOD_HOLD_SET:
				modFlags &= ~data;
				break;
			case MOD_HOLD_TOGGLE:
				modFlags ^= data;
				break;
		}
	}
}

- (void) dealloc
{
	for(int i=0; i<128; i++)
		[keyTrackers[i] release];
	
	[receivers release];
	[super dealloc];
}

@end
