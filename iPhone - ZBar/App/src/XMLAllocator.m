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
#import "XMLAllocator.h"

static CFAllocatorRef XMLAllocator_sharedInstance;

static void *
xml_alloc (CFIndex size,
           CFOptionFlags hint,
           void *info)
{
    assert(size > 0);
    if(size <= 0)
        return(NULL);
    return(xmlMalloc(size));
}

static void *
xml_realloc (void *ptr,
             CFIndex newsize,
             CFOptionFlags hint,
             void *info)
{
    assert(ptr);
    assert(newsize > 0);
    if(!ptr || newsize <= 0)
        return(NULL);
    return(xmlRealloc(ptr, newsize));
}

static void
xml_free (void *ptr,
          void *info)
{
    assert(ptr);
    if(!ptr)
        return;
    xmlFree(ptr);
}

CFAllocatorRef
XMLAllocatorCreate (CFAllocatorRef allocalloc)
{
    static CFAllocatorContext ctx = {
        .allocate = xml_alloc,
        .reallocate = xml_realloc,
        .deallocate = xml_free,
    };
    return(CFAllocatorCreate(allocalloc, &ctx));
}

CFAllocatorRef
XMLAllocatorGet ()
{
    CFAllocatorRef alloc = XMLAllocator_sharedInstance;
    if(!alloc)
        XMLAllocator_sharedInstance = alloc = XMLAllocatorCreate(NULL);
    return(alloc);
}
