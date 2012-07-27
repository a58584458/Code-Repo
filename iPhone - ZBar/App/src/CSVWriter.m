//------------------------------------------------------------------------
//  Copyright 2010 (c) Jeff Brown <spadix@users.sourceforge.net>
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

#import <assert.h>
#import "CSVWriter.h"

@implementation CSVWriter

@dynamic charset, headerColumns, MIMEType, data;

- (id) initWithColumnCount: (NSUInteger) count
{
    self = [super init];
    if(!self)
        return(nil);
    ncols = count;
    charset = [@"utf-8" retain];
    encoding = NSUTF8StringEncoding;
    rows = [[NSMutableArray alloc]
               initWithCapacity: 16];
    return(self);
}

- (id) init
{
    return([self initWithColumnCount: 0]);
}

- (void) dealloc
{
    [rows release];
    rows = nil;
    [headerColumns release];
    headerColumns = nil;
    [charset release];
    charset = nil;
    [data release];
    data = nil;
    [super dealloc];
}

- (NSString*) CSVForRowWithColumns: (NSArray*) cols
{
    if(ncols)
        assert(ncols >= cols.count);
    else
        ncols = cols.count;

    NSMutableArray *quoted =
        [[NSMutableArray alloc] initWithCapacity: ncols];
    for(NSString *field in cols) {
        NSString *q = nil;
        if(field && field.length)
            q = [[NSString alloc]
                    initWithFormat: @"\"%@\"",
                    [field stringByReplacingOccurrencesOfString: @"\""
                           withString: @"\"\""]];
        [quoted addObject: (q) ? q : @""];
        [q release];
    }
    while(quoted.count < ncols)
        [quoted addObject: @""];

    NSString *csv = [quoted componentsJoinedByString: @","];
    [quoted release];
    return(csv);
}

- (NSArray*) headerColumns
{
    return(headerColumns);
}

- (void) setHeaderColumns: (NSArray*) cols
{
    NSString *header = [self CSVForRowWithColumns: cols];
    if(!headerColumns)
        [rows insertObject: header
              atIndex: 0];
    else
        [rows replaceObjectAtIndex: 0
              withObject: header];

    NSArray *old = headerColumns;
    headerColumns = [cols retain];
    [old release];

    [data release];
    data = nil;
}

- (NSString*) charset
{
    return(charset);
}

- (void) setCharset: (NSString*) cset
{
    CFStringEncoding cfenc =
        CFStringConvertIANACharSetNameToEncoding((CFStringRef)cset);
    if(cfenc == kCFStringEncodingInvalidId)
        [NSException raise: NSInvalidArgumentException
            format: @"unknown encoding: %@", cset];

    NSString *old = charset;
    charset = [cset retain];
    [old release];
    encoding = CFStringConvertEncodingToNSStringEncoding(cfenc);
    assert(encoding);
}

- (void) writeRowWithColumns: (NSArray*) cols
{
    [rows addObject: [self CSVForRowWithColumns: cols]];
    [data release];
    data = nil;
}

- (NSString*) MIMEType
{
    NSString *mime =
        [NSString stringWithFormat: @"text/csv; header=%s",
            (headerColumns) ? "present" : "absent"];
    if(charset && charset.length)
        mime = [mime stringByAppendingFormat: @"; charset=%@", charset];
    return(mime);
}

- (NSData*) data
{
    if(data)
        return(data);

    NSString *content =
        [rows componentsJoinedByString: @"\x0d\x0a"];
    data = [[content dataUsingEncoding: encoding]
               retain];
    return(data);
}

@end
