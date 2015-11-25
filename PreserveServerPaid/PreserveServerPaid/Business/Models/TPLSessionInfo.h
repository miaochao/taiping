//
//  TPLSessionInfo.h
//  TPLAppBQPad
//
//  Created by tpmac on 14-4-9.
//  Copyright (c) 2014年 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "TPLQueryModel.h"
#import "Models.h"

@interface TPLSessionInfo : NSObject

@property (assign, nonatomic) id<ISUserExt> isUserExt;
@property (assign, nonatomic) id<TPLUserBOModel> userBOModel;
//@property (assign, nonatomic) id<TPLQueryModel> queryModel;
@property (retain, nonatomic) NSString *password;
@property (assign, nonatomic) id<TPLAgentBOModel> agentBOModel;
@property (retain, nonatomic) NSDictionary *menuImageDic;
@property (retain, nonatomic) NSDictionary *menuViewDic;

@property (retain, nonatomic) NSString *firstMenuSelectIndex;

@property (retain, nonatomic) NSString *userCate;

@property (nonatomic ,retain)NSDictionary   *custmerDic;//功能页面客户的个人信息
@property (assign, nonatomic) id<TPLCustomerInfoBO> customerInfoBO;//点击功能时客户的三种方式返回信息
+ (TPLSessionInfo *)shareInstance;

@end
