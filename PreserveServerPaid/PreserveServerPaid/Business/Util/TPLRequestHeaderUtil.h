//
//  TPLRequestHeaderUtil.h
//  TPLAppBQPad
//
//  Created by cz on 4/23/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLRequestHeaderUtil : NSObject

+ (NSDictionary *)versionRequestHeader;
+ (NSDictionary *)loginRequestHeaderWithUserName:(NSString *)userName andUserPwd:(NSString *)userPwd;
+ (NSDictionary *)sessionRequestHeader;
+ (NSDictionary *)otherRequestHeader;

@end
