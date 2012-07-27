//------------------------------------------------------------------------
//  Copyright 2011 (c) Lisa Huang <lisah000@users.sourceforge.net>
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

#import "Settings.h"

static Settings *globalSettings;

@implementation Settings

@synthesize enableBeep, enableBrowser, autoLink, enableScraping,
    enabledSymbologies, csvDelimeter;

static NSString *symbolAsString (zbar_symbol_type_t sym)
{
    return([NSString stringWithFormat: @"%d", sym]);
}

+ (Settings*) globalSettings
{
    if(!globalSettings) {
        globalSettings = [Settings new];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary* settings = [defaults objectForKey: @"Settings"];
        [globalSettings updateWithPropertyList: settings];
    }
    return(globalSettings);
}

- (id) init
{
    self = [super init];
    if(!self) {
        return nil;
    }

    // set some default settings
    enableBeep = YES;
    enableBrowser = YES;
    autoLink = YES;
    enableScraping = YES;
    csvDelimeter = [@"," retain];

    NSNumber *yes = [NSNumber numberWithBool: YES];

    enabledSymbologies = [[NSMutableDictionary alloc]
                             initWithObjectsAndKeys:
                                 yes, symbolAsString(ZBAR_EAN13),
                                 yes, symbolAsString(ZBAR_QRCODE),
                                 yes, symbolAsString(ZBAR_CODE128),
                                 yes, symbolAsString(ZBAR_CODE39),
                                 nil];

    return(self);
}

- (void) dealloc
{
    [enabledSymbologies release];
    enabledSymbologies = nil;
    [csvDelimeter release];
    csvDelimeter = nil;
    [super dealloc];
}

- (void) updateWithPropertyList: (NSObject*) plist
{
    NSString* path =
        [[NSBundle mainBundle]
            pathForResource:@"settings"
            ofType:@"plist"];
    NSDictionary* schema =
        [NSDictionary dictionaryWithContentsOfFile: path];

    NSArray* sschema = [schema objectForKey: @"sections"];
    for(NSDictionary* sec in sschema) {
        NSArray *cschema;
        cschema = [sec objectForKey: @"cells"];

        for(NSDictionary* cell in cschema) {
            NSString *keyPath = [cell objectForKey: @"keyPath"];
            NSObject *object = [plist valueForKeyPath: keyPath];
            NSString *typeStr = [cell objectForKey: @"valueType"];

            if(typeStr) {
                Class typeClass = NSClassFromString(typeStr);
                if(typeClass && ![object isKindOfClass: typeClass]) {
                    object = nil;
                }
            }

            if(!object) {
                object = [cell objectForKey: @"defaultValue"];
            }

            if(object) {
                [self setValue: object forKey: keyPath];
            }
        }
    }

    path = [[NSBundle mainBundle]
               pathForResource:@"symbologies"
               ofType:@"plist"];
    schema = [NSDictionary dictionaryWithContentsOfFile: path];
    sschema = [schema objectForKey: @"sections"];

    NSMutableDictionary *tmp = [NSMutableDictionary new];

    for(NSDictionary* sec in sschema) {
        NSArray *cschema;
        cschema = [sec objectForKey: @"cells"];

        for(NSDictionary* cell in cschema) {
            NSString *keyPath = [cell objectForKey: @"keyPath"];
            NSObject *object = [enabledSymbologies valueForKeyPath: keyPath];
            NSString *typeStr = [cell objectForKey: @"valueType"];

            if(typeStr) {
                Class typeClass = NSClassFromString(typeStr);
                if(typeClass && ![object isKindOfClass: typeClass]) {
                    object = nil;
                }
            }

            if(!object) {
                object = [cell objectForKey: @"defaultValue"];
            }

            if(object) {
                [tmp setValue: object forKey: keyPath];
            }
        }
    }

    [enabledSymbologies release];
    enabledSymbologies = tmp;
}

- (NSObject *) encodeAsPropertyList
{
    NSString* path =
        [[NSBundle mainBundle]
            pathForResource:@"settings"
            ofType:@"plist"];
    NSDictionary* schema =
        [NSDictionary dictionaryWithContentsOfFile: path];

    self = [super init];
    if(!self)
        return(nil);

    NSArray* sschema = [schema objectForKey: @"sections"];
    NSMutableDictionary *settings = [NSMutableDictionary dictionary];

    for(NSDictionary* sec in sschema) {
        NSArray *cschema;
        cschema = [sec objectForKey: @"cells"];

        for(NSDictionary* cell in cschema) {
            NSString *keyPath = [cell objectForKey: @"keyPath"];
            NSObject *object = [self valueForKeyPath: keyPath];
            if(object)
                [settings setValue: object
                          forKey: keyPath];
        }
    }

    return(settings);
}

- (void) setValue: (id)value
  forUndefinedKey: (NSString*) key
{
    // ignore stale settings
}

@end

