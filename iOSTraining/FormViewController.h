//
//  FormViewController.h
//  iOSTraining
//
//  Created by Derek Neely on 10/12/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSubmitAlertView    2000

@interface FormViewController : UIViewController <UITextFieldDelegate, UIActionSheetDelegate, UIAlertViewDelegate> {
    IBOutlet UISlider *slider;
    IBOutlet UILabel *sliderValueLabel;
    
    IBOutlet UISwitch *switchView;
    IBOutlet UILabel *switchValueLabel;
    
    IBOutlet UILabel *textInputLabel;
    
    IBOutlet UIButton *contactButton;
}

- (IBAction)sliderDidChange:(id)sender;
- (IBAction)switchValueDidChange:(id)sender;
- (IBAction)contactButtonPressed:(id)sender;
- (IBAction)submitButtonPressed:(id)sender;

@end
