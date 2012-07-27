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

#import "Barcode.h"
#import "Classifier.h"
#import "Classification.h"
#import "Action.h"
#import "Scraper.h"
#import "Settings.h"

#define DEBUG_MODULE Barcode
#import "util.h"

@interface Barcode (PrimitiveAccessors)
- (void) setPrimitiveName: (NSString*) name;
@end


@implementation Barcode

@dynamic date, type, data, name, thumb, thumbImage, primitiveThumb, folder,
    classificationText;
@synthesize image, classification, symbol;

- (void) dealloc
{
    self.image = nil;
    [classification release];
    classification = nil;
    [classificationText release];
    classificationText = nil;
    [super dealloc];
}

- (UIImage*) thumb
{
    [self willAccessValueForKey: @"thumb"];
    UIImage *thumb = [self primitiveThumb];
    [self didAccessValueForKey: @"thumb"];
    if(!thumb) {
        NSData *data = [self thumbImage];
        if(data) {
            thumb = [[[UIImage alloc] initWithData: data] autorelease];
            [self setPrimitiveThumb: thumb];
        }
    }
    return(thumb);
}

- (void) setThumb: (UIImage*) img
{
    [self willChangeValueForKey: @"thumb"];
    [self setPrimitiveThumb: img];
    [self didChangeValueForKey: @"thumb"];
    [self setThumbImage: nil];
}

- (void) setName: (NSString*) name
{
    [self willChangeValueForKey: @"name"];
    [self setPrimitiveName: name];
    [self didChangeValueForKey: @"name"];

    // add name to classification results
    if(classification && name && name.length)
        [classification
            setObject: [Classification classificationWithName: nil
                                       forData: name]
            forKey: @"Name"];
}

- (NSString*) title
{
    NSString *name = self.name;
    if(name && name.length)
        return(name);
    return(self.data);
}

- (void) willSave
{
    NSData *data = [self primitiveValueForKey: @"thumbImage"];
    if(!data) {
        UIImage *thumb = [self primitiveValueForKey: @"thumb"];
        if(thumb)
            data = UIImagePNGRepresentation(thumb);
        [self setPrimitiveValue: data forKey: @"thumbImage"];
    }
    [super willSave];
}

- (void) classify
{
    // FIXME perform classification asynchronously
    [classification release];
    classification =
        (id)[[Classifier sharedClassifier]
                classifyBarcode: self];
    if([classification isKindOfClass: [NSMutableDictionary class]])
        [classification retain];
    else
        classification = [classification mutableCopy];

    NSString *name = self.name;
    if(name && name.length)
        [classification
            setObject: [Classification classificationWithName: nil
                                       forData: name]
            forKey: @"Name"];

    [classificationText release];
    classificationText = nil;
    DBLog(@"classification=%@ name=%@\n", classification, name);

    if(name && name.length)
        return;

    name = [classification objectForKey: @"Name"];
    if(name && name.length)
        // propagate name extracted from barcode
        self.name = name;
}

- (NSArray*) applyActions: (NSArray*) allActions
{
    NSMutableArray *actions =
        [NSMutableArray arrayWithCapacity: allActions.count];
    NSDictionary *cls = self.classification;

    for(Action *action in allActions) {
        Action *a = [action match: cls];
        if(a)
            [actions addObject: a];
    }

    DBLog(@"actions=%@", actions);
    return(actions);
}

- (NSArray*) applyActions
{
    return([self applyActions: [Action allActions]]);
}

- (NSDictionary*) classification
{
    if(!classification) {
        [self classify];
        assert(classification);
    }

    if(!scraped && !self.name && [Settings globalSettings].enableScraping)
        // FIXME scrape from separate thread
        [self performSelector: @selector(scrapeName)
              withObject: nil
              afterDelay: .25];
    return(classification);
}

- (NSString*) classificationText
{
    if(classificationText)
        return(classificationText);

    NSDictionary *info = self.classification;
    if(info && info.count) {
        NSMutableSet *classes = [NSMutableSet setWithCapacity: info.count];
        for(NSString *key in info) {
            Classification *cls = [info objectForKey: key];
            NSString *name = cls.name;
            if(name)
                [classes addObject: name];
        }
        if(classes.count)
            classificationText =
                [[[[classes allObjects]
                      sortedArrayUsingSelector:
                          @selector(caseInsensitiveCompare:)]
                     componentsJoinedByString: @", "]
                    retain];
    }
    if(!classificationText)
        classificationText = [@"Unknown" retain];
    return(classificationText);
}

- (void) scrapeName
{
    if(scraped)
        return;
    scraped = YES;
    NSDictionary *info = self.classification;

    // initiate web page / product name request
    if([info objectForKey: @"URL"])
        [[[HTMLTitleScraper alloc]
             initWithBarcode: self]
            autorelease];
}

- (void) updateName: (NSString*) name
{
    if(!name)
        // no new name to set, whatever we have must be at least as good
        return;

    if(self.name && !name.length)
        // empty new name, only set if we don't already have a name
        return;

    self.name = name;
}

@end
