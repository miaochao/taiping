#import <Foundation/Foundation.h>

@protocol ISUserExt   

//ISUser
@property(retain, nonatomic) NSString *userId;
@property(retain, nonatomic) NSString *userName;
@property(retain, nonatomic) NSString *password;
@property(retain, nonatomic) NSString *realName;
@property(retain, nonatomic) NSString *certiCode;
@property(retain, nonatomic) NSString *userCate;
@property(retain, nonatomic) NSString *headId;
@property(retain, nonatomic) NSString *organId;
@property(retain, nonatomic) NSString *deptCode;
@property(retain, nonatomic) NSString *rawStaffId;
@property(retain, nonatomic) NSString *disabled;
//应用系统口令及登录安全措施修改 start
@property(retain, nonatomic) NSString *isFirstLogin;
@property(retain, nonatomic) NSString *isLocked;
@property(retain, nonatomic) NSString *failTimes;
@property(retain, nonatomic) NSString *encryption;
@property(retain, nonatomic) NSString *lockedType;
@property(assign, nonatomic) NSDate *lockedTime;
@property(assign, nonatomic) NSDate *pwdChange;
@property(assign, nonatomic) NSDate *latestLoginTime;
@property(retain, nonatomic) NSArray *moduleList;
@property(retain, nonatomic) NSArray *moduleUrlSet;
//ISUser结束

//ISUserExt
@property(retain, nonatomic) NSString *deviceType;
@property(retain, nonatomic) NSString *deviceCode;
@property(retain, nonatomic) NSString *authToken;
@property(retain, nonatomic) NSString *inservToken;//客户端自己添加的
@property(retain, nonatomic) NSString *latestIp;
@property(retain, nonatomic) NSString *isActive;
//ISUserExt结束

@end




//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU START>>>>>>>>>>>>>>>>
//Created by JModel2OCModel on Thu Apr 17 10:30:11 CST 2014
//Model Count Equal 4
//Support By CZ
//Mail To arvin.sfj@gmail.com
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU END>>>>>>>>>>>>>>>>>>

//
// TPLAgentBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:11 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLAgentBOModel   

@property(assign, nonatomic) int64_t agentId;
@property(retain, nonatomic) NSString *agentName;
@property(retain, nonatomic) NSString *gender;
@property(retain, nonatomic) NSDate *birthday;
@property(retain, nonatomic) NSString *moblie;
@property(retain, nonatomic) NSString *email;
@property(retain, nonatomic) NSString *orgId;
@property(retain, nonatomic) NSString *marriage;
@property(retain, nonatomic) NSString *international;
@property(retain, nonatomic) NSString *nation;
@property(retain, nonatomic) NSString *address;
@property(retain, nonatomic) NSString *idType;
@property(retain, nonatomic) NSString *idNo;
@property(retain, nonatomic) NSString *level;
@property(retain, nonatomic) NSString *memo;

@end

//
// TPLErrorBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:11 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLErrorBOModel   

@property(retain, nonatomic) NSString *errorCode;
@property(retain, nonatomic) NSString *errorInfo;
@property(retain, nonatomic) NSString *returnMsg;

@end

//
// TPLBasicBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:11 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLBasicBOModel   

@property(retain, nonatomic) id basic;
@property(retain, nonatomic) id<TPLErrorBOModel> error;


@end

//
// TPLListBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:11 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLListBOModel   

@property(retain, nonatomic) NSArray *objList;
@property(retain, nonatomic) id<TPLErrorBOModel> errorBean;
@property(assign, nonatomic) int32_t currentPageIndex;
@property(assign, nonatomic) int32_t totalCount;

@end


//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU START>>>>>>>>>>>>>>>>
//Created by JModel2OCModel on Thu Apr 17 10:30:49 CST 2014
//Model Count Equal 3
//Support By CZ
//Mail To arvin.sfj@gmail.com
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU END>>>>>>>>>>>>>>>>>>

//
// TPLMenuBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:49 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLMenuBOModel   

@property(retain, nonatomic) NSString *menuId;
@property(retain, nonatomic) NSString *menuName;
@property(retain, nonatomic) NSString *menuCode;
@property(retain, nonatomic) NSString *sequence;
@property(retain, nonatomic) NSArray *childMenus;
@property(retain, nonatomic) NSString *isShow;

@end


//
// TPLRoleBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:49 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLRoleBOModel   

@property(retain, nonatomic) NSString *roleId;
@property(retain, nonatomic) NSString *roleName;
@property(retain, nonatomic) NSArray *menus;

@end

//
// TPLUserBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:30:49 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLChangeReturnBOModel;

@protocol TPLUserBOModel   

@property(retain, nonatomic) NSString *userName;
@property(retain, nonatomic) NSString *realName;
@property(retain, nonatomic) NSString *isSign;          //Y表示同意过，N表示未同意过
@property(retain, nonatomic) NSArray *roleList;
@property(retain, nonatomic) id<TPLChangeReturnBOModel> changeReturn;

@end



//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU START>>>>>>>>>>>>>>>>
//Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//Model Count Equal 12
//Support By CZ
//Mail To arvin.sfj@gmail.com
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>MENU END>>>>>>>>>>>>>>>>>>

//
// TPLBonusWayBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLBonusWayBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *productAbbr;
@property(retain, nonatomic) NSString *isBonus;
@property(retain, nonatomic) NSString *bonusType;
@property(retain, nonatomic) NSDictionary *allBonusType;
@property(retain, nonatomic) NSArray *bonusWayBOs;
@property(retain, nonatomic) NSString *isChange;
@property(retain, nonatomic) NSString *productId;

//m 添加 被保人和状态
@property(retain, nonatomic) NSString *insuredName;
@property(retain, nonatomic) NSString *liablityStatus;

@end

//
// TPLChangeReturnBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLChangeReturnBOModel   

@property(retain, nonatomic) NSString *returnFlag;
@property(retain, nonatomic) NSString *changeId;
@property(retain, nonatomic) NSString *returnMessage;

@end

//
// TPLChargeFeeAddrBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLChargeFeeAddrBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *addressFee;
@property(retain, nonatomic) NSString *zipLink;

@end

//
// TPLCustomerBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLCustomerBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *address;
@property(retain, nonatomic) NSString *zip;
@property(retain, nonatomic) NSString *phone;
@property(retain, nonatomic) NSString *jobAddress;
@property(retain, nonatomic) NSString *jobZip;
@property(retain, nonatomic) NSString *jobPhone;
@property(retain, nonatomic) NSString *mobile;
@property(retain, nonatomic) NSString *email;

@end

//
// TPLDrawAccountBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLDrawAccountBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *realName;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *productAbbr;
@property(retain, nonatomic) NSString *modeName;
@property(retain, nonatomic) NSString *authName;
@property(retain, nonatomic) NSDate *realloDate;
@property(assign, nonatomic) NSString *bonusSa;
@property(assign, nonatomic) NSString *distriAmount;

@end

//
// TPLInvestmentBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLInvestmentBOModel   

@property(retain, nonatomic) NSString *applicantId;
@property(retain, nonatomic) NSString *productName;
@property(retain, nonatomic) NSString *investAccountName;
@property(retain, nonatomic) NSString *accumUnits;
@property(retain, nonatomic) NSDate *pricingDate;
@property(assign, nonatomic) NSString *fundSellPrice;
@property(assign, nonatomic) NSString *fundPurcPrice;

@end

//
// TPLLoanAccountBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLLoanAccountBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSDate *loanTime;
@property(assign, nonatomic) NSString *capitalAmount;
@property(assign, nonatomic) NSString *repayAmount;
@property(assign, nonatomic) NSString *balanceAccount;
@property(assign, nonatomic) NSString *loanAmount;
@property(assign, nonatomic) NSString *interestRate;
@property(retain, nonatomic) NSDate *settledTime;
@property(retain, nonatomic) NSString *channelDesc;

@end

//
// TPLPolicyBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLPolicyBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSDate *validateDate;
@property(retain, nonatomic) NSString *liabilityStatus;
@property(retain, nonatomic) NSString *applicantName;
@property(retain, nonatomic) NSString *insurantName;
@property(retain, nonatomic) NSString *productName;
@property(retain, nonatomic) NSString *productCate;
@property(retain, nonatomic) NSString *agentCode;

@end

//
// TPLPreserveBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLPreserveBOModel   

@property(retain, nonatomic) NSString *changeId;
@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *serviceName;
@property(retain, nonatomic) NSString *changeStatus;
@property(retain, nonatomic) NSString *noticeCode;
@property(retain, nonatomic) NSString *handlerName;
@property(retain, nonatomic) NSDate *proposeTime;
@property(retain, nonatomic) NSDate *validateDate;
@property(retain, nonatomic) NSString *channelDesc;
@property(retain, nonatomic) NSString *approval;

@end

//
// TPLPreserveProgressBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLPreserveProgressBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *changeId;
@property(retain, nonatomic) NSString *serviceName;
@property(retain, nonatomic) NSString *changeStatus;
@property(retain, nonatomic) NSString *noticeCode;
@property(retain, nonatomic) NSString *handlerName;
@property(retain, nonatomic) NSDate *proposeTime;
@property(retain, nonatomic) NSString *bizChannel;

@end

//
// TPLSendWayBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLSendWayBOModel   

@property(retain, nonatomic) NSString *customerId;
@property(retain, nonatomic) NSString *policyCode;
@property(retain, nonatomic) NSString *insurantName;
@property(retain, nonatomic) NSString *liabilityState;
@property(retain, nonatomic) NSString *noticeType;
@property(retain, nonatomic) NSString *paperNotice;
@property(retain, nonatomic) NSString *smsNotice;
@property(retain, nonatomic) NSString *emailNotice;
@property(retain, nonatomic) NSString *selfNotice;

//险种名称(红利选择方式变更)
//@property(retain, nonatomic)NSString *productAbbr;
//@property(retain, nonatomic)NSString *isBonus;
//@property(retain, nonatomic)NSString *bonusType;


@end

//
// TPLUniversalBOModel.h
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@protocol TPLUniversalBOModel   

@property(retain, nonatomic) NSString *applicantId;
@property(retain, nonatomic) NSString *productName;
@property(retain, nonatomic) NSString *accumAmount;
@property(retain, nonatomic) NSDate *pricingDate;
@property(retain, nonatomic) NSDate *publishDate;
@property(assign, nonatomic) NSString *dayRate;
@property(assign, nonatomic) NSString *annualRate;

@end

//新加BO功能点击的时候客户的三中方式
#import <Foundation/Foundation.h>

@protocol TPLCustomerInfoBO

@property(retain, nonatomic) NSString *customerId;//客户
@property(retain, nonatomic) NSString *partyNO;//CIF
@property(retain, nonatomic) NSString *realName;//客户姓名
@property(retain, nonatomic) NSString *gender;//性别
@property(retain, nonatomic) NSString *genderDesc;//客户性别描述
@property(assign, nonatomic) NSString *brithday;//生日
@property(assign, nonatomic) NSString *certiTypeCode;//证件类别
@property(assign, nonatomic) NSString *certiType;//证件类型描述
@property(assign, nonatomic) NSString *certiCode;//身份证号
@end
//
// ModelsListLoad
// Created by JModel2OCModel on Thu Apr 17 10:31:26 CST 2014
//

#import <Foundation/Foundation.h>

@interface NSObject (ModelsListLoad)

+ (void)loadModels;

@end

@implementation NSObject (ModelsListLoad)

+ (void)loadModels{
    
    //NSStringFromProtocol(@protocol(nsstring));
    
    NSStringFromProtocol(@protocol(ISUserExt));
    
	NSStringFromProtocol(@protocol(TPLAgentBOModel));
	NSStringFromProtocol(@protocol(TPLBasicBOModel));
	NSStringFromProtocol(@protocol(TPLErrorBOModel));
	NSStringFromProtocol(@protocol(TPLListBOModel));

	NSStringFromProtocol(@protocol(TPLMenuBOModel));
	NSStringFromProtocol(@protocol(TPLRoleBOModel));
	NSStringFromProtocol(@protocol(TPLUserBOModel));

	NSStringFromProtocol(@protocol(TPLBonusWayBOModel));
	NSStringFromProtocol(@protocol(TPLChangeReturnBOModel));
	NSStringFromProtocol(@protocol(TPLChargeFeeAddrBOModel));
	NSStringFromProtocol(@protocol(TPLCustomerBOModel));
	NSStringFromProtocol(@protocol(TPLDrawAccountBOModel));
	NSStringFromProtocol(@protocol(TPLInvestmentBOModel));
	NSStringFromProtocol(@protocol(TPLLoanAccountBOModel));
	NSStringFromProtocol(@protocol(TPLPolicyBOModel));
	NSStringFromProtocol(@protocol(TPLPreserveBOModel));
	NSStringFromProtocol(@protocol(TPLPreserveProgressBOModel));
	NSStringFromProtocol(@protocol(TPLSendWayBOModel));
	NSStringFromProtocol(@protocol(TPLUniversalBOModel));
    NSStringFromProtocol(@protocol(TPLCustomerInfoBO));
}

@end





