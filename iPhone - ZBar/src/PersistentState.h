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

// serialize/deserialize object state to a plist

@protocol PersistentState

// create a serializable data structure that includes everything
// necessary to restore the current state of the object
- (id) saveState;

// recreate previously saved state.
// returns YES if the state data structure was in the expected format
// and the object state was successfully restored.
// returns NO if the operation failed for any reason.
- (BOOL) restoreState: (id) state;

@end
