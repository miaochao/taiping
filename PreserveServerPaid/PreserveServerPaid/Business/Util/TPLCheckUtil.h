//
//  TPLCheckUtil.h
//  TPLAppBQPad
//
//  Created by tpmac on 14-4-18.
//  Copyright (c) 2014年 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "CusAlertView.h"

@interface TPLCheckUtil : NSObject

//邮编
+ (BOOL)checkNum:(NSString *)str mixLength:(int)mixLength maxLength:(int)maxLength;
+ (BOOL)checkStrLength:(NSString *)str mixLength:(int)mixLength maxLength:(int)maxLength;

//手机号码
+ (BOOL)checkPhone:(NSString *)str;
+ (BOOL)checkMobil:(NSString *)str;
+ (BOOL)checkCompanyMobil:(NSString *)str;
+ (BOOL)checkEmail:(NSString *)str;
+ (BOOL)checkCardNum:(NSString *)str;

+ (BOOL)checkCustomerBirthday:(NSString *)str;

+ (BOOL)checkStartDate:(NSString *)startDate endDate:(NSString *)endDate;

+ (BOOL)isStrSame:(NSString *)str1 str2:(NSString *)str2;

/*
+ (BOOL)checkQueryInfoWithPolicyCode:(NSString *)policyCode andPersonId:(NSString *)personId andPersonName:(NSString *)personName andPersonSex:(NSString *)personSex andPersonBirthday:(NSString *)personBirthday;

+ (BOOL)checkQueryRespDataWithRemoteService:(CWDistantHessianObject *)remoteService andListBO:(id<TPLListBOModel>)listBO;
 */
@end
