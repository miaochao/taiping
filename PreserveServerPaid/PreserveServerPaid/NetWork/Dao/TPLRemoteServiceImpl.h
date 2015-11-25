//
//  TPLRemoteServiceImpl.h
//  TPLAppBQPad
//
//  Created by cz on 4/11/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

#import "TPLRemoteServiceProtocol.h"
//#import "TPLHessianURLConfig.h"

@interface TPLRemoteServiceImpl : NSObject{
    id<TPLRemoteServiceProtocol>proxy;
}

- (id<TPLRemoteServiceProtocol>)requestUrlWithStr:(NSString *)urlStr;
+ (id)getInstance;


@end
