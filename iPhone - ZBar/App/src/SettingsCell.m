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

#import "Settings.h"
#import "SettingsController.h"
#import "TextEditController.h"
#import "SettingsCell.h"
#import "util.h"

@implementation SettingsCell

+ (UITableViewCellStyle) cellStyle
{
    return(UITableViewCellStyleDefault);
}

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithStyle: [[self class] cellStyle]
                  reuseIdentifier: nil];
    if(!self)
        return(nil);

    object = [_obj retain];
    schema = [_schema retain];
    keyPath = [[_schema objectForKey: @"keyPath"]
                  retain];

    [object addObserver: self
            forKeyPath: keyPath
            options: 0
            context: NULL];

    return(self);
}

- (void) dealloc
{
    @try {
        [object removeObserver: self
                forKeyPath: keyPath];
    }
    @catch(...) { }

    [keyPath release];
    keyPath = nil;
    [schema release];
    schema = nil;
    [object release];
    object = nil;
    [super dealloc];
}

- (void) observeValueForKeyPath: (NSString*) key
                       ofObject: (id) object
                         change: (NSDictionary*) change
                        context: (void*) ctx
{
    [self updateCell];
}

- (void) updateObject: (NSObject*) value
{
    [object setValue: value
            forKeyPath: keyPath];
}

- (void) updateCell
{
    [self updateCell: [object valueForKeyPath: keyPath]];
}

- (void) updateCell: (NSObject*) value
{
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    [self setSelected: NO
          animated: YES];
}

@end


@implementation ToggleCell

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    toggle = [UISwitch new];
    [toggle addTarget: self
            action: @selector(didChangeValue)
            forControlEvents: UIControlEventValueChanged];
    self.accessoryView = toggle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    [self updateCell];

    return(self);
}

- (void) dealloc
{
    [toggle release];
    toggle = nil;
    [super dealloc];
}

- (void) didChangeValue
{
    [self updateObject: [NSNumber numberWithBool: toggle.on]];
}

- (void) updateCell: (NSObject*) value
{
    if([value isKindOfClass: [NSNumber class]]) {
        BOOL boolValue = [(NSNumber*)value boolValue];

        if(toggle.on != boolValue)
            toggle.on = boolValue;
    } else {
        [self updateObject: [NSNumber numberWithBool: NO]];
        assert(!value);
    }
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    [toggle setOn: !toggle.on
            animated: YES];
    [self didChangeValue];
    [super settingsControllerDidSelectCell: settings];
}

@end


@implementation CheckCell

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    [self updateCell];

    return(self);
}

- (void) updateCell: (NSObject*) value
{
    if([value isKindOfClass: [NSNumber class]]) {
        BOOL boolValue = [(NSNumber*)value boolValue];
        UITableViewCellAccessoryType checked;

        if(boolValue)
            checked = UITableViewCellAccessoryCheckmark;
        else
            checked = UITableViewCellAccessoryNone;

        if(self.accessoryType != checked)
            self.accessoryType = checked;
    } else {
        [self updateObject: [NSNumber numberWithBool: NO]];
        assert(!value);
    }
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    BOOL checked;
    if(self.accessoryType == UITableViewCellAccessoryNone)
        checked = YES;
    else
        checked = NO;

    [self updateObject: [NSNumber numberWithBool: checked]];
    [super settingsControllerDidSelectCell: settings];
}

@end


@implementation RadioCell

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    value = [[_schema objectForKey: @"value"]
                retain];
    [self updateCell];

    return(self);
}

- (void) dealloc
{
    [value release];
    value = nil;
    [super dealloc];
}

- (void) updateCell: (NSObject*) _value
{
    UITableViewCellAccessoryType checked;
    if([_value isEqual: value])
        checked = UITableViewCellAccessoryCheckmark;
    else
        checked = UITableViewCellAccessoryNone;
    if(self.accessoryType != checked)
        self.accessoryType = checked;
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    [self updateObject: value];
    [super settingsControllerDidSelectCell: settings];
}

@end


@implementation EnumCell

+ (UITableViewCellStyle) cellStyle
{
    return(UITableViewCellStyleValue1);
}

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    // validate sub-schema
    values = [_schema objectForKey: @"enum"];
    if(values && ![values isKindOfClass: [NSArray class]])
        values = nil;
    else {
        for(NSDictionary *val in values)
            if(![val isKindOfClass: [NSDictionary class]] ||
               ![[val objectForKey: @"title"]
                    isKindOfClass: [NSString class]])
                values = nil;
        [values retain];
    }

    [self updateCell];

    return(self);
}

- (void) dealloc
{
    [values release];
    values = nil;
    [super dealloc];
}

- (NSString*) titleForValue: (NSObject*) value
{
    for(NSDictionary *val in values)
        if([value isEqual: [val objectForKey: @"value"]])
            return([val objectForKey: @"title"]);
    return(nil);
}

- (void) updateCell: (NSObject*) value
{
    DBLog(@"%@: update=%@", self, value);
    NSString *desc = nil;
    desc = [self titleForValue: value];
    self.detailTextLabel.text = desc;

    if(!desc && values.count)
        [self updateObject:
            [(NSDictionary*)[values objectAtIndex: 0]
                objectForKey: @"value"]];
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    // build settings schema for value selection
    NSMutableArray *cells =
        [NSMutableArray arrayWithCapacity: values.count];
    for(NSDictionary *value in values)
        [cells addObject:
            [NSDictionary dictionaryWithObjectsAndKeys:
                keyPath, @"keyPath",
                [value objectForKey: @"title"], @"title",
                [value objectForKey: @"value"], @"value",
                @"RadioCell", @"type",
                @"NSNumber", @"valueType",
                nil]];

    NSDictionary *subSchema =
        [NSDictionary dictionaryWithObjectsAndKeys:
            [self.textLabel.text stringByAppendingString: @" Options"],
                @"title",
            [NSArray arrayWithObject:
                [NSDictionary dictionaryWithObject: cells
                              forKey: @"cells"]],
                @"sections",
            nil];

    // push settings controller to select value
    SettingsController *svc =
        [[SettingsController alloc]
            initWithObject: object
            schema: subSchema];
    svc.autoDismiss = YES;

    [settings.navigationController
         pushViewController: svc
         animated: YES];
    [svc release];
}

@end


@implementation StringCell

+ (UITableViewCellStyle) cellStyle
{
    return(UITableViewCellStyleValue1);
}

- (Class) editorClass
{
    return([TextEditController class]);
}

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    [self updateCell];

    return(self);
}

- (void) updateCell: (NSObject*) value
{
    if(![value isKindOfClass: [NSString class]])
        value = [value description];
    self.detailTextLabel.text = (id)value;
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    UIViewController *editor =
        [[[self editorClass]
             alloc]
            initWithObject: object
            keyPath: keyPath];
    editor.title = [NSString stringWithFormat: @"%@ %@",
                       settings.title, self.textLabel.text];

    [settings.navigationController
         pushViewController: editor
         animated: YES];
    [editor release];
}

@end


@implementation URLTemplateCell

- (Class) editorClass
{
    return([TemplateEditController class]);
}

@end


@implementation DisclosureCell

- (id) initWithObject: (NSObject*) _obj
               schema: (NSDictionary*) _schema
{
    self = [super initWithObject: _obj
                  schema: _schema];
    if(!self)
        return(nil);

    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return(self);
}

- (void) settingsControllerDidSelectCell: (SettingsController*) settings
{
    NSString* file = [schema objectForKey: @"file"];
    if(!file || !file.length) {
        assert(0);
        return;
    }

    NSMutableDictionary* subValues =
        [[[object valueForKey: keyPath]
             mutableCopy]
            autorelease];
    if(![subValues isKindOfClass: [NSDictionary class]]) {
        subValues = nil;
        assert(0);
    }
    if(!subValues)
        subValues = [NSMutableDictionary dictionary];

    // install the sub-dictionary
    [object setValue: subValues
            forKey: keyPath];

    SettingsController *svc =
        [[SettingsController alloc]
            initWithObject: subValues
            schemaName: file];

    [settings.navigationController
         pushViewController: svc
         animated: YES];
    [svc release];
}

@end
