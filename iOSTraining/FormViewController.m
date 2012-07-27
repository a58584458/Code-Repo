//
//  FormViewController.m
//  iOSTraining
//
//  Created by Derek Neely on 10/12/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "FormViewController.h"

@implementation FormViewController

#pragma mark - Form Input Methods

- (IBAction)sliderDidChange:(id)sender {
    NSLog(@"sliderDidChange");
    
    //sliderValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
    
    float increment = 10.0;
	slider.value = roundf(slider.value/increment) * increment;
    sliderValueLabel.text = [NSString stringWithFormat:@"%f", slider.value];
    
}

- (IBAction)switchValueDidChange:(id)sender {
    NSLog(@"switchValueDidChange");
    
    if (switchView.on) {
        switchValueLabel.text = @"On";
    } else {
        switchValueLabel.text = @"Off";
    }
}

- (IBAction)contactButtonPressed:(id)sender {
    NSLog(@"contactButtonPressed");
    
    UIActionSheet *contactActionSheet = [[UIActionSheet alloc] 
                                         initWithTitle:@"Contact Method?" 
                                         delegate:self
                                         cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:@"Destruct"
                                         otherButtonTitles:@"Email", @"Phone", @"Pigeon", @"Text", nil];
    
    [contactActionSheet showInView:self.view];
    [contactActionSheet release];
}

- (IBAction)submitButtonPressed:(id)sender {
    NSLog(@"submitButtonPressed");
    
    UIAlertView *submitAlertView = [[UIAlertView alloc] 
                                    initWithTitle:@"Submit?" 
                                    message:@"Are you sure you want to submit this information? Cannot be undone." 
                                    delegate:self 
                                    cancelButtonTitle:@"Cancel"
                                    otherButtonTitles:@"Submit", nil];
    
    submitAlertView.tag = kSubmitAlertView;
    [submitAlertView show];
    [submitAlertView release];
}

#pragma mark - UIAlertView Delegate Methods

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView.tag == kSubmitAlertView) {
        switch (buttonIndex) {
            case 0:
                NSLog(@"Cancel");
                break;
            case 1:
                NSLog(@"Submit");
                break;
        }
    }
}

#pragma mark - UIActionSheet Delegate Methods

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    NSLog(@"buttonIndex: %i", buttonIndex);
    
    NSString *contactString;
    switch (buttonIndex) {
        case 0:
            contactString = @"CHOOSE";
            break;
        
        case 1:
            contactString = @"Email";
            break;
        
        case 2:
            contactString = @"Phone";
            break;
        
        case 3:
            contactString = @"Pigeon";
            break;
        
        case 4:
            contactString = @"Text";
            break;
        
        case 5:
            contactString = @"CHOOSE";
            break;
            
        default:
            contactString = @"CHOOSE";
            break;
    }
    
    [contactButton setTitle:[NSString stringWithFormat:@"Contact Method: %@", contactString] 
                   forState:UIControlStateNormal];
}

#pragma mark - UITextView Delegate Methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSLog(@"shouldChangeCharactersInRange");
    
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    
    textInputLabel.text = [NSString stringWithFormat:@"%@%@", textField.text, string];
    
    return YES;
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"My Form";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

@end
