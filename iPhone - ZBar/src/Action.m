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

#import "Action.h"
#import "Settings.h"
#import "WebViewController.h"
#import "StringTemplate.h"

#define DEBUG_MODULE Action
#import "util.h"

static NSMutableArray *allActions = nil;

@implementation Action
@synthesize name, openMode;

+ (NSString*) type
{
    NSString* name = NSStringFromClass([self class]);
    if(![name hasSuffix: @"Action"])
        return(name);
    return([name substringToIndex: name.length - 6]);
}

- (id) initWithPropertyList: (NSDictionary*) plist
{
    self = [super init];
    if(!self)
        return(nil);

    for(NSString *key in plist) {
        NSObject *val = [plist objectForKey: key];
        if([key isEqualToString: @"type"]) {
            assert([val isKindOfClass: [NSString class]]);
            assert([(NSString*)val isEqualToString:
                       NSStringFromClass([self class])]);
        }
        else
            [self setValue: val
                  forKey: key];
    }

    if(!template)
        self.template = nil;

    return(self);
}

- (void) dealloc
{
    [name release];
    name = nil;
    [template release];
    template = nil;
    [super dealloc];
}

- (id) copyWithZone: (NSZone*) zone
{
    assert(!classified);
    Action *copy =
        [[self class]
            allocWithZone: zone];
    copy.name = name;
    copy.template = [template description];
    copy->classified = classified;
    copy->openMode = openMode;
    return(copy);
}

- (void) setValue: (id)value
  forUndefinedKey: (NSString*) key
{
    // ignore stale settings
}

- (NSString*) description
{
    return([NSString stringWithFormat: @"<%@; name=%@; mode=%@; template=%@>",
               NSStringFromClass([self class]), name, openMode, template]);
}

- (NSString*) detailText
{
    return(nil);
}

- (BOOL) canEdit
{
    return(NO);
}

- (BOOL) canAutoLink
{
    return(NO);
}

- (NSString*) template
{
    return([template description]);
}

- (void) setTemplate: (NSString*) tmpl
{
    [template release];
    template = [[StringTemplate alloc]
                   initWithTemplate: tmpl];
}

- (NSDictionary*) encodeAsPropertyList
{
    assert(!classified);
    NSMutableDictionary *plist =
        [NSMutableDictionary dictionaryWithCapacity: 4];
    [plist setObject: NSStringFromClass([self class])
           forKey: @"type"];

    NSString *tmp = name;
    if(!tmp)
        tmp = @"";
    [plist setObject: tmp
           forKey: @"name"];

    tmp = nil;
    if(template)
        tmp = [template description];
    if(!tmp)
        tmp = @"";
    [plist setObject: tmp
           forKey: @"template"];

    if(openMode)
        [plist setObject: [NSNumber numberWithInteger: openMode]
               forKey: @"openMode"];
    return(plist);
}

- (Action*) match: (NSDictionary*) classification
{
    Action *copy = [self copy];
    copy->classified = YES;
    return([copy autorelease]);
}

+ (NSMutableArray*) allActions
{
    if(allActions)
        return(allActions);

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *actions = [defaults objectForKey: @"Actions"];
    assert(actions);
    assert([actions isKindOfClass: [NSArray class]]);

    allActions = [[NSMutableArray alloc]
                     initWithCapacity: actions.count];
    for(NSDictionary *action in actions) {
        if(![action isKindOfClass: [NSDictionary class]]) {
            assert(0);
            continue;
        }
        NSString *type = [action objectForKey: @"type"];
        if(!type || ![type isKindOfClass: [NSString class]]) {
            assert(0);
            continue;
        }
        Class cls = [[NSBundle mainBundle]
                        classNamed: type];
        if(!cls) {
            assert(0);
            continue;
        }
        [allActions addObject:
            [[[cls alloc]
                 initWithPropertyList: action]
                autorelease]];
    }
    DBLog(@"allActions=%@", allActions);
    return(allActions);
}

+ (void) saveActions
{
    if(!allActions)
        return;

    NSMutableArray *actions =
        [NSMutableArray arrayWithCapacity: allActions.count];
    for(Action *action in allActions)
        [actions addObject:
            [action encodeAsPropertyList]];

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject: actions
              forKey: @"Actions"];
}

+ (void) mergeActions: (NSArray*) newActions
{
    if(!newActions || ![newActions isKindOfClass: [NSArray class]]) {
        assert(0);
        return;
    }

    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *oldActions = [defaults objectForKey: @"Actions"];
    if(!oldActions || ![oldActions isKindOfClass: [NSArray class]])
        oldActions = [NSMutableArray new];
    else
        oldActions = [oldActions mutableCopy];

    NSMutableDictionary *oldByName =
        [NSMutableDictionary dictionaryWithCapacity: oldActions.count];
    NSMutableDictionary *oldByType =
        [NSMutableDictionary dictionaryWithCapacity: oldActions.count];

    NSInteger oldIndex = -1;
    for(NSDictionary *oldAction in oldActions) {
        ++oldIndex;
        if([oldAction isKindOfClass: [NSDictionary class]]) {
            NSNumber *idx = [NSNumber numberWithInteger: oldIndex];
            NSString *name = [oldAction objectForKey: @"name"];
            NSString *type = [oldAction objectForKey: @"type"];
            if(![oldByName objectForKey: name])
                [oldByName setObject: idx
                           forKey: name];
            NSString *key = [NSString stringWithFormat: @"%@::%@", type, name];
            if(![oldByType objectForKey: key])
                [oldByType setObject: idx
                           forKey: key];
        }
    }

    oldIndex = 0;
    for(NSDictionary *newAction in newActions) {
        if([newAction isKindOfClass: [Action class]])
            newAction = [(Action*)newAction encodeAsPropertyList];
        if(!newAction || ![newAction isKindOfClass: [NSDictionary class]]) {
            assert(0);
            continue;
        }
        NSString *name = [newAction objectForKey: @"name"];
        NSString *type = [newAction objectForKey: @"type"];
        NSString *key = [NSString stringWithFormat: @"%@::%@", type, name];
        NSNumber *idx = [oldByType objectForKey: key];
        if(idx) {
            oldIndex = idx.integerValue + 1;
            DBLog(@"merge[%d] keep old %@", oldIndex - 1, key);
            continue;
        }
        idx = [oldByName objectForKey: name];
        if(idx) {
            DBLog(@"merge[%d] replace old %@", oldIndex, key);
            oldIndex = idx.integerValue;
            [oldActions replaceObjectAtIndex: oldIndex
                        withObject: newAction];
        }
        else {
            DBLog(@"merge[%d] new %@", oldIndex, key);
            [oldActions insertObject: newAction
                        atIndex: oldIndex];
        }
        oldIndex++;
    }

    [defaults setObject: oldActions
              forKey: @"Actions"];
    [oldActions release];
}

- (BOOL) activateWithNavigationController: (UINavigationController*) nav
                                 animated: (BOOL) animated
{
    assert(0);
    return(NO);
}

@end


@implementation LinkAction
@synthesize url;

- (void) dealloc
{
    [url release];
    url = nil;
    [super dealloc];
}

- (BOOL) canEdit
{
    return(YES);
}

- (BOOL) canAutoLink
{
    return(YES);
}

- (NSString*) detailText
{
    if(!classified)
        return(nil);
    return([url absoluteString]);
}

- (Action*) match: (NSDictionary*) classification
{
    if(!template)
        return(nil);
    NSString *str = [template valueForMapping: classification];
    if(!str)
        return(nil);
    str = [str stringByAddingPercentEscapesUsingEncoding:
                   NSUTF8StringEncoding];

    LinkAction *result = (id)[super match: classification];
    if(!result)
        return(nil);

    result->url = [[NSURL URLWithString: str]
                      retain];
    if(openMode != ActionOpenModeExternal &&
       ![WebViewController canOpenInternal: result->url])
        result->openMode = ActionOpenModeExternal;
    return(result);
}

- (NSString*) description
{
    if(!classified)
        return([NSString stringWithFormat: @"<%@; name=%@; template=%@>",
                         NSStringFromClass([self class]), name, template]);
    else
        return([NSString stringWithFormat: @"<%@; name=%@; url=%@>",
                         NSStringFromClass([self class]), name, url]);
}

- (BOOL) activateWithNavigationController: (UINavigationController*) nav
                                 animated: (BOOL) animated
{
    // open web pages w/the integrated browser,
    // punt everything else to external handlers
    BOOL enableBrowser = [Settings globalSettings].enableBrowser;
    DBLog(@"opening URL(mode=%d en=%d): %@\n",
          openMode, enableBrowser, url);

    if(openMode == ActionOpenModeExternal ||
       (openMode == ActionOpenModeDefault && !enableBrowser))
    {
        [WebViewController openExternalURL: url];
        return(NO);
    }

    WebViewController *browser = [WebViewController new];
    [browser loadURL: url];

    [nav pushViewController: browser
         animated: animated];
    [browser release];
    return(YES);
}

@end


@implementation EmailAction

- (void) dealloc
{
    [to release];
    to = nil;
    [super dealloc];
}

- (NSString*) detailText
{
    if(!classified)
        return(nil);
    return(to);
}

- (Action*) match: (NSDictionary*) classification
{
    if(!template)
        return(nil);
    NSString *str = [template valueForMapping: classification];
    if(!str)
        return(nil);

    EmailAction *result = (id)[super match: classification];
    if(!result)
        return(nil);

    result->to = [str retain];
    return(result);
}

- (NSString*) description
{
    if(!classified)
        return([NSString stringWithFormat: @"<%@; name=%@; template=%@>",
                         NSStringFromClass([self class]), name, template]);
    else
        return([NSString stringWithFormat: @"<%@; name=%@; to=%@>",
                         NSStringFromClass([self class]), name, to]);
}

- (BOOL) activateWithNavigationController: (UINavigationController*) nav
                                 animated: (BOOL) animated
{
    if(openMode == ActionOpenModeExternal ||
       ![MFMailComposeViewController canSendMail])
    {
        NSURL *url = [NSURL URLWithString:
                         [@"mailto:" stringByAppendingString: to]];
        if(![[UIApplication sharedApplication]
                openURL: url])
        {
            UIAlertView *alert =
                [[UIAlertView alloc]
                    initWithTitle: @"ERROR"
                    message: @"Unable to send E-mail"
                    delegate: nil
                    cancelButtonTitle: @"Dismiss"
                    otherButtonTitles: nil];
            [alert show];
            [alert release];
        }
        return(NO);
    }

    MFMailComposeViewController *mailer =
        [MFMailComposeViewController new];
    mailer.mailComposeDelegate = [MailerCompletionHandler new];
    [mailer setToRecipients: [NSArray arrayWithObject: to]];

    [nav.view.window.rootViewController
        presentModalViewController: mailer
        animated: animated];
    [mailer release];

    return(YES);
}

@end
