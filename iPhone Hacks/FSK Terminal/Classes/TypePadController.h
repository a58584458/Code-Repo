//
//  TypePadController.h
//  FSK Terminal
//
//  Created by George Dean on 1/15/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharReceiver.h"
#import "TablePickerController.h"

@class ScanCodeConverter;
@class TypePadCharLogger;

@interface TypePadController : UIViewController <CharReceiver, TablePickerDelegate> {
	UITextView* textView;
	UIBarButtonItem* selectButton;
	NSMutableDictionary* converters;
	ScanCodeConverter* selectedConverter;
	TypePadCharLogger* logger;
}

@property (nonatomic, retain) IBOutlet UITextView* textView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* selectButton;

- (IBAction) selectConverter:(id)sender;

- (void) addConverter:(ScanCodeConverter*)converter named:(NSString*)name;

@end
