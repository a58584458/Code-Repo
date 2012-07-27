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

#define xNSSTR(s) @#s
#define NSSTR(s) xNSSTR(s)

#ifndef NDEBUG
# ifdef DEBUG_MODULE
#  define DBLog(fmt, ...) \
    NSLog(NSSTR(DEBUG_MODULE) @": " fmt, ##__VA_ARGS__)
# else
#  define DBLog(...) NSLog(__VA_ARGS__)
# endif
#else
# define DBLog(...)
#endif

// manage network activity indicator for multiple accessors
void NetworkActivityUpdate(int);

// network reachability wrapper
SCNetworkReachabilityRef NetworkReachabilityGet();
BOOL IsNetworkReachable();


@interface MailerCompletionHandler
    : NSObject
    < MFMailComposeViewControllerDelegate >
@end


@interface NSError (LogDump)
- (void) logWithMessage: (NSString*) message;
@end


@interface UIApplication (Save)
+ (void) saveAfterDelay: (NSTimeInterval) delay;
@end


@interface UIViewController (AdModal)
- (void) adPresentModalViewController: (UIViewController*) controller
                             animated: (BOOL) animated;
- (void) adDismissModalViewController: (UIViewController*) controller
                             animated: (BOOL) animated;
@end


@interface NSArray (Mapping)
- (NSArray*) arrayByPerformingSelector: (SEL) sel
                                target: (id) target;
- (NSArray*) filteredArrayUsingSelector: (SEL) sel
                                 target: (id) target;
- (NSArray*) filteredArrayUsingSelector: (SEL) sel
                             withObject: (id) obj;
@end


@interface NSData (Base64)
- (NSString*) base64;
@end
