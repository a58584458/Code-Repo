//
//  MyPickerViewController.m
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "MyPickerViewController.h"

@implementation MyPickerViewController

@synthesize colors, names;

#pragma mark - Picker Delegate Methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSLog(@"Picker Value: %@", [colors objectAtIndex:row]);
    
    if (component == 0) {
        myColorLabel.text = [colors objectAtIndex:row];
    }
    
    if (component == 1) {
        myColorLabel2.text = [names objectAtIndex:row];
    }
}

#pragma mark - Picker Datasource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (component == 0) {
        return [colors count];
    }
    
    if (component == 1) {
        return [names count];
    }
    
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [colors objectAtIndex:row];
    }
    
    if (component == 1) {
        return [names objectAtIndex:row];
    }
    
    return @"WHOOPS";
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"Picker";
    
    colors = [[NSArray alloc] initWithObjects:@"Blue",
              @"Green",
              @"Black",
              @"Yellow",
              @"Purple",
              @"Orange", nil];
    
    names = [[NSArray alloc] initWithObjects:@"Derek", 
             @"Jack", 
             @"Scott", 
             @"Egg", nil];
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
