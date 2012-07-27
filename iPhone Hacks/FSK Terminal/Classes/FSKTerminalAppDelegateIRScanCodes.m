//
//  FSKTerminalAppDelegateIRScanCodes.m
//  FSK Terminal
//
//  Created by George Dean on 1/18/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import	"FSKTerminalAppDelegate.h"
#import "FSKTerminalAppDelegateIRScanCodes.h"
#import "ScanCodeConverter.h"
#import "TypePadController.h"


#define PUNCT_BIT  0x100
#define FN_BIT     0x200


ScanCodeEntry codeTableMicroInnovations[] = {
SCE_ALPHA(0x01, 'Q'),
SCE_ALPHA(0x09, 'W'),
SCE_ALPHA(0x11, 'E'),
SCE_ALPHA(0x19, 'R'),
SCE_ALPHA(0x21, 'T'),
SCE_ALPHA(0x29, 'Y'),
SCE_ALPHA(0x31, 'U'),
SCE_ALPHA(0x39, 'I'),
SCE_ALPHA(0x41, 'O'),
SCE_ALPHA(0x49, 'P'),
SCE_ALPHA(0x07, 'A'),
SCE_ALPHA(0x0F, 'S'),
SCE_ALPHA(0x17, 'D'),
SCE_ALPHA(0x1F, 'F'),
SCE_ALPHA(0x27, 'G'),
SCE_ALPHA(0x2F, 'H'),
SCE_ALPHA(0x32, 'J'),
SCE_ALPHA(0x3A, 'K'),
SCE_ALPHA(0x42, 'L'),
SCE_ALPHA(0x03, 'Z'),
SCE_ALPHA(0x0B, 'X'),
SCE_ALPHA(0x13, 'C'),
SCE_ALPHA(0x1B, 'V'),
SCE_ALPHA(0x23, 'B'),
SCE_ALPHA(0x33, 'N'),
SCE_ALPHA(0x3B, 'M'),
SCE_SHIFTPAIR(0x51, '-', '_'),
SCE_SHIFTPAIR(0x4A, ';', ':'),
SCE_SHIFTPAIR(0x52, '\'', '"'),
SCE_SHIFTPAIR(0x43, ',', '<'),
SCE_SHIFTPAIR(0x4B, '.', '>'),
{0, 0x2B, ' '},
{0, 0x34, ' '},
//{0, 0x44, '\n'},
//{0, 0x4C, '\n'},
//{0, 0x53, '\n'},
//{0, 0x54, '\n'},
{0, 0x59, '\x8'},
{0, 0x5A, '\n'},
//{0, 0x5B, '\n'},
{0, 0x69, '\t'},
{0, 0x77, MOD_PRESS_TOGGLE + CAPS_BIT},
{0, 0x65, MOD_HOLD_TOGGLE + LSHIFT_BIT + SHIFT_BIT},
{0, 0x7D, MOD_HOLD_TOGGLE + RSHIFT_BIT + SHIFT_BIT},
{0, 0x6D, MOD_HOLD_SET + CTRL_BIT},
{0, 0x76, MOD_HOLD_SET + PUNCT_BIT},
{0, 0x75, MOD_HOLD_SET + CMD_BIT},
{0, 0x6E, MOD_HOLD_TOGGLE + NUMLOCK_BIT},
{0, 0x66, MOD_HOLD_SET + ALT_BIT},
{0, 0x3C, MOD_HOLD_SET + FN_BIT},
{SHIFT_BIT, 0x6E, MOD_PRESS_TOGGLE + NUMLOCK_BIT},
{NUMLOCK_BIT, 0x01, '1'},
{NUMLOCK_BIT, 0x09, '2'},
{NUMLOCK_BIT, 0x11, '3'},
{NUMLOCK_BIT, 0x19, '4'},
{NUMLOCK_BIT, 0x21, '5'},
{NUMLOCK_BIT, 0x29, '6'},
{NUMLOCK_BIT, 0x31, '7'},
{NUMLOCK_BIT, 0x39, '8'},
{NUMLOCK_BIT, 0x41, '9'},
{NUMLOCK_BIT, 0x49, '0'},
{NUMLOCK_BIT, 0x51, '/'},
{NUMLOCK_BIT, 0x32, '4'},
{NUMLOCK_BIT, 0x3A, '5'},
{NUMLOCK_BIT, 0x42, '6'},
{NUMLOCK_BIT, 0x4A, '*'},
{NUMLOCK_BIT, 0x3B, '1'},
{NUMLOCK_BIT, 0x43, '2'},
{NUMLOCK_BIT, 0x4B, '3'},
{NUMLOCK_BIT, 0x53, '-'},
{NUMLOCK_BIT, 0x54, '='},
{NUMLOCK_BIT, 0x4C, '+'},
{NUMLOCK_BIT, 0x44, '.'},
{NUMLOCK_BIT, 0x3C, '0'},
{PUNCT_BIT, 0x01, '!'},
{PUNCT_BIT, 0x09, '@'},
{PUNCT_BIT, 0x11, '#'},
{PUNCT_BIT, 0x19, '$'},
{PUNCT_BIT, 0x21, '%'},
{PUNCT_BIT, 0x29, '^'},
{PUNCT_BIT, 0x31, '&'},
{PUNCT_BIT, 0x39, '*'},
{PUNCT_BIT, 0x41, '('},
{PUNCT_BIT, 0x49, ')'},
{PUNCT_BIT, 0x51, '+'},
{PUNCT_BIT, 0x07, '`'},
{PUNCT_BIT, 0x0F, '~'},
{PUNCT_BIT, 0x17, '/'},
{PUNCT_BIT, 0x1F, '?'},
{PUNCT_BIT, 0x27, '['},
{PUNCT_BIT, 0x2F, ']'},
{PUNCT_BIT, 0x32, '{'},
{PUNCT_BIT, 0x3A, '}'},
{PUNCT_BIT, 0x42, '\\'},
{PUNCT_BIT, 0x4A, '|'},
{PUNCT_BIT, 0x52, '='}
};

ScanCodeEntry codeTablePC[] = {
SCE_SHIFTPAIR(0x02, '1', '!'),
SCE_SHIFTPAIR(0x03, '2', '@'),
SCE_SHIFTPAIR(0x04, '3', '#'),
SCE_SHIFTPAIR(0x05, '4', '$'),
SCE_SHIFTPAIR(0x06, '5', '%'),
SCE_SHIFTPAIR(0x07, '6', '^'),
SCE_SHIFTPAIR(0x08, '7', '&'),
SCE_SHIFTPAIR(0x09, '8', '*'),
SCE_SHIFTPAIR(0x0A, '9', '('),
SCE_SHIFTPAIR(0x0B, '0', ')'),
SCE_SHIFTPAIR(0x0C, '-', '_'),
SCE_SHIFTPAIR(0x0D, '=', '+'),
{0, 0x0E, '\x8'},
{0, 0x0F, '\t'},
SCE_ALPHA(0x10, 'Q'),
SCE_ALPHA(0x11, 'W'),
SCE_ALPHA(0x12, 'E'),
SCE_ALPHA(0x13, 'R'),
SCE_ALPHA(0x14, 'T'),
SCE_ALPHA(0x15, 'Y'),
SCE_ALPHA(0x16, 'U'),
SCE_ALPHA(0x17, 'I'),
SCE_ALPHA(0x18, 'O'),
SCE_ALPHA(0x19, 'P'),
{0, 0x1C, '\n'},
SCE_ALPHA(0x1E, 'A'),
SCE_ALPHA(0x1F, 'S'),
SCE_ALPHA(0x20, 'D'),
SCE_ALPHA(0x21, 'F'),
SCE_ALPHA(0x22, 'G'),
SCE_ALPHA(0x23, 'H'),
SCE_ALPHA(0x24, 'J'),
SCE_ALPHA(0x25, 'K'),
SCE_ALPHA(0x26, 'L'),
SCE_SHIFTPAIR(0x27, ';', ':'),
SCE_SHIFTPAIR(0x28, '\'', '"'),
SCE_SHIFTPAIR(0x29, '`', '~'),
SCE_SHIFTPAIR(0x2B, '\\', '|'),
SCE_ALPHA(0x2C, 'Z'),
SCE_ALPHA(0x2D, 'X'),
SCE_ALPHA(0x2E, 'C'),
SCE_ALPHA(0x2F, 'V'),
SCE_ALPHA(0x30, 'B'),
SCE_ALPHA(0x31, 'N'),
SCE_ALPHA(0x32, 'M'),
SCE_SHIFTPAIR(0x33, ',', '<'),
SCE_SHIFTPAIR(0x34, '.', '>'),
SCE_SHIFTPAIR(0x35, '/', '?'),
{0, 0x39, ' '},
{0, 0x63, ' '},
{0, 0x3A, MOD_PRESS_TOGGLE + CAPS_BIT},
{0, 0x2A, MOD_HOLD_TOGGLE + LSHIFT_BIT + SHIFT_BIT},
{0, 0x36, MOD_HOLD_TOGGLE + RSHIFT_BIT + SHIFT_BIT},
{0, 0x1D, MOD_HOLD_SET + CTRL_BIT},
{0, 0x61, MOD_HOLD_SET + FN_BIT},
{0, 0x38, MOD_HOLD_SET + ALT_BIT},
{0, 0x62, MOD_HOLD_SET + CMD_BIT},
};

@implementation FSKTerminalAppDelegate (IRScanCodes)

- (void) buildScanCodes
{
	ScanCodeConverter* codeConverterPC =
	[[ScanCodeConverter alloc] initWithCodeTable:codeTablePC
										   count:sizeof(codeTablePC)/sizeof(ScanCodeEntry)];
	
	[typeController addConverter:codeConverterPC named:@"IBM PC-Compatible"];
	[codeConverterPC release];	
	
	ScanCodeConverter* codeConverterMI =
		[[ScanCodeConverter alloc] initWithCodeTable:codeTableMicroInnovations
											   count:sizeof(codeTableMicroInnovations)/sizeof(ScanCodeEntry)];
	
	[typeController addConverter:codeConverterMI named:@"Micro Innovations"];
	[codeConverterMI release];
}

@end
