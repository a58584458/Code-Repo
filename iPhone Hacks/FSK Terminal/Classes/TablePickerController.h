//
//  TablePickerController.h
//  FSK Terminal
//
//  Created by George Dean on 1/31/09.
//  Copyright 2009 Perceptive Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TablePickerController;

@protocol TablePickerDelegate

- (void) tablePicker:(TablePickerController*)tablePicker didSelectItem:(id)value named:(NSString*)name;

@end


@interface TablePickerController : UITableViewController {
	NSDictionary* items;
	NSArray* sortedKeys;
	id<TablePickerDelegate> pickerDelegate;
}

+ (TablePickerController*) controllerWithDictionary:(NSDictionary*)dict
										   delegate:(id<TablePickerDelegate>)delegate;

- (id) initWithDictionary:(NSDictionary*)dict
				 delegate:(id<TablePickerDelegate>)delegate;

@end
