//
//  TerminalController.h
//  FSK Terminal
//
//  Created by George Dean on 12/21/08.
//  Copyright Perceptive Development 2008. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CharReceiver.h"

@interface TerminalController : UIViewController <CharReceiver>
{
	UITextView* textReceived;
	UITextView* textSent;
	int highestLocation;
}

@property (nonatomic, assign) IBOutlet UITextView* textReceived;
@property (nonatomic, assign) IBOutlet UITextView* textSent;

@end

