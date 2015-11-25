//
//  TPLReach.m
//  TPLAppBQPad
//
//  Created by tplife on 5/12/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLReachUtil.h"

enum {
	TPLReachRouteNone = 0,
	TPLReachRouteWiFi = 1,
	TPLReachRouteWWAN = 2,
};

enum {
	TPLReachRouteNO = 0,
	TPLReachRouteYES = 1,
};

static NSInteger NetStatus=TPLReachRouteNO;

typedef NSInteger TPLReachRoutes;

void TPLCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info);

static TPLReachUtil *reachInstance=nil;

@interface TPLReachUtil ()
@property(nonatomic) SCNetworkReachabilityRef reachability;
@property(nonatomic, copy) TPLReachCB changedBlock;
@end

@implementation TPLReachUtil
@synthesize reachability, changedBlock;

+ (BOOL)netSatus{
    return NetStatus;
}

//监视网络状态
+ (void)startNetStatus{
	[[TPLReachUtil defaultHost] startWithCB:^(BOOL isReach) {
        NSString *info=nil;
		if(isReach){
            info=@"当前设备网络可用";
            NetStatus=TPLReachRouteYES;
        }else{
            info=@"当前设备网络不可用";
            NetStatus=TPLReachRouteNO;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
#if DEBUG
            NSLog(@"%@",info);
#endif
            /*
            [[[[UIAlertView alloc] initWithTitle:nil message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] autorelease] show];
             */
        });
	}];
}
//监视网络状态结束

#pragma mark - Factory methods

+ (TPLReachUtil *)defaultHost {
    if (!reachInstance) {
        SCNetworkReachabilityRef reachabilityRef = SCNetworkReachabilityCreateWithName(NULL, [kTPLReachDefaultHost UTF8String]);
        reachInstance=[[TPLReachUtil alloc] initWithReachability:reachabilityRef];
    }
    
    return reachInstance;
}

#pragma mark - Object lifetime

- (id)initWithReachability:(SCNetworkReachabilityRef)reachabilityRef {
	if((self = [super init]) && reachabilityRef) {
		reachability = reachabilityRef;
		return self;
	}
    
	return nil;
}

- (void)dealloc {
	[self stop];
	if(reachability) {
		CFRelease(reachability);
		reachability = NULL;
	}
    [super dealloc];
}

#pragma mark - Reachability and notification methods

- (TPLReachRoutes)routesWithFlag:(SCNetworkReachabilityFlags)flags {
	TPLReachRoutes routes = TPLReachRouteNone;
	
	if(flags & kSCNetworkReachabilityFlagsReachable)
	{
		// Since WWAN is likely to require a connection, we initially assume a route with no connection required is WiFi
		if(!(flags & kSCNetworkReachabilityFlagsConnectionRequired)) {
			routes |= TPLReachRouteWiFi;
		}
		
		BOOL automatic = (flags & kSCNetworkReachabilityFlagsConnectionOnDemand) ||
        (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic);
		
		// Alternatively, a connection that connects on-demand/-traffic without intervention required might be WiFi too
		if(automatic && !(flags & kSCNetworkReachabilityFlagsInterventionRequired)) {
			routes |= TPLReachRouteWiFi;
		}
		
		// But if we're told explicitly that we're on WWAN, we throw away all earlier knowledge and just report WWAN
		if(flags & kSCNetworkReachabilityFlagsIsWWAN) {
			routes &= ~TPLReachRouteWiFi;
			routes |= TPLReachRouteWWAN;
		}
	}
    
	return routes;
}

- (void)startWithCB:(TPLReachCB)block {
	if(block && self.reachability) {
		self.changedBlock = block;
		SCNetworkReachabilityContext context = { 0, (__bridge void *)self, NULL, NULL, NULL };
		SCNetworkReachabilitySetCallback(self.reachability, TPLCallback, &context);
		SCNetworkReachabilityScheduleWithRunLoop(self.reachability, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
	} else {
		[self stop];
	}
}

- (void)stop{
	self.changedBlock = nil;
	if(self.reachability) {
		SCNetworkReachabilityUnscheduleFromRunLoop(self.reachability, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
		SCNetworkReachabilitySetCallback(self.reachability, NULL, NULL);
	}
}

- (BOOL)isReach{
    SCNetworkReachabilityFlags flags = 0;
	SCNetworkReachabilityGetFlags(self.reachability, &flags);
    return ([self routesWithFlag:flags] != TPLReachRouteNone);
}

@end

#pragma mark - Reachability callback function

void TPLCallback(SCNetworkReachabilityRef target, SCNetworkReachabilityFlags flags, void *info)
{
	TPLReachUtil *reach = (__bridge TPLReachUtil *)info;
    if(reach.changedBlock){
		reach.changedBlock(([reach routesWithFlag:flags] != TPLReachRouteNone));
    }
}
