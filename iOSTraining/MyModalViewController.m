//
//  MyModalViewController.m
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "MyModalViewController.h"

@implementation MyModalViewController

CGFloat degreesToRadian(CGFloat degrees) {
    return degrees * M_PI / 180;
};


- (IBAction)closeButtonPressed:(id)sender {
    NSLog(@"closeButtonPressed");
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if(toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"UIInterfaceOrientationPortrait");
        
        self.view = portraitView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(0));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"UIInterfaceOrientationLandscapeLeft");
        
        self.view = landscapeView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(-90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    } else if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"UIInterfaceOrientationPortraitUpsideDown");
        
        self.view = portraitView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(180));
        self.view.bounds = CGRectMake(0.0, 0.0, 320.0, 460.0);
        
    } else if(toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"UIInterfaceOrientationLandscapeRight");
        
        self.view = landscapeView;
        self.view.transform = CGAffineTransformIdentity;
        self.view.transform = CGAffineTransformMakeRotation(degreesToRadian(90));
        self.view.bounds = CGRectMake(0.0, 0.0, 480.0, 300.0);
    }
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
