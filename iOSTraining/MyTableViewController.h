//
//  MyTableViewController.h
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTableViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    NSArray *presidentsArray;
}

@property (nonatomic, retain) NSArray *presidentsArray;

@end
