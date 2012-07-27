//
//  SpyObject.m
//  FSK Terminal
//
//  Created by George Dean on 1/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SpyObject.h"


@implementation SpyObject

- (id) fakeMethod
{
	return nil;
}

- (NSMethodSignature*) methodSignatureForSelector:(SEL)selector
{
	return [self methodSignatureForSelector:@selector(fakeMethod)];
}

-(void) forwardInvocation:(NSInvocation*)invocation
{
	NSLog(@"Received selector: %s", sel_getName([invocation selector]));
	[invocation setSelector:@selector(fakeMethod)];
	[invocation invokeWithTarget:self];
}

@end
