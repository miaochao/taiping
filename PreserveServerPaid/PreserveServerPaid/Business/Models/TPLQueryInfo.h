//
//  TPLQueryInfo.h
//  TPLAppBQPad
//
//  Created by cz on 4/29/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLQueryInfo : NSObject

@property (assign, nonatomic) int tagType;//0:证件＋保单号 1:信息＋保单号

@property (retain, nonatomic) NSString *personId;
@property (retain, nonatomic) NSString *policyCode;
@property (retain, nonatomic) NSString *personName;
@property (retain, nonatomic) NSString *personSex;
@property (retain, nonatomic) NSString *personBirthday;

+ (TPLQueryInfo *)shareInstance;

- (void)updateQueryInfoWithPolicyCode:(NSString *)policyCode andPersonId:(NSString *)personId andPersonName:(NSString *)personName andPersonSex:(NSString *)personSex andPersonBirthday:(NSString *)personBirthday;

@end
