//------------------------------------------------------------------------
//  Copyright 2011 (c) Jeff Brown <spadix@users.sourceforge.net>
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

#import "Folder.h"
#import "Barcode.h"

#define DEBUG_MODULE Folder
#import "util.h"

@implementation Folder

@dynamic index, name, sticky, barcodes;

+ (Folder*) addDefaultFolderInContext: (NSManagedObjectContext*) context
{
    Folder *folder =
        [NSEntityDescription
            insertNewObjectForEntityForName: @"Folder"
            inManagedObjectContext: context];
    folder.index = 0;
    folder.name = @"Unfiled Barcodes";
    [folder setValue: [NSNumber numberWithBool: YES]
            forKey: @"sticky"];
    return(folder);
}

+ (Folder*) defaultFolderInContext: (NSManagedObjectContext*) context
{
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:
        [NSEntityDescription entityForName: @"Folder"
                             inManagedObjectContext: context]];
    [request setPredicate:
        [NSPredicate predicateWithFormat: @"sticky == YES"]];
    [request setSortDescriptors:
        [NSArray arrayWithObject:
            [NSSortDescriptor sortDescriptorWithKey: @"index"
                              ascending: YES]]];
    [request setFetchLimit: 1];

    NSError *error = nil;
    NSArray *results =
        [context executeFetchRequest: request
                 error: &error];
    [request release];

    if(!results)
        [error logWithMessage: @"fetching default folder"];
    else if(results.count)
        return([results objectAtIndex: 0]);

    return([Folder addDefaultFolderInContext: context]);
}

- (void) addInfoBarcodes
{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSDate *now = [NSDate date];
    NSNumber *qrtype = [NSNumber numberWithInteger: ZBAR_QRCODE];
    UIImage *qrimg = [UIImage imageNamed: @"sample-qr"];

    Barcode *barcode =
        [NSEntityDescription
            insertNewObjectForEntityForName: @"Barcode"
            inManagedObjectContext: context];
    barcode.folder = self;
    barcode.date = now;
    barcode.type = qrtype;
    barcode.data = @"http://zbar.sf.net/iphone";
    barcode.name = @"ZBar bar code reader - iPhone";
    barcode.thumb = qrimg;

    barcode = [NSEntityDescription
                  insertNewObjectForEntityForName: @"Barcode"
                  inManagedObjectContext: context];
    barcode.folder = self;
    barcode.date = now;
    barcode.type = qrtype;
    barcode.data = @"http://zbar.sf.net/iphone/userguide";
    barcode.name = @"User Guide - ZBar iPhone App";
    barcode.thumb = qrimg;
}

- (NSInteger) index
{
    [self willAccessValueForKey: @"index"];
    NSInteger val = index;
    [self didAccessValueForKey: @"index"];
    return(val);
}

- (void) setIndex: (NSInteger) val
{
    [self willChangeValueForKey: @"index"];
    index = val;
    [self didChangeValueForKey: @"index"];
}

- (BOOL) sticky
{
    [self willAccessValueForKey: @"sticky"];
    BOOL val = sticky;
    [self didAccessValueForKey: @"sticky"];
    return(val);
}

- (void) setSticky: (BOOL) val
{
    [self willChangeValueForKey: @"sticky"];
    sticky = val;
    [self didChangeValueForKey: @"sticky"];
}

@end
