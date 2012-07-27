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

@class StringTemplate;

typedef enum {
    ActionOpenModeDefault = 0,
    ActionOpenModeExternal,
    ActionOpenModeInternal,
} ActionOpenMode;

/* An Action that can be performed on a Barcode.
 * unclassified actions are templates that
 * generate specific actions when classified
 */
@interface Action
    : NSObject
{
    NSString *name;
    StringTemplate *template;
    BOOL classified;
    ActionOpenMode openMode;
}

+ (void) mergeActions: (NSArray*) actions;
+ (NSMutableArray*) allActions;
+ (void) saveActions;
+ (NSString*) type;

- (id) initWithPropertyList: (NSDictionary*) plist;
- (NSDictionary*) encodeAsPropertyList;
- (Action*) match: (NSDictionary*) classification;

- (BOOL) activateWithNavigationController: (UINavigationController*) nav
                                 animated: (BOOL) animated;

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *template;
@property (nonatomic, readonly) NSString *detailText;
@property (nonatomic) ActionOpenMode openMode;
@property (nonatomic, readonly) BOOL canEdit;
@property (nonatomic, readonly) BOOL canAutoLink;

@end


/* An Action that links to a URL
 */
@interface LinkAction
    : Action
{
    NSURL *url;
}

@property (nonatomic, readonly) NSURL *url;

@end


/* An Action that composes an E-mail message
 */
@interface EmailAction
    : Action
{
    NSString *to;
}
@end


/* FIXME other actions:
 *   ExportContactAction
 *   FieldAction
 *     ExpiresAction
 */
