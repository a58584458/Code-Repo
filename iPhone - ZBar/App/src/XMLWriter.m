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
#import "XMLWriter.h"
#import "XMLAllocator.h"

@implementation XMLWriter

@dynamic buffer;

- (id) init
{
    self = [super init];
    if(!self)
        return(nil);

    buffer = xmlBufferCreate();
    if(!buffer)
        goto error;

    writer = xmlNewTextWriterMemory(buffer, 0);
    if(!writer)
        goto error;

    return(self);

error:
    NSLog(@"[XMLWriter init] failed to create writer");
    [self release];
    return(nil);
}

- (void) cleanup
{
    if(writer) {
        xmlFreeTextWriter(writer);
        writer = NULL;
    }
    if(buffer) {
        xmlBufferFree(buffer);
        buffer = NULL;
    }
}

- (void) dealloc
{
    [self cleanup];
    [content release];
    content = nil;
    [super dealloc];
}

- (void) startDocument
{
    xmlTextWriterStartDocument(writer, NULL, "UTF-8", NULL);
}

- (void) endDocument
{
    xmlTextWriterEndDocument(writer);

    // finalize buffer contents and pass data to CFString
    content = (NSString*)
        CFStringCreateWithBytesNoCopy(
            NULL, xmlBufferContent(buffer), xmlBufferLength(buffer),
            kCFStringEncodingUTF8, NO, XMLAllocatorGet()
        );
    buffer->content = NULL;
    assert(content);
}

- (void) startElement: (NSString*) tag
{
    xmlTextWriterStartElement(writer, BAD_CAST [tag UTF8String]);
}

- (void) writeAttribute: (NSString*) attr
              withValue: (NSString*) val
{
    xmlTextWriterWriteAttribute(writer, BAD_CAST [attr UTF8String],
                                BAD_CAST [val UTF8String]);
}

- (void) endElement
{
    xmlTextWriterFullEndElement(writer);
}

- (void) writeEmptyElement: (NSString*) tag
{
    xmlTextWriterStartElement(writer, BAD_CAST [tag UTF8String]);
    xmlTextWriterFullEndElement(writer);
}

- (void) writeElement: (NSString*) tag
          withContent: (NSString*) text
{
    if(!text || !text.length)
        [self writeEmptyElement: tag];
    else
        xmlTextWriterWriteElement(writer, BAD_CAST [tag UTF8String],
                                  BAD_CAST [text UTF8String]);
}

- (void) writeText: (NSString*) text
{
    xmlTextWriterWriteString(writer, BAD_CAST [text UTF8String]);
}

- (NSString*) buffer
{
    return(content);
}

@end
