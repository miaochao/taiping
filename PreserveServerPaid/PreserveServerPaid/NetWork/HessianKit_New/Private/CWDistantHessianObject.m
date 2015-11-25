//
//  CWDistantHessianObject.m
//  HessianKit
//
//  Copyright 2008-2009 Fredrik Olsson, Cocoway. All rights reserved.
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License. 
//  You may obtain a copy of the License at 
// 
//  http://www.apache.org/licenses/LICENSE-2.0 
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS, 
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CWDistantHessianObject.h"
#import "CWDistantHessianObject+Private.h"
#import "CWHessianConnection.h"
#import "CWHessianArchiver.h"
#import "CWHessianArchiver+Private.h"
#import <objc/runtime.h>

static NSMethodSignature* getMethodSignatureRecursively(Protocol *p, SEL aSel)
{
	NSMethodSignature* methodSignature = nil;
	struct objc_method_description md = protocol_getMethodDescription(p, aSel, YES, YES);
  if (md.name == NULL) {
  	unsigned int count = 0;
  	Protocol **pList = protocol_copyProtocolList(p, &count);
    for (int index = 0; !methodSignature && index < 0; index++) {
    	methodSignature = getMethodSignatureRecursively(pList[index], aSel);
    }
    free(pList);
  } else {
  	methodSignature = [NSMethodSignature signatureWithObjCTypes:md.types];
  }
  return methodSignature;
}

@interface CWDistantHessianObject ()
@property(retain, nonatomic) NSURL* URL;
@property(assign, nonatomic) Protocol* protocol;
@property(retain, nonatomic) NSMutableDictionary* methodSignatures;
@end

@implementation CWDistantHessianObject

@synthesize connection = _connection;
@synthesize URL = _URL;
@synthesize protocol = _protocol;
@synthesize methodSignatures = _methodSignatures;

-(void)dealloc;
{
	self.connection = nil;
  self.URL = nil;
  self.protocol = nil;
  self.methodSignatures = nil;
  [super dealloc];
}

-(id)initWithConnection:(CWHessianConnection*)connection URL:(NSURL*)URL protocol:(Protocol*)aProtocol;
{
  self.connection = connection;
  self.URL = URL;
	self.protocol = aProtocol;
  self.methodSignatures = [NSMutableDictionary dictionary];
  return self;
}

-(BOOL)conformsToProtocol:(Protocol*)aProtocol;
{
	if (self.protocol == aProtocol) {
  	return YES;
  } else {
  	return [super conformsToProtocol:aProtocol];
  }
}

-(BOOL)isKindOfClass:(Class)aClass;
{
	if (aClass == [self class] || aClass == [NSProxy class]) {
  	return YES;
  }
  return NO;
}

-(NSString*)remoteClassName;
{
	NSString* protocolName = [CWHessianArchiver classNameForProtocol:self.protocol];
  if (!protocolName) {
  	protocolName = NSStringFromProtocol(self.protocol);
  }
  return protocolName;
}

//唯一函数调用方法,获取参数数据->核心(序列化－>网络请求->反序列化)->设置返回值
-(void)forwardInvocation:(NSInvocation *)invocation;
{
	NSData* requestData = [self archivedDataForInvocation:invocation];
#if DEBUG
  //NSLog(@"%@", [requestData description]);
#endif
  //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
  NSData* responseData = [self sendRequestWithPostData:requestData];
  //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
#if DEBUG
  //NSLog(@"%@", [responseData description]);
#endif
  id returnValue = [self unarchiveData:responseData];
  if (returnValue) {
    if ([returnValue isKindOfClass:[NSException class]]) {
      [(NSException*)returnValue raise];
      return;  
    }
  }
  [self setReturnValue:returnValue invocation:invocation];
}
//函数调用代理方法定义结束

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector;
{
    if (aSelector != _cmd && ![NSStringFromSelector(aSelector) hasPrefix:@"_cf"]) {
        //NSNumber* selectorKey = [NSNumber numberWithInteger:((NSInteger)aSelector)];//修改了
        NSString *selectorKey=NSStringFromSelector(aSelector);
        NSMethodSignature* signature = [self.methodSignatures objectForKey:selectorKey];
        if (!signature) {
            signature = getMethodSignatureRecursively(self.protocol, aSelector);
            if (signature) {
                [self.methodSignatures setObject:signature forKey:selectorKey];
            }
        }
        return signature;
    } else {
        return nil;
    }
}


//唯一的网络请求方法,同步请求
-(NSData*)sendRequestWithPostData:(NSData*)postData;
{
    NSData* responseData = nil;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.URL
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30.0];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    // Fool Tomcat 4, fails otherwise...
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-type"];
    
    //修改 by cz at 20140410 功能：添加请求的http头
   // NSLog(@"req head:\n%@", [_reqHeadDict description]);
    if (_reqHeadDict!=nil) {
        [request setAllHTTPHeaderFields:_reqHeadDict];
    }
    //结束 修改 by cz at 20140410
    
    NSHTTPURLResponse * returnResponse = nil;
    NSError* requestError = nil;
    responseData = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&returnResponse error:&requestError];
    if (requestError) {
        responseData = nil;
        [NSException raise:NSInvalidArchiveOperationException format:@"Network error domain:%@ code:%d", [requestError domain], [requestError code]];
    } else if (returnResponse != nil) {
        if ([returnResponse statusCode] == 200) {
            [responseData retain];
            //修改 by cz at 20140410 功能：打印响应的http头
            NSDictionary *respDict=[returnResponse allHeaderFields];
            _resHeadDict=[respDict retain];
#if DEBUG
           // NSLog(@"resp head:\n%@", [_resHeadDict description]);
#endif
            //结束 修改 by cz at 20140410
        } else {
            responseData = nil;
            [NSException raise:NSInvalidArchiveOperationException format:@"HTTP error %d", [returnResponse statusCode]];
        }
    } else {
        responseData = nil;
        [NSException raise:NSInvalidArchiveOperationException format:@"Unknown network error"];
    }
    return responseData ? [responseData autorelease] : nil;
}
//唯一的网络请求方法,同步请求结束



@end
