//
//  HomeViewController.m
//  iOSTraining
//
//  Created by Derek Neely on 10/12/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "HomeViewController.h"

#import "FormViewController.h"
#import "MyPickerViewController.h"
#import "MyModalViewController.h"
#import "MyTableViewController.h"

@implementation HomeViewController

@synthesize locationManager;

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
    NSLog(@"didUpdateToLocation: %@", newLocation);
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	NSLog(@"locationManager didFaileWithError: %@", error);
}


#pragma mark - Button Methods

- (IBAction)logButtonPressed:(id)sender {
    NSLog(@"logButtonPressed");
}

- (IBAction)formButtonPressed:(id)sender {
    NSLog(@"formButtonPressed");
    
    FormViewController *formViewController = [[FormViewController alloc] initWithNibName:@"FormViewController" bundle:nil];
    [self.navigationController pushViewController:formViewController animated:YES];
    [formViewController release];
}

- (IBAction)pickerButtonPressed:(id)sender {
    NSLog(@"pickerButtonPressed");
    
    MyPickerViewController *myPickerController = [[MyPickerViewController alloc] initWithNibName:@"MyPickerViewController" bundle:nil];
    [self.navigationController pushViewController:myPickerController animated:YES];
    [myPickerController release];
}

- (IBAction)modalButtonPressed:(id)sender {
    NSLog(@"modalButtonPressed");
    
    MyModalViewController *myModalViewController = [[MyModalViewController alloc] initWithNibName:@"MyModalViewController" bundle:nil];
    
    //[myModalViewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    //[myModalViewController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    //[myModalViewController setModalTransitionStyle:UIModalTransitionStylePartialCurl];
    
    [self presentModalViewController:myModalViewController animated:YES];
    [myModalViewController release];
}

- (IBAction)tableViewButtonPressed:(id)sender {
    NSLog(@"tableViewButtonPressed");
    
    MyTableViewController *myTableViewController = [[MyTableViewController alloc] initWithNibName:@"MyTableViewController" bundle:nil];
    [self.navigationController pushViewController:myTableViewController animated:YES];
    [myTableViewController release];
}

- (IBAction)gpsButtonPressed:(id)sender {
    NSLog(@"GPS Button Pressed");
    
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	[locationManager startUpdatingLocation];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"Home";
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
@end
