//
//  MyModalViewController.h
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyModalViewController : UIViewController {
    IBOutlet UIView *portraitView;
    IBOutlet UIView *landscapeView;
}

- (IBAction)closeButtonPressed:(id)sender;

@end
