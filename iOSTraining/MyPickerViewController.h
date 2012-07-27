//
//  MyPickerViewController.h
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPickerViewController : UIViewController <UIPickerViewDataSource,UIPickerViewDelegate> {
    
    IBOutlet UILabel *myColorLabel;
    IBOutlet UILabel *myColorLabel2;
    
    NSArray *colors;
    NSArray *names;
}

@property (nonatomic,retain) NSArray *colors;
@property (nonatomic,retain) NSArray *names;

@end
