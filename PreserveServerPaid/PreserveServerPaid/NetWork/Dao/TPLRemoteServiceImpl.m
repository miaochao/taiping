//
//  TPLRemoteServiceImpl.m
//  TPLAppBQPad
//
//  Created by cz on 4/11/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLRemoteServiceImpl.h"
#import "CWHessianArchiver.h"
static TPLRemoteServiceImpl *remoteServiceImpl=nil;
@implementation TPLRemoteServiceImpl


- (id)init{
    if (self=[super init]) {
        //
        [TPLRemoteServiceImpl loadConfig];
        
    }
    return self;
}

+ (void)loadConfig{
    //1、加载API
    unsigned int count=0;
    struct objc_method_description *pList = protocol_copyMethodDescriptionList(@protocol(TPLRemoteServiceProtocol), YES, YES, &count);
    NSLog(@"%d",count);
    for (int index = 0; index<count; index++) {
        NSString *iosMethodName=NSStringFromSelector(pList[index].name);
        NSLog(@">>>>>>%@",iosMethodName);
        NSRange range=[iosMethodName rangeOfString:@"With"];
        NSLog(@"%d",range.length);
        NSLog(@"%d",range.location);
        NSString *javaMethodName=[iosMethodName substringToIndex:range.location];
        NSLog(@"<<<<<<%@",javaMethodName);
        [CWHessianArchiver setMethodName:javaMethodName forSelector:NSSelectorFromString(iosMethodName)];
    }
    free(pList);
    
    //2、加载Model
    [self loadModels];
    NSString *filePath=[[NSBundle mainBundle] pathForResource:@"ModelsList" ofType:@"txt"];
    NSString *modelsList=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *modelArray=[modelsList componentsSeparatedByString:@"\n"];
    for (NSString *model in modelArray) {
        NSArray *models=[model componentsSeparatedByString:@"="];
        if (models.count==2) {
            //NSLog(@"%@",[models objectAtIndex:0]);
            //NSLog(@"%@",[models objectAtIndex:1]);
            NSString *iosModelName=[models objectAtIndex:0];
            NSString *javaModelName=[models objectAtIndex:1];
            [CWHessianUnarchiver setProtocol:NSProtocolFromString(iosModelName) forClassName:javaModelName];
        }
    }
}

- (id<TPLRemoteServiceProtocol>)requestUrlWithStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    proxy=(id<TPLRemoteServiceProtocol>)[CWHessianConnection proxyWithURL:url
                                                                 protocol:@protocol(TPLRemoteServiceProtocol)];
    if (proxy!=nil) {
        return proxy;
    }
    return nil;
}

+ (id)getInstance{
    if (remoteServiceImpl==nil) {
        remoteServiceImpl=[[TPLRemoteServiceImpl alloc] init];
    }
    return remoteServiceImpl;
}


@end
