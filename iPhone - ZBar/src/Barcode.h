//------------------------------------------------------------------------
//  Copyright 2009-2011 (c) Jeff Brown <spadix@users.sourceforge.net>
//
//  This file is part of the ZBar iPhone App.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  http://zbar.sourceforge.net/iphone
//------------------------------------------------------------------------

@class Folder;

/* simple data model for saving a list of barcodes:
 */

@interface Barcode
    : NSManagedObject
{
    UIImage *image;                     // tmp original image
    ZBarSymbol *symbol;                 // tmp symbol info
    NSMutableDictionary *classification; // classification info
    NSString *classificationText;       // classification description
    BOOL scraped;                       // scrape already attempted
}

@property (nonatomic, retain) NSDate *date;
@property (nonatomic, retain) NSNumber *type;
@property (nonatomic, retain) NSString *data;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) UIImage *thumb;
@property (nonatomic, retain) NSData *thumbImage;
@property (nonatomic, retain) UIImage *primitiveThumb;

@property (nonatomic, retain) Folder *folder;

// non-modeled properties
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, readonly) NSString *title;  // name or data
@property (nonatomic, readonly) NSDictionary *classification;
@property (nonatomic, readonly) NSString *classificationText;
@property (nonatomic, retain) ZBarSymbol *symbol;

- (NSArray*) applyActions;
- (void) updateName: (NSString*) name;

@end
