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

#import "Scraper.h"
#import "Barcode.h"
#import "Classification.h"

#define DEBUG_MODULE Scraper
#import "util.h"

#import <string.h>
#import <libxml/xmlstring.h>

@implementation Scraper

- (id) initWithBarcode: (Barcode*) _barcode
               request: (NSURLRequest*) request
{
    if(!(self = [super init]))
        return(nil);

    // NB connection retains delegate (self)!
    connection = [[NSURLConnection alloc]
                     initWithRequest: request
                     delegate: self];
    if(!connection) {
        DBLog(@"failed to open connection\n");
        [self release];
        return(nil);
    }

    barcode = [_barcode retain];
    return(self);
}

- (void) dealloc
{
    [connection release];
    connection = nil;
    [barcode release];
    barcode = nil;
    [super dealloc];
}

- (void) abortWithName: (NSString*) name
{
    if(name)
        [barcode updateName: name];
    [connection cancel];
}

- (void) connection: (NSURLConnection*) _conn
   didFailWithError: (NSError*) error
{
    [error logWithMessage:
        [NSString stringWithFormat: @"connection %@ failed", _conn]];
}

@end


#define XML_FREE_AND_NULL(p) if((p)) { xmlFree((p)); (p) = NULL; }

@implementation XMLScraper

- (id) initWithBarcode: (Barcode*) _barcode
               request: (NSURLRequest*) request
               handler: (xmlSAXHandler*) handler
           forMimeType: (NSString*) mime
{
    if(!(self = [super initWithBarcode: _barcode
                       request: request]))
        return(nil);

    const char *file = [[[request URL] absoluteString] UTF8String];
    if([mime isEqual: @"text/html"])
        parser = htmlCreatePushParserCtxt(handler, self, NULL, 0, file, 0);
    else
        parser = xmlCreatePushParserCtxt(handler, self, NULL, 0, file);

    if(!parser) {
        DBLog(@"failed to create parser\n");
        [self release];
        return(nil);
    }

    xmlCtxtUseOptions(parser, XML_PARSE_RECOVER | XML_PARSE_NOENT |
                      XML_PARSE_NOWARNING | XML_PARSE_NOBLANKS |
                      XML_PARSE_NONET | XML_PARSE_NOCDATA);
    return(self);
}

- (void) dealloc
{
    xmlFreeParserCtxt(parser);
    parser = NULL;
    [super dealloc];
}

- (void) abortWithName: (NSString*) name
{
    xmlStopParser(parser);
    [super abortWithName: name];
}

- (void) connection: (NSURLConnection*) _conn
     didReceiveData: (NSData*) data
{
    if(xmlParseChunk(parser, [data bytes], [data length], 0))
        [self abortWithName: @""];
}

- (void) connectionDidFinishLoading: (NSURLConnection*) _conn
{
    // flush parser
    xmlParseChunk(parser, NULL, 0, 1);
}

@end


enum {
    HTML_STATE_INIT = 0,
    HTML_STATE_HEAD,
    HTML_STATE_TITLE,
};

static void HTMLTitle_startElement (HTMLTitleScraper *scraper,
                                    const xmlChar *name,
                                    const xmlChar **attrs)
{
    switch(scraper->state) {
    case HTML_STATE_INIT:
        if(!xmlStrcasecmp(name, (xmlChar*)"head")) {
            scraper->state = HTML_STATE_HEAD;
            XML_FREE_AND_NULL(scraper->title);
        }
        break;

    case HTML_STATE_HEAD:
        if(xmlStrcasecmp(name, (xmlChar*)"title"))
            break;
        XML_FREE_AND_NULL(scraper->title);

    default:
        scraper->state++;
        break;
    }
}

static void HTMLTitle_endElement (HTMLTitleScraper *scraper,
                                  const xmlChar *name)
{
    switch(scraper->state) {
    case HTML_STATE_INIT:
        break;

    case HTML_STATE_HEAD:
        if(!xmlStrcasecmp(name, (xmlChar*)"head")) {
            scraper->state = HTML_STATE_INIT;
            [scraper abortWithName: @""];
        }
        break;

    case HTML_STATE_TITLE:
        if(xmlStrcasecmp(name, (xmlChar*)"title"))
            break;
        if(scraper->title) {
            NSString *title = [NSString stringWithUTF8String:
                                            (char*)scraper->title];
            DBLog(@"found web page title=%@\n", title);
            [scraper abortWithName: title];
        }

    default:
        scraper->state--;
    }
}

static void HTMLTitle_characters (HTMLTitleScraper *scraper,
                                  const xmlChar *chars,
                                  int len)
{
    if(scraper->state >= HTML_STATE_TITLE)
        scraper->title = xmlStrncat(scraper->title, chars, len);
}

static const xmlSAXHandler HTMLTitleHandler = {
    .startElement = (startElementSAXFunc)HTMLTitle_startElement,
    .endElement = (endElementSAXFunc)HTMLTitle_endElement,
    .characters = (charactersSAXFunc)HTMLTitle_characters,
};

@implementation HTMLTitleScraper

- (id) initWithBarcode: (Barcode*) _barcode
{
    Classification *cls =
        [_barcode.classification objectForKey: @"URL"];
    NSString *urlstr = cls.data;
    if(!urlstr)
        goto error;
    NSURL *url = [NSURL URLWithString: urlstr];
    if(!url)
        goto error;
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL: url];
    if(!req)
        goto error;

    return([super initWithBarcode: _barcode
                  request: req
                  handler: (void*)&HTMLTitleHandler
                  forMimeType: @"text/html"]);

error:
    DBLog(@"Failed to create request\n");
    [self release];
    return(nil);
}

- (void) dealloc
{
    XML_FREE_AND_NULL(title);
    [super dealloc];
}

@end
