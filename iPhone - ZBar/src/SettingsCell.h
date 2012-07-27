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

@interface SettingsCell : UITableViewCell
{
    NSObject *object;
    NSDictionary *schema;
    NSString *keyPath;
}

+ (UITableViewCellStyle) cellStyle;
- (id) initWithObject: (NSObject *) _obj
               schema: (NSDictionary *) _schema;
- (void) updateObject: (NSObject *) value;
- (void) updateCell;
- (void) updateCell: (NSObject *) value;
- (void) settingsControllerDidSelectCell: (SettingsController *)settings;
@end

@interface ToggleCell : SettingsCell
{
    UISwitch *toggle;
}
@end

@interface CheckCell : SettingsCell
@end

@interface RadioCell : SettingsCell
{
    NSObject *value;
}
@end

@interface EnumCell : SettingsCell
{
    NSArray *values;
}
@end

@interface StringCell : SettingsCell
@end

@interface URLTemplateCell : StringCell
@end

@interface DisclosureCell : SettingsCell
@end
