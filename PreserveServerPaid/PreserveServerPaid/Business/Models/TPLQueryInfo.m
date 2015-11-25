//
//  TPLQueryInfo.m
//  TPLAppBQPad
//
//  Created by cz on 4/29/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLQueryInfo.h"

static TPLQueryInfo *queryInfo=nil;

@implementation TPLQueryInfo

+ (TPLQueryInfo *)shareInstance{
    if (queryInfo==nil) {
        queryInfo=[[TPLQueryInfo alloc] init];
    }
    return queryInfo;
}

- (void)updateQueryInfoWithPolicyCode:(NSString *)policyCode andPersonId:(NSString *)personId andPersonName:(NSString *)personName andPersonSex:(NSString *)personSex andPersonBirthday:(NSString *)personBirthday{
    TPLQueryInfo *queryInfo=[TPLQueryInfo shareInstance];
    [queryInfo setPolicyCode:policyCode];
    [queryInfo setPersonId:personId];
    [queryInfo setPersonName:personName];
    [queryInfo setPersonSex:personSex];
    [queryInfo setPersonBirthday:personBirthday];
}

@end
