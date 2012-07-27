//------------------------------------------------------------------------
//  Copyright 2010-2011 (c) Jeff Brown <spadix@users.sourceforge.net>
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
#import "Barcode.h"
#import "Action.h"
#import "Classification.h"
#import "Classifier.h"
#import "XMLWriter.h"
#import "CSVWriter.h"
#import "BarcodeEmail.h"

#define DEBUG_MODULE BarcodeEmail
#import "util.h"

/* CSV: date, timezone, symbology, data, classification, name */
#define FIXED_COLUMNS 6

@implementation BarcodeEmail

@synthesize enableCSV;

- (void) startHTML: (NSString*) intro
{
    [html startDocument];
    [html startElement: @"html"];
    [html startElement: @"body"];

    [html startElement: @"p"];
    [html writeText: intro];
    [html writeText: @" I scanned with "];
    [html startElement: @"a"];
    [html writeAttribute: @"href"
          withValue: @"http://zbar.sourceforge.net/iphone"];
    [html writeText: @"ZBar"];
    [html endElement /* a */];
    [html writeText: @" on my iPhone."];
    [html endElement /* p */];
}

- (void) endHTML
{
    [html writeEmptyElement: @"hr"];
    [html endDocument];
}

- (id) initWithIntro: (NSString*) intro
{
    self = [super init];
    if(!self)
        return(nil);

    htmlDate = [NSDateFormatter new];
    csvDate = [NSDateFormatter new];
    csvTZ = [NSDateFormatter new];

    html = [XMLWriter new];
    csv = [[CSVWriter alloc]
              initWithColumnCount: FIXED_COLUMNS + [Action allActions].count];
    enableCSV = YES;

    if(!htmlDate || !csvDate || !csvTZ || !html || !csv) {
        [self release];
        return(nil);
    }

    [htmlDate setDateStyle: NSDateFormatterLongStyle];
    [htmlDate setTimeStyle: NSDateFormatterShortStyle];
    [csvDate setDateFormat: @"yyyy'/'MM'/'dd' 'HH':'mm':'ss"];
    [csvTZ setDateFormat: @"Z"];

    [self startHTML: intro];

    csv.headerColumns =
        [NSArray arrayWithObjects:
            @"Date", @"Time Zone", @"Symbology", @"Data", @"Classification",
            @"Description", @"Links", nil];

    return(self);
}

- (void) cleanup
{
    [htmlDate release];
    htmlDate = nil;
    [csvDate release];
    csvDate = nil;
    [csvTZ release];
    csvTZ = nil;
    [html release];
    html = nil;
    [csv release];
    csv = nil;
}

- (void) dealloc
{
    [self cleanup];
    [super dealloc];
}

- (void) addAction: (Action*) action
         toColumns: (NSMutableArray*) cols
{
    if([action isKindOfClass: [LinkAction class]]) {
        LinkAction *link = (id)action;
        // FIXME escapes?
        NSString *url = [link.url absoluteString];
        [html startElement: @"li"];
        [html startElement: @"a"];
        [html writeAttribute: @"href"
              withValue: url];
        [html writeText: action.name];
        [html endElement /* a */];
        [html endElement /* li */];

        NSString *delimeter = [Settings globalSettings].csvDelimeter;
        [cols addObject:
            [NSString stringWithFormat:
                @"=HYPERLINK(\"%@\"%@\"%@\")", url, delimeter, action.name]];
    }
}

- (void) addBarcode: (Barcode*) barcode
{
    NSAutoreleasePool *pool =
        [NSAutoreleasePool new];
    NSMutableArray *cols =
        [NSMutableArray arrayWithCapacity:
            FIXED_COLUMNS + [Action allActions].count];

    [html writeEmptyElement: @"hr"];
    [html startElement: @"p"];
    [html writeAttribute: @"style"
          withValue: @"padding: .25em"];

    NSString *name = barcode.name;
    if(name && name.length) {
        [html writeText: name];
        [html writeEmptyElement: @"br"];
    }

    NSString *sym = [ZBarSymbol nameForType: [barcode.type intValue]];
    NSString *data = barcode.data;
    [html writeText: sym];
    [html writeText: @": "];
    [html writeText: data];

    NSDate *date = barcode.date;
    [cols addObject: [csvDate stringForObjectValue: date]];
    [cols addObject: [csvTZ stringForObjectValue: date]];

    [cols addObject: sym];
    [cols addObject: data];

    NSString *classes = barcode.classificationText;
    [cols addObject: classes];
    [cols addObject: (name) ? name : @""];

    [html writeEmptyElement: @"br"];

    [html startElement: @"span"];
    [html writeAttribute: @"style"
          withValue: @"font-size: small"];
    [html writeText: @"scanned on: "];
    [html writeText: [htmlDate stringForObjectValue: date]];
    [html endElement /* span */]; 

    if(![classes isEqualToString: @"Unknown"]) {
        [html writeEmptyElement: @"br"];
        [html writeText: @"Found "];
        [html writeText: classes];
    }
    [html endElement /* p */];

    [html startElement: @"ul"];

    NSArray *actions = [barcode applyActions];
    for(Action *action in actions)
        [self addAction: action
              toColumns: cols];

    [html endElement /* ul */];

    if(enableCSV)
        [csv writeRowWithColumns: cols];
    [pool release];
}

- (MFMailComposeViewController*) mailerWithSubject: (NSString*) subject
{
    [self endHTML];

    MFMailComposeViewController *mailer =
        [[MFMailComposeViewController new]
            autorelease];
    mailer.mailComposeDelegate = [MailerCompletionHandler new];
    [mailer setSubject: subject];

    [mailer setMessageBody: html.buffer
            isHTML: YES];

    if(enableCSV)
        [mailer addAttachmentData: csv.data
                mimeType: @"application/octet-stream" // NB text/csv broken!!
                fileName: @"barcodes.csv"];

    [self cleanup];
    return(mailer);
}

@end
