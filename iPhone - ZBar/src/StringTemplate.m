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

#import "StringTemplate.h"

@implementation StringTemplate

- (void) initComponentsWithTemplate: (NSString*) template
{
    NSMutableArray *comps =
        [[NSMutableArray alloc]
            initWithCapacity: 1];
    components = comps;

    if(!template)
        return;

    // parse URL into template and replacement components
    NSInteger n = template.length;
    NSRange search = NSMakeRange(0, n);
    while(search.location < n) {
        NSRange start = [template rangeOfString: @"{"
                                  options: 0
                                  range: search];
        if(!start.length)
            break;
        NSRange tmpl =
            NSMakeRange(search.location, start.location - search.location);

        NSRange repl = NSMakeRange(start.location + start.length, n);
        repl.length -= repl.location;
        NSRange end = [template rangeOfString: @"}"
                                options: 0
                                range: repl];
        if(!end.length)
            break;
        repl.length = end.location - repl.location;

        [comps addObject: [template substringWithRange: tmpl]];
        [comps addObject: [template substringWithRange: repl]];

        search.location = end.location + end.length;
        search.length = n - search.location;
    }

    NSString *tail = [template substringFromIndex: search.location];
    [comps addObject: tail];
}

- (void) dealloc
{
    [components release];
    components = nil;
    [keys release];
    keys = nil;
    [super dealloc];
}

- (id) initWithTemplate: (NSString*) template
{
    self = [super init];
    if(!self)
        return(nil);
    [self initComponentsWithTemplate: template];
    return(self);
}

- (NSArray*) allKeys
{
    if(keys)
        return(keys);

    NSMutableArray *ks =
        [[NSMutableArray alloc]
            initWithCapacity: components.count / 2];
    keys = ks;

    NSInteger i = -1;
    for(NSString *k in components)
        if(++i & 1)
            [ks addObject: k];

    return(keys);
}

- (NSString*) valueForMapping: (NSDictionary*) map
{
    NSInteger n = components.count;
    if(!n)
        return(nil);

    NSMutableArray *comps = [NSMutableArray arrayWithCapacity: n];
    NSInteger i = -1;
    for(NSString *c in components) {
        if(++i & 1) {
            c = [[map objectForKey: c]
                    description];
            if(!c)
                return(nil);
        }
        [comps addObject: c];
    }
    return([comps componentsJoinedByString: @""]);
}

- (NSString*) description
{
    NSMutableArray *comps =
        [NSMutableArray arrayWithCapacity: components.count];
    NSInteger i = -1;
    for(NSString *c in components) {
        if(++i & 1)
            c = [NSString stringWithFormat: @"{%@}", c];
        [comps addObject: c];
    }
    return([comps componentsJoinedByString: @""]);
}

@end
