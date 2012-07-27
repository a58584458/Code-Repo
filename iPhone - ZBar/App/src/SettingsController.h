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

@class SettingsController;

@interface SettingsController : UITableViewController
{
    id delegate;
    void (^completion)(SettingsController*, BOOL);

    NSObject *object;
    NSDictionary *schema;
    NSMutableArray *sections;
    UIBarButtonItem *save;
    BOOL autoDismiss;
}

- (id) initWithObject: (NSObject*) object
               schema: (NSDictionary*) schema;
- (id) initWithObject: (NSObject*) object
           schemaName: (NSString*) name;

- (void) save: (id) sender;

@property (nonatomic, assign) id delegate;
@property (nonatomic, copy) void (^completion)(SettingsController*, BOOL);
@property (nonatomic, readonly) NSObject *object;
@property (nonatomic) BOOL autoDismiss;

@end


