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

@class Barcode, Classification;


@interface Classifier : NSObject

+ (Classifier*) sharedClassifier;
+ (Classifier*) classifier;
- (NSDictionary*) classifyBarcode: (Barcode*) barcode;

@end


@interface ListClassifier : Classifier
{
    NSMutableArray *classifiers;
}

- (void) addClassifier: (Classifier*) classifier;

@end


@interface SymbologyClassifier : Classifier
{
    NSRegularExpression *codeRegex;
}
@end


@interface SymbologyRenameClassifier : Classifier
{
    NSString *name;
    zbar_symbol_type_t symbology;
}

+ (Classifier*) classifierForSymbology: (zbar_symbol_type_t) symbology
                              withName: (NSString*) name;

@end


@interface GTINClassifier : Classifier
@end


@interface ShippingClassifier : Classifier
@end


@interface RegexClassifier : Classifier
{
    NSRegularExpression *regex;
    NSString *name;
}

- (id) initWithRegex: (NSString*) regex
                name: (NSString*) name;

@end


@interface EmailClassifier : RegexClassifier
@end


@interface URLClassifier : RegexClassifier
@end
