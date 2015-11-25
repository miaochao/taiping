//
//  TPLRequestHeaderUtil.m
//  TPLAppBQPad
//
//  Created by cz on 4/23/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//


#define kDeviceType @"1"                                                                                    //固定值1
#define kDeviceCode ([[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"])                          //设备序列号。mac地址取md5值
#define kVersionId ([[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"])     //版本号码。//CFBundleVersion
#define kReleaseType @"0"                                                                                   //0:测试 in house  1:发布到app store
#define kAppType @"30"                                                                                      //约定值30
#define kUpFlag @""                                                                                   //是否检测版本升级。测试阶段取cancel
#define kAction @"MOBIL_LOGIN"                                                                              //登录动作标识，移动端登录MOBIL_LOGIN
#define kAuthToken @""                                                                                      //固定值@""
#define kInservToken @""                                                                                    //登录是取@"";转发时取登录服务器返回的值
#define kPlantId @"150"                                                                                     //约定值150


//四种请求：BASICZ_INS：基础数据请求，LOGIN_INS：登录认证请求，OTHER_INS:业务请求（被转发的请求）,HEART_THROB：心跳请求
#define kVersionReqType @"HEART_THROB"
#define kLoginReqType @"LOGIN_INS"
#define kSessionReqType @"HEART_THROB"
#define kOtherReqType @"OTHER_INS"


#import "TPLRequestHeaderUtil.h"
#import "TPLSessionInfo.h"

@implementation TPLRequestHeaderUtil

+ (NSDictionary *)versionRequestHeader{
    NSString *deviceType=kDeviceType;//固定值1
    NSString *deviceCode=kDeviceCode;//设备序列号
    NSString *appCurVersion=kVersionId;//版本号
    NSString *releaseType=kReleaseType;//0:测试 in house   1:发布到app store
    NSString *appType=kAppType;//固定的值，是本App在移动接入平台的标识
    NSString *upFlag=kUpFlag;//固定的值
    
    NSString *reqType=kVersionReqType;
    
    NSDictionary *reqHeadDict=[NSDictionary dictionaryWithObjectsAndKeys:reqType, @"insType", deviceType, @"deviceType", deviceCode, @"deviceCode",appCurVersion, @"versionId", releaseType, @"releaseType", appType, @"appType", upFlag, @"upFlag", nil];
    return [reqHeadDict retain];
}

+ (NSDictionary *)loginRequestHeaderWithUserName:(NSString *)userName andUserPwd:(NSString *)userPwd{
    NSString *usrName=userName;//用户名
    NSString *usrPwd=userPwd;//用户密码
    
    NSString *sAction=kAction;//接入端认证动作
    NSString *deviceType=kDeviceType;
    NSString *deviceCode=kDeviceCode;
    NSString *authToken=kAuthToken;//?
    NSString *intservToken=kInservToken;//?会话id
    NSString *plantId=kPlantId;//?
    
    NSString *reqType=kLoginReqType;
    
    NSDictionary *reqHeadDict=[NSDictionary dictionaryWithObjectsAndKeys:reqType,@"insType",sAction,@"_login_sAction", usrName,@"_login_user_name", usrPwd,@"_login_password",deviceType,@"deviceType", deviceCode ,@"deviceCode", authToken,@"AUTH_TOKEN", intservToken ,@"INTSERV_TOKEN", plantId,@"PLANT_ID", nil];
    //NSDictionary *reqHeadDict=[NSDictionary dictionaryWithObjectsAndKeys:reqType,@"insType",sAction,@"_login_sAction", usrName,@"_login_user_name", usrPwd,@"_login_password",deviceType,@"deviceType",  authToken,@"AUTH_TOKEN", intservToken ,@"INTSERV_TOKEN", plantId,@"PLANT_ID", deviceCode ,@"deviceCode",nil];
    NSLog(@"%@",reqHeadDict);
    return [reqHeadDict retain];
}

+ (NSDictionary *)sessionRequestHeader{
    NSString *heartReqType=kSessionReqType;
    NSDictionary *heartReqHeadDict=[NSDictionary dictionaryWithObjectsAndKeys:heartReqType,@"insType", nil];
    return [heartReqHeadDict retain];
}

+ (NSDictionary *)otherRequestHeader{
    id<ISUserExt> userExt=[TPLSessionInfo shareInstance].isUserExt;
    NSString *intservToken=userExt.inservToken;//?会话id
    NSString *userName=userExt.userName;//用户名
    
    NSString *upFlag=kUpFlag;//固定的值
    NSString *authToken=kAuthToken;//userExt.authToken;//?
    NSString *versionId=kVersionId;//版本号
    NSString *releaseType=kReleaseType;//0:测试 in house   1:发布到app store
    NSString *appType=kAppType;//固定的值，是本App在移动接入平台的标识
    NSString *plantId=kPlantId;//?
    NSString *deviceCode=kDeviceCode;//?
    
    NSString *reqType=kOtherReqType;//
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:reqType,@"insType",upFlag,@"upFlag",authToken,@"AUTH_TOKEN",intservToken,@"INTSERV_TOKEN",userName,@"_login_user_name",versionId,@"versionId",releaseType,@"releaseType",appType,@"appType",plantId,@"PLANT_ID",deviceCode,@"deviceCode", nil];
    return [dic retain];
}

@end
