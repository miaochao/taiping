//
//  TPLUUIDUtil.h
//  TPLAppBQPad
//
//  Created by cz on 4/23/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import <CommonCrypto/CommonDigest.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface TPLUUIDUtil : NSObject

+ (NSString *)deviceUUID;
+ (void)initUUID;

@end
