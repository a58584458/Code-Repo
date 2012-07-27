//------------------------------------------------------------------------
//  Copyright 2011 (c) Lisa Huang <lisah000@users.sourceforge.net>
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

@interface Settings: NSObject
{
    BOOL enableBeep;
    BOOL enableBrowser;
    BOOL autoLink;
    BOOL enableScraping;
    NSDictionary *enabledSymbologies;
    NSString *csvDelimeter;
}

+ (Settings*) globalSettings;
- (void) updateWithPropertyList: (NSObject*) plist;
- (NSObject *) encodeAsPropertyList;

@property (nonatomic) BOOL enableBeep;
@property (nonatomic) BOOL enableBrowser;
@property (nonatomic) BOOL autoLink;
@property (nonatomic) BOOL enableScraping;
@property (nonatomic, retain) NSDictionary *enabledSymbologies;
@property (nonatomic, retain) NSString *csvDelimeter;

@end



