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

#import "Classification.h"

@implementation Classification

@synthesize name, data;

+ (Classification*) classificationWithName: (NSString*) name
                                   forData: (NSString*) data
{
    return([[[Classification alloc]
                initWithName: name
                forData: data]
               autorelease]);
}

- (id) initWithName: (NSString*) _name
            forData: (NSString*) _data
{
    self = [super init];
    if(!self)
        return(nil);

    name = [_name retain];
    data = [_data retain];

    return(self);
}

- (void) dealloc
{
    [name release];
    name = nil;
    [data release];
    data = nil;
    [super dealloc];
}

- (NSString*) description
{
    return(data);
}

@end
