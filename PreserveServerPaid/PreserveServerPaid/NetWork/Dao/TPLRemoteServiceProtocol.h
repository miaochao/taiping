//
//  TPLRemoteServiceProtocol.h
//  TPLAppBQPad
//
//  Created by cz on 4/11/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Models.h"


@protocol TPLRemoteServiceProtocol <NSObject>


//-(NSString*)requestString:(NSString *)string;

//移动接入端版本校验、接入端认证、接入端会话心跳
- (NSDictionary *)getLastVersionIdWithAppType:(NSString *)appType andIsIosApp:(NSString *)isIosApp andIsIosSevenOne:(NSString *)isIosSevenOne;
- (id<ISUserExt>)loginWithUserName:(NSString *)userName andPassword:(NSString *)password;//?
- (void)updateUserExtActiveTimeWithUserName:(NSString *)userName andHeartTime:(NSString *)heartTime andActiveTime:(NSString *)activeTime;
//time 格式：YYYY-MM-DD HH24:MI:SS
//移动接入端版本校验、接入端认证、接入端会话心跳结束

/*
//InternetService begin
- (NSDictionary *)returnCifWithMap:(NSDictionary *)map;
- (NSDictionary *)updateCustomerBasicInfoWithMap:(NSDictionary *)map;
- (NSDictionary *)updatePolicyBasicInfoWithMap:(NSDictionary *)map;
- (NSDictionary *)updateBonusSelectModeWithMap:(NSDictionary *)map;
- (NSDictionary *)updateNoticeWayWithMap:(NSDictionary *)map;
//InternetService end
 */


//-ok 分红账户查询
//QueryDrawAccount begin  
- (id<TPLListBOModel>)queryDrawAccOrSetPolicyWithAgentId:(NSString *)agentId andAccountType:(int)accountType andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;


- (id<TPLListBOModel>)queryDrawAccountWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

//红利选择方式变更
- (id<TPLListBOModel>)queryBonusWayWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;
//QueryDrawAccount end



//-ok
//QueryLoanAccount begin
- (id<TPLListBOModel>)queryLoanAccountWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode andStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;
//QueryLoanAccount end



//-ok
//QueryPreserve begin
- (id<TPLListBOModel>)queryPolicyWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;
- (id<TPLListBOModel>)queryPreserveWithWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andCustomerName:(NSString *)customerName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode andStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

- (id<TPLListBOModel>)queryPreserveProgressWithUserName:(NSString *)userName andStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

//收费地址变更查询接口
- (id<TPLListBOModel>)queryChargeLocationWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;

//客户手机邮箱变更
- (id<TPLBasicBOModel>)queryCustomerWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;
//保单年度报告变更
- (id<TPLListBOModel>)queryPolicyYearReportWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode andSendModel:(int)sendModel andCustomerName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;



- (id<TPLListBOModel>)queryTransferWinOfferWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode  andSendModel:(int)sendModel andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;
- (id<TPLListBOModel>)queryFailureOfferWithAgentId:(NSString *)agentId andPolicyCode:(NSString *)policyCode  andSendModel:(int)sendModel andRealName:(NSString *)realName andGender:(int)gender andBirthday:(NSDate *)birthday andAuthCertiCode:(NSString *)authCertiCode;;
//QueryPreserve end



//-ok投连、万能结算查询
//QuerySettleAccounts begin
- (id<TPLListBOModel>)querySettleAccountsWithPolicyCode:(NSString *)policyCode andProductCate:(NSString *)productCate;
//QuerySettleAccounts end


//红利选择方式变更接口
//UpdateBonusWay begin
- (id<TPLChangeReturnBOModel>)updateBonusWayWithBonusWayBO:(NSDictionary *)bonusWayBO andUserCate:(NSString *)userCate andUserName:(NSString *)userName andRealName:(NSString *)realName;
//UpdateBonusWay end




//UpdatePreserve begin
//收费地址变更 接口
- (id<TPLChangeReturnBOModel>)updateLocationWithPolicyCode:(NSString *)policyCode andAddressFee:(NSString *)addressFee andZipLink:(NSString *)zipLink andUserCate:(NSString *)userCate andUserName:(NSString *)userName andRealName:(NSString *)realName;

//家庭信息变更接口
- (id<TPLChangeReturnBOModel>)updateCustomerWithCustomerId:(NSString *)customerId andPolicyCode:(NSString *)policyCode andJobAddress:(NSString *)jobAddress andJobZip:(NSString *)jobZip andJobPhone:(NSString *)jobPhone andAddress:(NSString *)address andZip:(NSString *)zip andTell:(NSString *)tell andCeller:(NSString *)celler andEmail:(NSString *)email andUserCate:(NSString *)userCate andUserName:(NSString *)userName andRealName:(NSString *)realName;

//保单年度、转账成功，失效通知报告
- (id<TPLChangeReturnBOModel>)updatePolicyYearReportWithPolicyCode:(NSString *)policyCode andNotiveWay:(NSString *)noticeWay andNoticeType:(NSString *)noticeType andUserCate:(NSString *)userCate andUserName:(NSString *)userName andRealName:(NSString *)realName;
//UpdatePreserve end


//UserLogin begin
- (id<TPLErrorBOModel>)sendMessageByLoginWithUserName:(NSString *)userName andUserCate:(NSString *)userCate;
- (id<TPLUserBOModel>)checkUserSmsCodeWithUserName:(NSString *)userName andSmsCode:(NSString *)smsCode andUserCate:(NSString *)userCate;
//UserLogin end

//Sms begin//短信验证接口
- (id<TPLErrorBOModel>)sendChangeSmsCodeWithUserName:(NSString *)userName andCustomerId:(NSString *)customerId andMenuName:(NSString *)menuName;
- (id<TPLErrorBOModel>)checkChangeSmsCodeWithUserName:(NSString *)userName andCustomerId:(NSString *)customerId andSmsCode:(NSString *)smsCode;
//Sms end


//Agreement begin
- (id<TPLErrorBOModel>)approveWithUserCate:(NSString *)userCate andUserName:(NSString *)userName;
//Agreement end

//点击每个功能出现的输入客服信息
-(id<TPLListBOModel>)queryCustomerInfoWithPolicyCode:(NSString *)policyCode certiCode:(NSString *)certiCode customerName:(NSString *)customerName brithday:(NSString *)brithday gerder:(NSString *)gerder queryType:(NSString *)type;


//收费账号变更
-(id<TPLListBOModel>)queryChargeAccountWithCustomerId:(NSString *)userId;
//收费账号详情页变更
- (id<TPLChangeReturnBOModel>)updateChargeAccountWithPolicyCode:(NSString *)baoDanID addressFee:(NSString *)diZhi zipLink:(NSString *)youBian bankCode:(NSString *)yinhang bankAccount:(NSString *)zhanghao accoOwnername:(NSString *)name accountType:(NSString *)leiXing organId:(NSString *)zuZhi bizChannel:(NSString *)quDao ecsOperator:(NSString *)renYuan;//1.保单号 2.保单收费地址 3.收费邮编 4.所属银行 5.收费账号 6.账号所有人 7.账户类型 8.账户所属组织 9.保全渠道 10.外围保全操作人员 

//生存金账户信息
-(id<TPLListBOModel>)survivalGoldAccountInformationWith:(NSString *)str;
-(id<TPLListBOModel>)querySurvivalPolicyListWithpolityCode:(NSString *)polityCode;

//生存金领取方式
-(id<TPLListBOModel>)querySurvivalGoldCollectionMethodWithCustomerId:(NSString *)str;
//生存金领取方式，确定变更
-(id<TPLChangeReturnBOModel>)updateSurvivalGoldCollectionMethodWithpolicyCode:(NSMutableArray *)polityArray bizChannel:(NSString *)bizChannel authDraw:(NSString *)authDraw bankCode:(NSString *)bankCode bankAccount:(NSString *)bankAccount accountType:(NSString *)accountType accoOwnerName:(NSString *)accoOwnerName organId:(NSString *)organId;//顺序：保单号、保全渠道、授权方式、账户所属银行、付费账号、账号类型、账号所有人、账户所属组织

//投连投资账户转换
-(id<TPLListBOModel>)queryInvestmentAccountConversionWithCustomerId:(NSString *)str;
//投连投资账户转换详情
-(id<TPLListBOModel>)queryInvestmentAccountConversionDetailWithPolityCode:(NSString *)str;
//投连投资账户转换确定变更
-(id<TPLChangeReturnBOModel>)investmentAccountConversionWithpolicyCode:(NSString *)policyCode productId:(NSString *)productId array:(NSMutableArray *)array bizChannel:(NSString *)bizChannel;



//贷款清偿
-(id<TPLListBOModel>)queryLoanRepaymentWithPolityID:(NSString *)ID calcDate:(NSDate *)date;
//贷款清偿详情
-(id<TPLChangeReturnBOModel>)singleLoanRepaymentWithDic:(NSDictionary *)dic;

//红利领取方式变更
-(id<TPLListBOModel>)queryBonusCollectionMethodWithCustmerId:(NSString *)str;
//红利领取方式确定变更页面
-(id<TPLChangeReturnBOModel>)updateBonusCollectionMethodWithpolicyCodes:(NSMutableArray *)array authDraw:(NSString *)authDraw authBankCode:(NSString *)authBankCode authBankAccount:(NSString *)authBankAccount accountType:(NSString *)accountType accoName:(NSString *)accoName authCertiType:(NSString *)authCertiType authCertiCode:(NSString *)authCertiCode issueBankName:(NSString *)issueBankName organID:(NSString *)organID bizChinnel:(NSString *)bizChinnel;//保单号，支付方式、授权银行、授权账号、账户类型、账户所有人姓名、账户所有人证件类型、账户所有人证件号码、开户行名称、账号所属机构代码、保全渠道

//短期险预约终止
-(id<TPLListBOModel>)queryTerminationShortTermRiskWithCustmerId:(NSString *)str;
//短期险预约终止详情页
-(id<TPLListBOModel>)queryTerminationShortTermRiskDetailWithPolityArray:(NSMutableArray *)array;
//短期险预约终止确认变更
-(id<TPLChangeReturnBOModel>)terminationShortTermRiskWithbizChannel:(NSString *)bizChannel policyCode:(NSMutableArray *)policyCode itemList:(NSMutableArray *)itemList;
-(id<TPLChangeReturnBOModel>)terminationShortTermRiskWithbizChannel:(NSDictionary *)bizChannel;
-(id<TPLChangeReturnBOModel>)testInterfaceWithbizChanne:(NSString *)bizChannel;


//投连投资比例变更
-(id<TPLListBOModel>)queryInvestmentRatioWithCustmerId:(NSString *)str;
//投连投资比例变更详情页面
-(id<TPLListBOModel>)queryInvestmentRatioDetailWithpolicyCode:(NSString *)policyCode;
//投连投资比例确定变更
-(id<TPLChangeReturnBOModel>)updateInvestmentRatioWithpolicyCode:(NSString *)policyCode bizChannel:(NSString *)bizChannel productAccountList:(NSMutableArray *)list;//顺序：保单号、保单渠道、变更数组


//万能追加投资
-(id<TPLListBOModel>)queryInvestmentUniversalAdditionalInvestmentWithCustemerId:(NSString *)str busiType:(NSString *)type;//（41表示万能追加，3表示投连）
//万能追加投资详情页
-(id<TPLListBOModel>)queryUniversalAdditionalInvestmentWithPolityArray:(NSMutableArray *)array;


//永久失效通知
-(id<TPLListBOModel>)queryPermanentFailureNoticeWayWithCustomerId:(NSString *)cusID;

//永久失效详情页面
- (id<TPLChangeReturnBOModel>)updateNoticeWayWithPolicyCode:(NSString *)baoDanID noticeWay:(NSString *)fangShi noticeType:(NSString *)leiXing bizChannel:(NSString *)quDao ecsOperator:(NSString *)caoZuoYuan;

//保单未按时交费
-(id<TPLListBOModel>)queryOverdueApproachWithCustomerId:(NSString *)userId;
//未按时交费变更
//-(id<TPLChangeReturnBOModel>)updateOverdueApproachWithpolicyCode:(NSString *)baoDanID overdueManage:(NSString *)xuanZe bizChannel:(NSString *)quDao;//1.保单号 2.保费逾期未付的选择 3.保全渠道
-(id<TPLChangeReturnBOModel>)updateOverdueApproachWithChangeArray:(NSArray *)array;


//投连追加投资
-(id<TPLListBOModel>)queryInvestmentUniversalAdditionalInvestmentWithcustomerId:(NSString *)customStr busiType:(NSString *)busStr;

//投连追加投资详细页面
-(id<TPLListBOModel>)queryInvestmentAdditionalInvestmentWithpolicyCode:(NSMutableArray *)poliStr;

//投连结束保险费假期
-(id<TPLListBOModel>)queryPutEndInsurancePremiumWithCustomerId:(NSString *)customerID;
//投连结束保险费假期详情
-(id<TPLListBOModel>)queryPutEndInsurancePremiumDetailWithpolicyCodes:(NSMutableArray *)policyCodes;
//投连结束保险费假期确定变更
-(id<TPLChangeReturnBOModel>)putEndInsurancePremiumWithpolicyCodes:(NSMutableArray *)policyCode bizChannel:(NSString *)bizChannel flowNo:(int )flowNo bankCode:(NSString *)bankCode bankAccount:(NSString *)bankAccount accountType:(NSString *)accountType accoOwnername:(NSString *)accoOwnername organId:(NSString *)organId;//顺序：保单号、保单渠道、外网流水号、账号所属银行、付费账号、账号类型、账号所有人、账号所属组织

//新增盈账户
-(id<TPLListBOModel>)queryNewProfitsAccountWithCustomerCIF:(NSString *)cif;
//新增盈账户详情
-(id<TPLListBOModel>)queryNewProfitsAccountDetailWithPolityCode:(NSString *)code;
//新增盈账户确定变更
-(id<TPLChangeReturnBOModel>)newProfitsAccountWithpolicyCode:(NSString *)policyCode bizChannel:(NSString *)bizChannel internalId:(NSString *)internalId bankCode:(NSString *)bankCode bankAccount:(NSString *)bankAccount accountType:(NSString *)accountType accoOwnername:(NSString *)accoOwnername organId:(NSString *)organId firstPrem:(NSString *)firstPrem;//顺序：保单号、保单渠道、险种代码、账号所属银行、付费账号、账号类型、账号所有人、账号所属组织、首期保费


//犹豫期退保
-(id<TPLListBOModel>)queryHesitateSurrenderWithCustomerID:(NSString *)ID bizChannel:(NSString *)bizChannel;//一个客服id、一个保全渠道



//领取生存金
-(id<TPLListBOModel>)queryReceiveExistenceGoldWithCustomerID:(NSString *)ID;



//退还保单结算余款
-(id<TPLListBOModel>)queryRefundPolicyBalanceWithCustomerID:(NSString *)ID;
//退还保单结算余款详情
-(id<TPLListBOModel>)queryRefundPolicyBalanceDetailWithPolityArray:(NSMutableArray *)array;


//万能险部分领取
-(id<TPLListBOModel>)queryUniversalCoverageWithCustomerID:(NSString *)ID;
-(id<TPLListBOModel>)queryUniversalCoverageDetailWithArray:(NSMutableArray *)array;

//年金领取方式变更
-(id<TPLListBOModel>)queryAnnuityWayWithCustomerID:(NSString *)cusID;
//年金领取方式详情
-(id<TPLListBOModel>)queryAnnuityWayDetailWithPolityArray:(NSMutableArray *)array;//保单数组
//年金领取变更
//-(id<TPLChangeReturnBOModel>)updateAnnuityWayWithpolicyCode:(NSString *)baoDanID bizChannel:(NSString *)quDao list:(NSArray *)shuZu;//1.保单号 2.保全渠道 3.变更后数据

-(id<TPLChangeReturnBOModel>)updateAnnuityWayWithPolicyList:(NSArray *)shuZu;



//结束保单自动垫缴页面
-(id<TPLListBOModel>)queryEndPolicyAutomaticPadWithCustomerID:(NSString *)cusID;
//结束保单自动垫缴详情
-(id<TPLListBOModel>)queryEndPolicyAutomaticPadDetailWithPolityArray:(NSMutableArray *)array;

//领取红利页面
-(id<TPLListBOModel>)queryReceiveBonusWithCustomerID:(NSString *)cusID;
//领取红利页面详细
-(id<TPLListBOModel>)queryReceiveBonusDetailWithPolityArray:(NSMutableArray *)array;

//领取投连账户价值
-(id<TPLListBOModel>)queryReceiveInvestmentLinkedAccountValueWithcustomerId:(NSString *)cusId;
-(id<TPLListBOModel>)queryReceiveInvestmentLinkedAccountValueDetailWithpolicyCode:(NSMutableArray *)array;

@end
