//
//  ThreeViewController.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/23.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPictureView.h"
#import "MyPictureFiveView.h"
#import "SmartQueryView.h"
#import "LeaveView.h"
#import "LoanPayOffView.h"
#import "ShortTimeAppointmentEndView.h"
#import "SurvivalGoldReceiveTypeChangeView.h"
#import "InvestAccountChange.h"
#import "OmnipotentAdditionalInvestView.h"//万能追加投资
#import "OmnipotentInsuranceSomeReceiveView.h"//万能险部分领取
#import "ReceiveSurvivalGoldView.h"//领取生存金
#import "ReturnPolitySettleView.h"//退还保单结余款项
#import "HistoryChangeQueryView.h"//历史变更记录查询
#import "LoanAccountQueryView.h"//贷款账户查询
#import "BounsReceiveTypeChangeView.h"//红利领取方式变更
#import "InvestEndHolidayView.h"//投连结束保险费假期

@interface ThreeViewController : UIViewController<leaveDelegate,CameraFourDelegate,CameraFiveDelegate,SmartQueryDelegate>

@property (nonatomic,assign)int         typeViewInt;//用来显示哪个view的

@property (nonatomic,strong)NSString         *nameString;//用户名
@property (nonatomic,assign)int         typeInt;//用户类型
@property (nonatomic,assign)int         typeImage;//一级菜单

@property (nonatomic,strong)NSString         *titleString;//表头
@property (nonatomic,strong)NSString         *oneString;//二级标题
@property (nonatomic,strong)NSString         *threeString;//三级标题

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;


@property (weak, nonatomic) IBOutlet UIView *leftBackgroundView;

@property (weak, nonatomic) IBOutlet UIView *headImageV;//头像
@property (weak, nonatomic) IBOutlet UIButton *headImageBtn;//左上角男女
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//人名
@property (weak, nonatomic) IBOutlet UIImageView *loginTypeImageV;//登陆人类型
@property (weak, nonatomic) IBOutlet UIButton *typeImageV;//一级菜单：保全变更、资产管理、保全查询
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;//一级名字
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;//三级名字


@property (weak, nonatomic) IBOutlet UILabel *nowNameLabel;//当前客户的名字
@property (weak, nonatomic) IBOutlet UILabel *cardIDLabel;//身份证


@property (nonatomic,strong)UITextField     *polityNumberTF;

+(instancetype)sharedManager;

-(void)custemView;

//@property (strong,nonatomic)UIButton *bigTouView;//111111111
@property (strong,nonatomic)UIView *bigClearView;//111111111

- (IBAction)goBack:(UIButton *)sender;//返回

-(void)cameraFour;//拍摄四张的
-(void)cameraFive;//拍摄五张的

//生存金账户信息
-(void)survivaGoldQuery;
//家庭信息变更
-(void)familyChangeView;
//投连投资比例
-(void)proportionChangeView;
//永久失效
-(void)getYongJiuTongZhi;
//收费账号
- (void)getShouFeiZhangHao;
//投连追加
- (void)getTouLianZhuiJiaView;

//犹豫期退保
-(void)vacillateSurrenderView;

//新增盈账户
-(void)newAddAccountView;

//保单未按时交费
- (void)weiAnShiJiaoFeiChuLi;

//贷款清偿
-(void)loanPayOffView;

//短期险预约终止
-(void)shortTimeAppointmentEndView;

//生存金领取方式变更
-(void)survivalGoldReceiveTypeChangeView;

//投连投资账户转换
-(void)investAccountChange;

//万能追加投资
-(void)omnipotentAdditionalInvestView;

//万能险部分领取
-(void)omnipotentInsuranceSomeReceiveView;

//领取生存金
-(void)receiveSurvivalGoldView;

//退还保单结余款项
-(void)returnPolitySettleView;

//历史变更记录查询
-(void)historyChangeQueryView;

//贷款账户查询
-(void)loanAccountQueryView;

////

//领取投连账户价值
- (void)addTouLianZhanghuJiaZhi;

//客户手机邮箱变更
- (void)addShouJiYouXiangBianGeng;

//单位信息变更
- (void)addDanWeiXinXiBianGeng;

//保单年度报告发送方式变更
- (void)addBaoDanNianDuFangShiBianGeng;

// 转账成功通知书发送变更
- (void)addZhuanZhangChengGongTongZhiBianGeng;

//失效通知书发送方式变更
- (void)addShiXiaoTongZhiShuBianGeng;

//收费地址变更
- (void)addShouFeiDiZhiBianGengView;

//红利选择方式变更
-(void)addHongLiXuanZeFangShiBianGeng;

//结束保单自动垫缴
- (void)addJieShuBaoDanZiDongDianJiao;

//领取红利
- (void)addLingQuHongLiView;

//分红账户查询
-(void)addFenHongZhangHuQueryView;

//红利领取方式变更
-(void)bounsReceiveTypeChangeView;

//投连结束保险费假期
-(void)investEndHolidayView;

//投连/万能结算账户查询
-(void)addTouLianWanNengJieSuanChaXunView;


//年金领取方式变更
- (void)addNianJinLingQuFangShiBianGengView;

@end
