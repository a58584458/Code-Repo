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

#import "util.h"

@interface MigrateFolder0to1
    : NSEntityMigrationPolicy
@end


@implementation MigrateFolder0to1

- (BOOL) endRelationshipCreationForEntityMapping: (NSEntityMapping*) mapping
                                         manager: (NSMigrationManager*) manager
                                           error: (NSError**) error
{
    DBLog(@"%@: endRelationships", self);
    NSManagedObjectContext *dstContext = manager.destinationContext;

    // create a default folder for otherwise unfiled barcodes
    NSManagedObject *folder =
        [NSEntityDescription
            insertNewObjectForEntityForName: @"Folder"
            inManagedObjectContext: dstContext];
    [folder setValue: @"Unfiled Barcodes"
            forKey: @"name"];
    [folder setValue: [NSNumber numberWithInt: 0]
            forKey: @"index"];
    [folder setValue: [NSNumber numberWithBool: YES]
            forKey: @"sticky"];

    // grab all of the migrated barcodes
    NSFetchRequest *request = [NSFetchRequest new];
    [request setEntity:
        [NSEntityDescription entityForName: @"Barcode"
                             inManagedObjectContext: dstContext]];
    NSArray *allBarcodes =
        [dstContext executeFetchRequest: request
                    error: error];
    [request release];
    if(!allBarcodes && *error)
        return(NO);

    // put all barcodes in the new default folder
    [folder setValue: [NSSet setWithArray: allBarcodes]
            forKey: @"barcodes"];
    DBLog(@"folder=%@", folder);

    return([super endRelationshipCreationForEntityMapping: mapping
                  manager: manager
                  error: error]);
}

@end
