//
//  TypePadController.m
//  FSK Terminal
//
//  Created by George Dean on 1/15/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import "TypePadController.h"
#import "ScanCodeConverter.h"

@interface TypePadCharLogger : NSObject <CharReceiver>
{
	TypePadController* parent;
}

@property (nonatomic, assign) TypePadController* parent;

@end


@implementation TypePadCharLogger

@synthesize parent;

- (void) receivedChar:(char) input
{
	if(input == 8)
	{
		NSString* temp = parent.textView.text;
		if(temp.length)
			parent.textView.text = [temp substringToIndex:temp.length - 1];
	}
	else
		parent.textView.text = [parent.textView.text stringByAppendingFormat:@"%c", input];
}

@end



@implementation TypePadController

@synthesize textView, selectButton;

- (id) initWithCoder: (NSCoder*)coder
{
    if (self = [super initWithCoder:coder]) {
        converters = [[NSMutableDictionary alloc] init];
		logger = [[TypePadCharLogger alloc] init];
		logger.parent = self;
    }
    return self;
}

- (IBAction) selectConverter:(id)sender
{
	[self.navigationController pushViewController:[TablePickerController controllerWithDictionary:converters 
																						 delegate:self]
	 animated:YES];
}

- (void) setConverter:(ScanCodeConverter*)converter named:(NSString*)name
{
	self.selectButton.title = name;
	selectedConverter = converter;
}

- (void) tablePicker:(TablePickerController*)tablePicker didSelectItem:(id)value named:(NSString*)name
{
	[self setConverter:value named:name];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void) addConverter:(ScanCodeConverter*)converter named:(NSString*)name
{
	[converter addReceiver:logger];
	[converters setObject:converter forKey:name];
	if(!selectedConverter)
		[self setConverter:converter named:name];
}

- (void) receivedChar:(char)input
{
	[selectedConverter receivedChar:input];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void) dealloc {
    [super dealloc];
}


@end
