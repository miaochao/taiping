//
//  TPLVersionUtil.m
//  TPLAppBQPad
//
//  Created by cz on 5/21/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLVersionUtil.h"

@implementation TPLVersionUtil
/*
//版本管理
+ (void)versionControl{
    //版本管理
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLRemoteServiceProtocol> remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,MOBILINTERFACEURL]];
        CGFloat iosVersion=[[[UIDevice currentDevice] systemVersion] floatValue];
        [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil versionRequestHeader]];
        NSString *isIosSevenOne=@"0";
        if (iosVersion>=7.1f) {
            isIosSevenOne=@"1";
        }
        NSDictionary *versionInfo=nil;
        @try {
            versionInfo=[remoteService getLastVersionIdWithAppType:@"30" andIsIosApp:@"1" andIsIosSevenOne:isIosSevenOne];
        }
        @catch (NSException *exception) {
            //
#if DEBUG
            NSLog(@"%@:Hessian调用出错！- %@",@"getLastVersionIdWithAppType",exception);
#endif
        }
        [(CWDistantHessianObject *)remoteService resHeadDict];
        if (versionInfo!=nil&&versionInfo.count==2) {
            //
            NSString *serverVersion=[versionInfo valueForKey:@"RELEASE_CODE"];
            NSString *serverVersionId=[versionInfo valueForKey:@"VERSION_ID"];
            NSString *appCurVersion=[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];//CFBundleVersion
            if (![serverVersion isEqualToString:appCurVersion]) {
                //服务器版本跟本地版本不一致，进行下载并更新
                NSString *rootUrlStr=HESSIANURL;
                if ([rootUrlStr rangeOfString:@"https"].location!=NSNotFound) {
                    rootUrlStr=[rootUrlStr stringByReplacingOccurrencesOfString:@"https" withString:@"http"];
                }
                NSString *downloadUrlStr=[NSString stringWithFormat:@"%@%@",rootUrlStr,[NSString stringWithFormat:MOBILEVERSIONDOWNLOADURL,serverVersionId]];
                if ([isIosSevenOne isEqualToString:@"0"]) {
                    //非ios 7.1及以下
                    downloadUrlStr=[@"itms-services://?action=download-manifest&url=" stringByAppendingString:downloadUrlStr];
                }else if ([isIosSevenOne isEqualToString:@"1"]){
                    //ios 7.1及以上
                    downloadUrlStr=[@"itms-services://?action=download-manifest&url=" stringByAppendingString:[downloadUrlStr stringByReplacingOccurrencesOfString:@"http" withString:@"https"]];
                }
                NSURL *downloadUrl=[NSURL URLWithString:downloadUrlStr];
                //根据下载的地址进行App安装文件下载
                dispatch_async(dispatch_get_main_queue(), ^{
#if DEBUG
                    NSLog(@"%@",@"开始更新App！");
#endif
                    [[UIApplication sharedApplication] openURL:downloadUrl];
                });
            }
        }
    });
}
//版本管理结束
*/
@end
