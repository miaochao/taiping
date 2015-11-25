//
//  TPLReach.h
//  TPLAppBQPad
//
//  Created by tplife on 5/12/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <sys/socket.h>
#import <arpa/inet.h>
#import <ifaddrs.h>
#import <netdb.h>


#define kTPLReachDefaultHost @"baidu.com"

typedef void (^TPLReachCB)(BOOL);

@interface TPLReachUtil : NSObject

+ (BOOL)netSatus;
+ (void)startNetStatus;
+ (TPLReachUtil *)defaultHost;
- (void)startWithCB:(TPLReachCB)changedBlock;
- (void)stop;
- (BOOL)isReach;

@end
