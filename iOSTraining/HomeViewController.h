//
//  HomeViewController.h
//  iOSTraining
//
//  Created by Derek Neely on 10/12/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
}

@property (nonatomic, retain) CLLocationManager *locationManager;

- (IBAction)logButtonPressed:(id)sender;
- (IBAction)formButtonPressed:(id)sender;
- (IBAction)pickerButtonPressed:(id)sender;
- (IBAction)modalButtonPressed:(id)sender;
- (IBAction)tableViewButtonPressed:(id)sender;
- (IBAction)gpsButtonPressed:(id)sender;

@end
