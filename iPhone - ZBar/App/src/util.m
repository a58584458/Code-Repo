//------------------------------------------------------------------------
//  Copyright 2009-2010 (c) Jeff Brown <spadix@users.sourceforge.net>
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

#import "util.h"

// manage global network activity indicator for multiple accessors
int32_t netcnt = 0;

@interface NetworkActivity : NSObject;

+ (void) update: (NSNumber*) delta;

@end

@implementation NetworkActivity

+ (void) update: (NSNumber*) delta
{
    assert(netcnt >= 0);
    netcnt += [delta intValue];
    if(netcnt < 0) {
        // this occurs often enough that an assertion is really annoying
        // in the end, we would rather bottom out here than err the other way
        DBLog(@"WARNING: network activity cnt=%d", netcnt);
        netcnt = 0;
    }

    UIApplication *app = [UIApplication sharedApplication];
    if(app.networkActivityIndicatorVisible != (netcnt > 0))
        app.networkActivityIndicatorVisible = (netcnt > 0);
}

@end

void NetworkActivityUpdate (int delta)
{
    [NetworkActivity
        performSelectorOnMainThread: @selector(update:)
        withObject: [NSNumber numberWithInt: delta]
        waitUntilDone: NO];
}

static SCNetworkReachabilityRef networkReachability = NULL;

SCNetworkReachabilityRef NetworkReachabilityGet ()
{
    SCNetworkReachabilityRef reach = networkReachability;
    if(!reach)
        reach = networkReachability =
            SCNetworkReachabilityCreateWithName(NULL, "0.0.0.0");
    return(reach);
}

BOOL IsNetworkReachable ()
{
    SCNetworkReachabilityRef reach = NetworkReachabilityGet();
    SCNetworkReachabilityFlags flags;
    if(!SCNetworkReachabilityGetFlags(reach, &flags))
        return(NO);
    return((flags & kSCNetworkReachabilityFlagsReachable) != 0);
}


@implementation MailerCompletionHandler

// MFMailComposeViewControllerDelegate

- (void) mailComposeController: (MFMailComposeViewController*) mailer
           didFinishWithResult: (MFMailComposeResult) result
                         error: (NSError*) error
{
    assert(mailer.parentViewController);
    mailer.mailComposeDelegate = nil;
    [mailer dismissModalViewControllerAnimated: YES];

    if(result == MFMailComposeResultFailed) {
        UIAlertView *alert =
            [[UIAlertView alloc]
                initWithTitle: [error localizedDescription]
                message: [error localizedFailureReason]
                delegate: nil
                cancelButtonTitle: @"Dismiss"
                otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    [self autorelease];
}

@end


@implementation NSError (LogDump)

- (void) logWithMessage: (NSString*) message
{
    NSLog(@"ERROR %@: %@: %@\ninfo=%@",
          message,
          [self localizedDescription],
          [self localizedFailureReason],
          [self userInfo]);
}

@end


@implementation UIApplication (Save)

+ (void) saveAfterDelay: (NSTimeInterval) delay
{
    NSObject *delegate = [self sharedApplication].delegate;
    [delegate performSelector: @selector(save)
              withObject: nil
              afterDelay: delay];
}

@end


@implementation UIViewController (AdModal)

- (void) adPresentModalViewController: (UIViewController*) controller
                             animated: (BOOL) animated
{
    // fall back to system modal
    [self presentModalViewController: controller
          animated: animated];
}

- (void) adDismissModalViewController: (UIViewController*) controller
                             animated: (BOOL) animated
{
    // NB controller must be on top...
    assert(controller.parentViewController.modalViewController == controller);
    [self dismissModalViewControllerAnimated: animated];
}

@end


@implementation NSArray (Mapping)

- (NSArray*) arrayByPerformingSelector: (SEL) sel
                                target: (id) target
{
    NSMutableArray *result =
        [NSMutableArray arrayWithCapacity: [self count]];
    for(id item in self)
        [result addObject: [target performSelector: sel
                                   withObject: item]];
    return(result);
}

- (NSArray*) filteredArrayUsingSelector: (SEL) sel
                                 target: (id) target
{
    NSMutableArray *result =
        [NSMutableArray arrayWithCapacity: [self count]];
    for(id item in self)
        if([target performSelector: sel
                   withObject: item])
            [result addObject: item];
    return(result);
}

- (NSArray*) filteredArrayUsingSelector: (SEL) sel
                             withObject: (id) obj
{
    NSMutableArray *result =
        [NSMutableArray arrayWithCapacity: [self count]];
    for(id item in self)
        if([item performSelector: sel
                 withObject: obj])
            [result addObject: item];
    return(result);
}

@end


@implementation NSData (Base64)

- (NSString*) base64
{
    static const char alphabet[] =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    unsigned nsrc = [self length];
    unsigned ndst = (nsrc + 2) / 3 * 4 + nsrc / 57 + 2;
    uint8_t *dstbuf = CFAllocatorAllocate(NULL, ndst, 0);
    uint8_t *pdst = dstbuf;
    const uint8_t *psrc = [self bytes];
    int nline = 19;
    for(; nsrc; nsrc -= 3) {
        unsigned int src = *(psrc++) << 16;
        if(nsrc > 1) src |= *(psrc++) << 8;
        if(nsrc > 2) src |= *(psrc++);
        *(pdst++) = alphabet[(src >> 18) & 0x3f];
        *(pdst++) = alphabet[(src >> 12) & 0x3f];
        *(pdst++) = (nsrc > 1) ? alphabet[(src >> 6) & 0x3f] : '=';
        *(pdst++) = (nsrc > 2) ? alphabet[src & 0x3f] : '=';
        if(nsrc < 3) break;
        if(!--nline) { *(pdst++) = '\n'; nline = 19; }
    }
    *(pdst++) = '\n';
    *(pdst++) = '\0';
    assert(pdst == dstbuf + ndst);
    CFStringRef cfstr =
        CFStringCreateWithCStringNoCopy(NULL, (void*)dstbuf,
                                        NSASCIIStringEncoding, NULL);
    return([(NSString*)cfstr autorelease]);
}

@end
