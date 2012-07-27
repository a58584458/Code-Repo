//
//  MyTableViewController.m
//  iOSTraining
//
//  Created by Derek Neely on 10/13/11.
//  Copyright 2011 derekneely.com. All rights reserved.
//

#import "MyTableViewController.h"

@implementation MyTableViewController

@synthesize presidentsArray;

#pragma mark - TableView Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger row = [indexPath row];
    NSDictionary *president = [presidentsArray objectAtIndex:row];
    
    NSString *url = [president objectForKey:@"url"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - TableView Data Source Methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *PresidentListCellIdentifier = @"PresidentListCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PresidentListCellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:PresidentListCellIdentifier];
    }
    
    NSInteger row = [indexPath row];
    NSDictionary *president = [presidentsArray objectAtIndex:row];
    
    cell.textLabel.text = [president objectForKey:@"name"];
    cell.detailTextLabel.text = [president objectForKey:@"url"];
    
    cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [presidentsArray count];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = @"Table View";
    
    NSBundle *bundle = [NSBundle mainBundle];
	NSString *presidentListPlistPath = [bundle pathForResource:@"PresidentList" ofType:@"plist"];
	NSDictionary *presidentsDictionary = [NSDictionary dictionaryWithContentsOfFile:presidentListPlistPath];
    
    presidentsArray = [[NSArray alloc] initWithArray:[presidentsDictionary objectForKey:@"presidents"]];
    
    
    NSLog(@"Presidents Array: %@", presidentsArray);

    
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
