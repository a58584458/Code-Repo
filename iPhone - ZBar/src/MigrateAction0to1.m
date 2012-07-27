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

#import "Action.h"
#import "util.h"

@interface MigrateAction0to1
    : NSEntityMigrationPolicy
{
    NSDictionary *classmap;
    NSSet *urlmap;
    NSMutableArray *actions;
}
@end


@implementation MigrateAction0to1

static NSString *UPS_GROUND = @"UPS Ground Tracking#";
static NSString *FEDEX_GROUND = @"FedEx Ground Tracking#";
static NSString *FEDEX_EXPRESS = @"FedEx Express Tracking#";

- (BOOL) beginEntityMapping: (NSEntityMapping*) mapping
                    manager: (NSMigrationManager*) manager
                      error: (NSError**) error
{
    DBLog(@"%@: beginMapping", self);
    actions = [NSMutableArray new];

    urlmap =
        [[NSSet alloc]
            initWithObjects:
                @"http://google.com/search?q=",
                @"http://www.amazon.com/s/?url=search-alias%3Daps&field-keywords=",
                @"http://www.upcdatabase.com/item.asp?upc=",
                @"",
                @"mailto:",
                @"http://wwwapps.ups.com/etracking/tracking.cgi?TypeOfInquiryNumber=T&InquiryNumber1=",
                @"http://www.fedex.com/Tracking?tracknumbers=",
                nil];

    classmap =
        [[NSDictionary alloc]
            initWithObjectsAndKeys:
                @"{Email}", @"E-mail address",
                @"{UPS Package}", UPS_GROUND,
                @"{FedEx Ground Package}", FEDEX_GROUND,
                @"{FedEx Express Package}", FEDEX_EXPRESS,
                @"{FedEx Package}", [NSSet setWithObjects:
                                        FEDEX_GROUND, FEDEX_EXPRESS, nil],
                @"{Package}", [NSSet setWithObjects:
                                  UPS_GROUND, FEDEX_GROUND, FEDEX_EXPRESS, nil],
                nil];

    return([super beginEntityMapping: mapping
                  manager: manager
                  error: error]);
}

- (BOOL) createDestinationInstancesForSourceInstance: (NSManagedObject*) src
                                       entityMapping: (NSEntityMapping*) mapping
                                             manager: (NSMigrationManager*) manager
                                               error: (NSError**) error
{
    NSString *url = [src valueForKey: @"url"];
    if([urlmap member: url] ||
       [url hasPrefix: @"mailto:"])
        // skip old default entries; new versions will be merged in
        // although any name or ordering changes are lost
        return(YES);

    // try to maintain custom action as closely as possible
    NSNumber *indexVal = [src valueForKey: @"index"];
    NSInteger index = indexVal.integerValue;
    NSString *name = [src valueForKey: @"name"];
    NSSet *classes = [src valueForKey: @"classes"];
    NSInteger n = classes.count;
    DBLog(@"%@: map[%d] name=%@ url=%@ ncls=%d", self, index, name, url, n);

    NSString *dstcls = nil;
    if(n == 1) {
        NSString *srccls = [[classes anyObject]
                               valueForKey: @"name"];
        DBLog(@"    srccls=%@", srccls);
        if(srccls) {
            dstcls = [classmap objectForKey: srccls];
            if(!dstcls)
                dstcls = [NSString stringWithFormat: @"{%@}", srccls];
        }
    }
    else if(n > 1) {
        assert(n > 1);
        NSMutableSet *srccls = [NSMutableSet setWithCapacity: n];
        for(NSManagedObject *cls in classes) {
            NSString *clsname = [cls valueForKey: @"name"];
            if(clsname)
                [srccls addObject: clsname];
        }
        DBLog(@"    srccls=%@", srccls);
        dstcls = [classmap objectForKey: srccls];
    }
    if(!dstcls)
        // FIXME something is very broken: action.classes is always empty for
        // some GTIN-13 cases?  (suspect one-way relationship didn't survive
        // binary to SQLite conversion)  fallback to reasonable alternative
        dstcls = @"{data}";
    url = [url stringByAppendingString: dstcls];

    NSDictionary *action =
        [NSDictionary dictionaryWithObjectsAndKeys:
            @"LinkAction", @"type",
            name, @"name",
            url, @"template",
            nil];
    DBLog(@"    action=%@", action);

    while(actions.count < index)
        [actions addObject: [NSNull null]];
    if(actions.count > index &&
       [actions objectAtIndex: index] == [NSNull null])
        [actions replaceObjectAtIndex: index
                 withObject: action];
    else
        [actions insertObject: action
                 atIndex: index];

    return(YES);
}

- (BOOL) endInstanceCreationForEntityMapping: (NSEntityMapping*) mapping
                                     manager: (NSMigrationManager*) manager
                                       error: (NSError**) error
{
    [actions removeObjectIdenticalTo: [NSNull null]
             inRange: NSMakeRange(0, actions.count)];
    DBLog(@"%@: endCreation\n%@", self, actions);

    [Action mergeActions: actions];

    [actions release];
    actions = nil;
    [classmap release];
    classmap = nil;
    [urlmap release];
    urlmap = nil;
    return([super endInstanceCreationForEntityMapping: mapping
                  manager: manager
                  error: error]);
}

@end
