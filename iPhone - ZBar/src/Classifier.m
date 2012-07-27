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

#import "Classifier.h"
#import "Barcode.h"
#import "Classification.h"

#define DEBUG_MODULE Classifier
#import "util.h"

static Classifier *sharedClassifier = nil;


@implementation Classifier

+ (Classifier*) sharedClassifier
{
    if(sharedClassifier)
        return(sharedClassifier);

    ListClassifier *list = [ListClassifier new];
    [list addClassifier: [GTINClassifier classifier]];
    [list addClassifier: [EmailClassifier classifier]];
    [list addClassifier: [URLClassifier classifier]];
    [list addClassifier: [ShippingClassifier classifier]];
    [list addClassifier: [SymbologyClassifier classifier]];

    [list addClassifier: [SymbologyRenameClassifier
                             classifierForSymbology: ZBAR_I25
                             withName: @"Interleaved 2 of 5"]];
    [list addClassifier: [SymbologyRenameClassifier
                             classifierForSymbology: ZBAR_I25
                             withName: @"ITF"]];
    [list addClassifier: [SymbologyRenameClassifier
                             classifierForSymbology: ZBAR_DATABAR_EXP
                             withName: @"DataBar Expanded"]];

    sharedClassifier = list;
    return(sharedClassifier);
}

+ (Classifier*) classifier
{
    return([[self new]
               autorelease]);
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    [NSException raise: NSInvalidArgumentException
                 format: @"sent classifyBarcode to abstract base Classifier"];
    return(nil);
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
{
    Classification *dataClass =
        [Classification classificationWithName: nil
                        forData: barcode.data];
    return([self classifyBarcode: barcode
                 withDataClassification: dataClass]);
}

- (NSArray*) provides
{
    return([NSArray array]);
}

@end


@implementation ListClassifier

- (id) init
{
    if(self = [super init])
        classifiers = [NSMutableArray new];
    return(self);
}

- (void) dealloc
{
    [classifiers release];
    classifiers = nil;
    [super dealloc];
}

- (void) addClassifier: (Classifier*) classifier
{
    [classifiers addObject: classifier];
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    NSMutableDictionary *result = [NSMutableDictionary new];
    [result setObject: dataClass
            forKey: @"data"];
    for(Classifier *classifier in classifiers) {
        NSDictionary *info =
            [classifier classifyBarcode: barcode
                        withDataClassification: dataClass];
        if(info)
            [result addEntriesFromDictionary: info];
    }
    if([result count])
        return([result autorelease]);
    [result release];
    return(nil);
}

@end


@implementation SymbologyClassifier

- (id) init
{
    self = [super init];
    if(!self)
        return(nil);

    codeRegex = [[NSRegularExpression alloc]
                    initWithPattern: @"Code"
                    options: 0
                    error: NULL];

    return(self);
}

- (void) dealloc
{
    [codeRegex release];
    codeRegex = nil;
    [super dealloc];
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    zbar_symbol_type_t type = [barcode.type intValue];
    NSString *name = [ZBarSymbol nameForType: type];
    if(!name)
        return(nil);
    if([codeRegex numberOfMatchesInString: name
                  options: 0
                  range: NSMakeRange(0, name.length)])
        name = [name stringByReplacingOccurrencesOfString: @"-"
                     withString: @" "];
    return([NSDictionary dictionaryWithObject: dataClass
                         forKey: name]);
}

@end


@implementation SymbologyRenameClassifier

- (id) initWithSymbology: (zbar_symbol_type_t) sym
                    name: (NSString*) _name
{
    if(self = [super init]) {
        symbology = sym;
        name = [_name retain];
    }
    return(self);
}

+ (Classifier*) classifierForSymbology: (zbar_symbol_type_t) sym
                              withName: (NSString*) name
{
    return([[[self alloc]
                initWithSymbology: sym
                name: name]
               autorelease]);
}

- (void) dealloc
{
    [name release];
    name = nil;
    [super dealloc];
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    zbar_symbol_type_t type = [barcode.type intValue];
    if(type != symbology)
        return(nil);
    return([NSDictionary dictionaryWithObject: dataClass
                         forKey: name]);
}

@end

static int ean_calc_checksum (const char *raw,
                              int n)
{
    int chk = 0;
    for(int i = 0; i < n - 1; i++) {
        int d = raw[i];
        if(d < '0' || d > '9')
            return(-1);
        d -= '0';
        chk += d;
        if(!((i ^ n) & 1)) {
            chk += d << 1;
            if(chk >= 20)
                chk -= 20;
        }
        if(chk >= 10)
            chk -= 10;
    }
    if(chk)
        chk = 10 - chk;
    assert(chk >= 0 && chk <= 9);
    return(chk);
}

static BOOL ean_verify_checksum (NSString *ean)
{
    int n = ean.length;
    if(n < 8)
        return(NO);

    const char *raw = [ean UTF8String];
    int chk = ean_calc_checksum(raw, n);
    if(chk < 0)
        return(NO);

    return(chk == raw[n - 1] - '0');
}

static NSString *ean_expand_upce (NSString *upce)
{
    if(upce.length != 8)
        return(nil);

    int j = 0;
    const char *raw = [upce UTF8String];
    char decode = raw[6];
    if(decode < '0' || decode > '9' || raw[j++] != '0')
        return(nil);
    char result[15];
    int i = 0;
    result[i++] = '0';
    result[i++] = '0';
    result[i++] = '0';
    result[i++] = raw[j++];
    result[i++] = raw[j++];
    result[i++] = (decode < '3') ? decode : raw[j++];
    result[i++] = (decode < '4') ? '0' : raw[j++];
    result[i++] = (decode < '5') ? '0' : raw[j++];
    result[i++] = '0';
    result[i++] = '0';
    result[i++] = (decode < '3') ? raw[j++] : '0';
    result[i++] = (decode < '4') ? raw[j++] : '0';
    result[i++] = raw[j];
    result[i++] = raw[7];
    result[i] = '\0';
    assert(i == 14);

    return([NSString stringWithUTF8String: result]);
}

@implementation GTINClassifier

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    zbar_symbol_type_t type = [barcode.type intValue];
    NSString *data = barcode.data;

    if(type == ZBAR_EAN13 || type == ZBAR_ISBN13)
        data = [@"0" stringByAppendingString: data];
    else if(type == ZBAR_UPCA)
        data = [@"00" stringByAppendingString: data];
    else if(type == ZBAR_UPCE)
        data = ean_expand_upce(data);
    else if(type == ZBAR_EAN8)
        data = [@"000000" stringByAppendingString: data];
    else if(// FIXME use GS1 modifier and extract all AIs
            (type == ZBAR_CODE128 || type == ZBAR_QRCODE ||
             type == ZBAR_DATABAR || type == ZBAR_DATABAR_EXP) &&
            data.length >= 16 && [data hasPrefix: @"01"])
        data = [data substringWithRange: NSMakeRange(2, 14)];
    else
        return(nil);

    if(!data)
        return(nil);
    if(data.length != 14) {
#ifndef NDEBUG
        NSLog(@"GTIN: length %d != 14\n", data.length);
#endif
        assert(0);
        return(nil);
    }
    if(!ean_verify_checksum(data)) {
#ifndef NDEBUG
        NSLog(@"GTIN: bad checksum\n");
#endif
        assert(0);
        return(nil);
    }

    NSMutableDictionary *result =
        [NSMutableDictionary dictionaryWithCapacity: 4];
    NSString *gtin13 = [data substringFromIndex: 1];

    // classify product code
    NSString *clsName;
    if([gtin13 hasPrefix: @"978"] || [gtin13 hasPrefix: @"979"])
        clsName = @"Book";
    else
        clsName = @"Product";

    [result setObject: [Classification
                           classificationWithName: clsName
                           forData: data]
            forKey: @"GTIN-14"];

    if(![data hasPrefix: @"0"]) {
        int n = gtin13.length;
        int chk = ean_calc_checksum([gtin13 UTF8String], n);
        if(chk < 0 || chk > 9)
            return(nil);
        gtin13 = [gtin13 substringToIndex: n - 1];
        gtin13 = [NSString stringWithFormat: @"%@%d", gtin13, chk];
    }
    [result setObject: [Classification
                           classificationWithName: clsName
                           forData: gtin13]
            forKey: @"GTIN-13"];
    if([gtin13 hasPrefix: @"978"] || [gtin13 hasPrefix: @"979"])
        [result setObject: [Classification
                               classificationWithName: clsName
                               forData: gtin13]
                forKey: @"ISBN-13"];
    if([gtin13 hasPrefix: @"0"]) {
        NSString *gtin12 = [gtin13 substringFromIndex: 1];
        [result setObject: [Classification
                               classificationWithName: clsName
                               forData: gtin12]
                forKey: @"GTIN-12"];
    }
    return(result);
}

@end


static inline BOOL ups1z_verify (NSString *data)
{
    const char *raw = [[data uppercaseString] UTF8String];
    if(!raw || raw[0] != '1' || raw[1] != 'Z')
        return(0);

    int sum = 0;
    for(int i = 2; i < 17; i++) {
        int d = raw[i];
        if(d >= '0' && d <= '9')
            d -= '0';
        else if(d >= 'A' && d <= 'Z')
            d = d - 'A' + 2;
        else
            return(0);
        if(i & 1)
            d *= 2;
        sum += d;
    }
    sum %= 10;
    if(sum)
        sum = 10 - sum;

#ifndef NDEBUG
    if(sum + '0' != raw[17])
        NSLog(@"UPS1Z: bad checksum (%d != %c)\n", sum, raw[17]);
#endif
    return(sum + '0' == raw[17] && !raw[18]);
}

static inline BOOL fedex96_verify (NSString *data)
{
    const char *raw = [data UTF8String];
    if(!raw || raw[0] != '9' || raw[1] != '6' ||      // AI
       raw[2] != '1' || raw[3] < '1' || raw[3] > '3') // SCNC
        return(0);
    int i = 4;
    for(i = 4; i < 7; i++)
        if(raw[i] < '0' || raw[i] > '9')
            return(0);
    int sum = 0;
    for(; i < 21; i++) {
        int d = raw[i];
        if(d < '0' || d > '9')
            return(0);
        d -= '0';
        if(!(i & 1))
            d *= 3;
        sum += d;
    }
    sum %= 10;
    if(sum)
        sum = 10 - sum;

#ifndef NDEBUG
    if(sum + '0' != raw[21])
        NSLog(@"FEDEX96: bad checksum (%d != %c)\n", sum, raw[21]);
#endif
    return(sum + '0' == raw[21] && !raw[22]);
}

static inline BOOL fedex12_verify (NSString *data)
{
    const char *raw = [data UTF8String];
    if(!raw)
        return(0);
    static const char weights[3] = { 3, 1, 7 };
    int sum = 0;
    for(int i = 0; i < 15; i++) {
        int d = raw[i];
        if(d < '0' || d > '9')
            return(0);
        d -= '0';
        d *= weights[i % 3];
        sum += d;
    }
    sum %= 11;
    if(sum == 10)
        sum = 0;

#ifndef NDEBUG
    if(sum + '0' != raw[11])
        NSLog(@"FEDEX12: bad checksum (%d != %c)\n", sum, raw[11]);
#endif
    return(sum + '0' == raw[11] && !raw[12]);
}

@implementation ShippingClassifier

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    zbar_symbol_type_t type = [barcode.type intValue];
    NSString *data = barcode.data;
    int len = data.length;

    if(len == 18 && [data hasPrefix: @"1Z"] && ups1z_verify(data)) {
        Classification *pkgClass =
            [Classification
                classificationWithName: @"UPS Ground Package"
                forData: data];
        return([NSDictionary dictionaryWithObjectsAndKeys:
                   pkgClass, @"UPS Ground Package",
                   pkgClass, @"UPS Package",
                   pkgClass, @"Package",
                   nil]);
    }
    if(len == 22 && [data hasPrefix: @"961"] && fedex96_verify(data)) {
        Classification *pkgClass =
            [Classification
                classificationWithName: @"FedEx Ground Package"
                forData: data];
        return([NSDictionary dictionaryWithObjectsAndKeys:
                   pkgClass, @"FedEx Ground Package",
                   pkgClass, @"FedEx Package",
                   pkgClass, @"Package",
                   nil]);
    }

    if(len == 32 && [data hasPrefix: @"3"]) {
        data = [data substringWithRange: NSMakeRange(16, 12)];
        len = 12;
    }
    if(len == 12 && type == ZBAR_CODE128 || type == ZBAR_CODE39 &&
       fedex12_verify(data))
    {
        Classification *pkgClass =
            [Classification
                classificationWithName: @"FedEx Express Package"
                forData: data];
        return([NSDictionary dictionaryWithObjectsAndKeys:
                   pkgClass, @"FedEx Express Package",
                   pkgClass, @"FedEx Package",
                   pkgClass, @"Package",
                   nil]);
    }

    return(nil);
}

@end


@implementation RegexClassifier

- (id) initWithRegex: (NSString*) _regex
                name: (NSString*) _name
{
    if(self = [super init]) {
        regex = [[NSRegularExpression alloc]
                    initWithPattern: _regex
                    options: NSRegularExpressionCaseInsensitive
                    error: NULL];
        name = [_name retain];
    }
    return(self);
}

- (void) dealloc
{
    [regex release];
    regex = nil;
    [name release];
    name = nil;
    [super dealloc];
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    NSString *data = barcode.data;
    NSTextCheckingResult *match =
        [regex firstMatchInString: data
               options: 0
               range: NSMakeRange(0, data.length)];
    if(!match)
        return(nil);
    NSRange group = match.range;
    if(!group.length)
        return(nil);

    data = [data substringWithRange: group];
    Classification *regexClass =
        [Classification classificationWithName: name
                        forData: data];
    return([NSDictionary dictionaryWithObject: regexClass
                         forKey: name]);
}

@end


static NSString * const Email_regex =
    @"(?:mailto:)?(?:\\s*(\"[^\"]*?\")\\s*[<])?([\\w!#-+./=?^_`_-]+@(?:\\w+.)+\\w+)[>]?";

@implementation EmailClassifier

- (id) init
{
    self = [super initWithRegex: Email_regex
                  name: @"Email"];
    if(!self)
        return(nil);
    assert(regex.numberOfCaptureGroups == 2);
    return(self);
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    NSString *data = barcode.data;
    NSTextCheckingResult *match =
        // FIXME multiple match
        [regex firstMatchInString: data
               options: 0
               range: NSMakeRange(0, data.length)];
    if(!match || match.numberOfRanges < 3)
        return(nil);

    NSRange group = [match rangeAtIndex: 2];
    if(!group.length)
        return(nil);
    NSString *email = [data substringWithRange: group];
    NSMutableDictionary *result =
        [NSMutableDictionary dictionaryWithCapacity: 2];
    [result setObject: [Classification
                           classificationWithName: @"Email"
                           forData: email]
            forKey: @"Email"];

    group = [match rangeAtIndex: 1];
    if(!group.length)
        return(result);

    [result setObject: [Classification
                           classificationWithName: @"Contact"
                           forData: [data substringWithRange: group]]
            forKey: @"Name"];
    return(result);
}

@end


@implementation URLClassifier

- (id) init
{
    return([super initWithRegex: @"[\\w+.-]+://[^ \r\n]+"
                  name: @"URL"]);
}

- (NSDictionary*) classifyBarcode: (Barcode*) barcode
           withDataClassification: (Classification*) dataClass
{
    zbar_symbol_type_t type = [barcode.type intValue];
    if(type != ZBAR_QRCODE &&
       type != ZBAR_CODE128 &&
       type != ZBAR_CODE39 &&
       type != ZBAR_CODE93)
        return(nil);

    NSDictionary *result =
        [super classifyBarcode: barcode
               withDataClassification: dataClass];
    return(result);
}

@end
