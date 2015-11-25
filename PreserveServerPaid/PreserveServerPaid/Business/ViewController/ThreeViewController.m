//
//  ThreeViewController.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/23.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#import "LoginViewController.h"
#import "SurvivalGoldAccountQueryView.h"
#import "ChargeView.h"
#import "ProportionChangeView.h"
#import "FamilyChangeView.h"


#import "ShouFeiBianGengVIew.h"
#import "MainViewController.h"
#import "TongZhiBianGengView.h"
#import "BaoDanXiangQingView.h"
#import "ShouFeiXiangQingView.h"
#import "SmartQueryView.h"
#import "TouLianZhuiJiaView.h"
#import "TouLianZhuiJiaXiangQingView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "VacillateSurrenderView.h"
#import "NewAddAccountView.h"
#import "WeiAnShiJiaoFeiView.h"


#import "LingQuTouLianView.h"
#import "ShoujiYouxiangBianGengView.h"
#import "DanWeiXinXIBianGengView.h"
#import "BaoDanNianDuBaoGaoView.h"
#import "ShouFeiDiZhiBianGengView.h"
#import "HongLiXuanZeFangShiBianGengView.h"
#import "JieShuBaoDanZiDongDianJiao.h"
#import "LingQuHongLiView.h"
#import "FenHongZhangHuView.h"

#import "TouLianWanNengJieSuanChaXunView.h"
#import "NianJinLingQuFangShiBianGengView.h"
@interface ThreeViewController ()

@end

@implementation ThreeViewController
+(instancetype)sharedManager{
    static ThreeViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.oneLabel.textColor=[UIColor colorWithRed:0 green:107/255.0 blue:183/255.0 alpha:1];
    //取出客户的个人信息
    NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
    self.nowNameLabel.text=[NSString stringWithFormat:@"当前客户：%@",[dic objectForKey:@"realName"]];
    self.cardIDLabel.text=[NSString stringWithFormat:@"身份证：%@",[dic objectForKey:@"certiCode"]];
    
    self.threeLabel.textColor=[UIColor colorWithRed:0 green:78/255.0 blue:133/255.0 alpha:1];
    self.leftBackgroundView.backgroundColor=[UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1];
    self.polityNumberTF=[[UITextField alloc] initWithFrame:CGRectMake(668, 70, 306, 35)];
    [self.view addSubview: self.polityNumberTF];
    self.polityNumberTF.layer.borderWidth=1;
    self.polityNumberTF.borderStyle=UITextBorderStyleRoundedRect;
    self.polityNumberTF.placeholder=@"输入保单号";
    self.polityNumberTF.contentVerticalAlignment=UIControlContentHorizontalAlignmentCenter;
    
    //UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo.png"]];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 35, 35);
    [btn setImage:[UIImage imageNamed:@"sousuo.png"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    self.polityNumberTF.rightView=btn;
    self.polityNumberTF.rightViewMode=UITextFieldViewModeAlways;
    
    [self custemView];
}
-(void)custemView{
    self.nameLabel.text=self.nameString;
    switch (self.typeInt) {
        case 1:
            self.loginTypeImageV.image=[UIImage imageNamed:@"dailiren.png"];
            break;
        case 2:
            self.loginTypeImageV.image=[UIImage imageNamed:@"neiqing.png"];
            break;
        case 3:
            self.loginTypeImageV.image=[UIImage imageNamed:@"xushouzhuanyuan.png"];
            break;
    }
    switch (self.typeImage) {
        case 1:
            [self.typeImageV setImage:[UIImage imageNamed:@"bqbgsx dianji.png"] forState:UIControlStateNormal];
            break;
        case 2:
            [self.typeImageV setImage:[UIImage imageNamed:@"zicanguanli-dianji.png"] forState:UIControlStateNormal];
            break;
        case 3:
            [self.typeImageV setImage:[UIImage imageNamed:@"baoquan chaxun dianji.png"] forState:UIControlStateNormal];
            break;
    }

}
- (IBAction)headBtnClick:(UIButton *)sender {
    
    UIView *bigHiddenView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, 1024, 704)];
    bigHiddenView.backgroundColor=[UIColor clearColor];
   
    bigHiddenView.tag = 20000;
    [self.view addSubview:bigHiddenView];
    
//    _bigTouView = [[UIView alloc] initWithFrame:CGRectMake(80, 117, 944, 651)];
//    _bigTouView.backgroundColor = [UIColor grayColor];
//    _bigTouView.alpha = 0.5;
   
    //[self.view addSubview:_bigTouView];
    
    UIButton *bigTouBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    bigTouBtn.frame = CGRectMake(80, 53, 944, 651);
    bigTouBtn.backgroundColor = [UIColor grayColor];
    bigTouBtn.alpha = 0.5;
    [bigTouBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bigHiddenView addSubview:bigTouBtn];
    
//    UIButton *bigHiddenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    bigHiddenBtn.frame=CGRectMake(0, 64, 1024, 704);
//    bigHiddenBtn.backgroundColor=[UIColor clearColor];
//    bigHiddenBtn.tag=-100;
//    bigHiddenBtn.tag = 20000;
//    [self.view addSubview:bigHiddenBtn];
//    [bigHiddenBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *jianIV = [[UIImageView alloc] initWithFrame:CGRectMake(163, 53, 20, 20)];
    jianIV.image = [UIImage imageNamed:@"xialasanjiao weidianji"];
    [bigHiddenView addSubview:jianIV];
    
    SmartQueryView *smartV = [[SmartQueryView alloc] init];
    smartV.frame = CGRectMake(112, 66, 660, 252);
    smartV.delegate=self;
    [bigHiddenView addSubview:smartV];

}
-(void)buttonClick:(UIButton *)sender
{
    //[sender removeFromSuperview];
    [[sender superview] removeFromSuperview];
}

//点击搜索
-(void)btnClick:(UIButton *)sender{
//    ChargeView *view=[ChargeView awakeFromNib];
//    view.frame=CGRectMake(80, 400, 712, 166);
//    view.upOrdown=NO;
//    [view createBtn];
//    [self.view addSubview:view];
}
#pragma mark 返回
- (IBAction)goBack:(UIButton *)sender {
    
    [[self.view viewWithTag:10000] removeFromSuperview];
    [[self.view viewWithTag:20000] removeFromSuperview];
    [[self.view viewWithTag:30000] removeFromSuperview];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 点击头像退出
- (IBAction)headImageBtnClick:(UIButton *)sender {
    LeaveView *view=[LeaveView awakeFromNib];
    view.frame=CGRectMake(0, 64, 1024, 704);
    view.tag=30000;
    [view custemView:2];
    view.delegate=self;
    [self.view addSubview:view];
}

#pragma mark 切换客户身份delegate方法
-(void)smartQueryChangeCustomer{
    [[self.view viewWithTag:10000] removeFromSuperview];
    [self showFunctionView];
}

#pragma mark leaveDelegate

-(void)pushVC{
    LoginViewController *vc=[LoginViewController sharedManager];
    [self.navigationController popToViewController:vc animated:YES];
    MainViewController *VC=[MainViewController sharedManager];
    [VC.scrollV removeFromSuperview];
}

-(void)cameraFour{
    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
    bigPictureView.tag=20000;
    bigPictureView.delegate=self;
    [bigPictureView sizeToFit];
    [self.view addSubview:bigPictureView];
}
-(void)cameraFive{
    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
    bigPictureView.delegate=self;
    [bigPictureView sizeToFit];
    bigPictureView.tag=20000;
    [self.view addSubview:bigPictureView];
}
#pragma mark 拍照代理
-(void)camaraFourDelegateWay{
    [self showFunctionView];
}
-(void)camaraFiveDelegateWay{
    [self showFunctionView];
}
-(void)showFunctionView{
    if (self.typeViewInt==100) {
        [self familyChangeView];
        return;
    }
    if (self.typeViewInt==101) {
        [self addDanWeiXinXiBianGeng];
        return;
    }
    if (self.typeViewInt==102) {
        [self addShouJiYouXiangBianGeng];
        return;
    }
    if (self.typeViewInt==103) {
        [self addBaoDanNianDuFangShiBianGeng];
        return;
    }
    if (self.typeViewInt==104) {
        [self addZhuanZhangChengGongTongZhiBianGeng];
        return;
    }
    if (self.typeViewInt==105) {
        [self addShiXiaoTongZhiShuBianGeng];
        return;
    }
    if (self.typeViewInt==107) {
        [self addShouFeiDiZhiBianGengView];
        return;
    }
    if (self.typeViewInt==108) {
        [self getShouFeiZhangHao];
        return;
    }
    if (self.typeViewInt==106) {
        [self getYongJiuTongZhi];
        return;
    }
    if (self.typeViewInt==109) {
        [self addHongLiXuanZeFangShiBianGeng];
        return;
    }
    if (self.typeViewInt==110)
    {
        [self weiAnShiJiaoFeiChuLi];
        return;
    }
    if (self.typeViewInt==111)
    {
        //红利领取方式变更
        [self bounsReceiveTypeChangeView];
        return;
    }
    if (self.typeViewInt==112)
    {
        [self addNianJinLingQuFangShiBianGengView];
        return;
    }
    if (self.typeViewInt==113) {
        [self survivalGoldReceiveTypeChangeView];
        return;
    }
    if (self.typeViewInt==200) {
        [self loanPayOffView];
        return;
    }
    if (self.typeViewInt==201) {
        [self shortTimeAppointmentEndView];
        return;
    }
    if (self.typeViewInt==202) {
        [self addJieShuBaoDanZiDongDianJiao];
        return;
    }
    if (self.typeViewInt==203) {
        //投连结束保险费假期
        [self investEndHolidayView];
        return;
    }
    if (self.typeViewInt==204)
    {
        //犹豫期退保
        [self vacillateSurrenderView];
        return;
    }
    if (self.typeViewInt==205)
    {
        //投连投资账户转换
        [self investAccountChange];
        return;
    }
    if (self.typeViewInt==207) {
        [self getTouLianZhuiJiaView];
        return;
    }
    if (self.typeViewInt==206) {
        [self proportionChangeView];
        return;
    }
    if (self.typeViewInt==208) {
        //万能追加投资
        [self omnipotentAdditionalInvestView];
        return;
    }
    if (self.typeViewInt==209) {
        //万能险部分领取
        [self omnipotentInsuranceSomeReceiveView];
        return;
    }
    if (self.typeViewInt == 210)
    {
        [self addTouLianZhanghuJiaZhi];
    }
    if (self.typeViewInt==211) {
        [self newAddAccountView];
        return;
    }
    if (self.typeViewInt==212) {
        //领取生存金
        [self receiveSurvivalGoldView];
        return;
    }
    if (self.typeViewInt == 213)
    {
        [self addLingQuHongLiView];
        return;
    }
    if (self.typeViewInt==214) {
        //退还保单结余款项
        [self returnPolitySettleView];
        return;
    }
    if (self.typeViewInt==300) {
        //历史变更记录查询
        [self historyChangeQueryView];
        return;
    }
    if (self.typeViewInt==301) {
        [self addFenHongZhangHuQueryView];
        return;
    }
    if (self.typeViewInt==302) {
        [self addTouLianWanNengJieSuanChaXunView];
        return;
    }
    if (self.typeViewInt==303) {
        //贷款账户查询
        [self loanAccountQueryView];
        return;
    }
    if (self.typeViewInt==304) {
        [self survivaGoldQuery];
        return;
    }

}
//生存金账户信息
-(void)survivaGoldQuery{
    SurvivalGoldAccountQueryView *view=(SurvivalGoldAccountQueryView *)[SurvivalGoldAccountQueryView awakeFromNib];
    view.frame=CGRectMake(1024-944, 768-638, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view custemView];
    self.titleLabel.text=@"生存金账户信息";
    self.oneLabel.text=@"账户利益存金账户";
    self.threeLabel.text=@"生存金账户信息存金账户信息";
    
    //查询
    [self.typeImageV setImage:[UIImage imageNamed:@"baoquan chaxun dianji.png"] forState:UIControlStateNormal];
}
//家庭信息变更
-(void)familyChangeView{
    self.polityNumberTF.alpha=0;
    //家庭信息变更
    FamilyChangeView *view=[FamilyChangeView awakeFromNib];
    view.frame=CGRectMake(80, 768-638, 944, 638);
    [view sizeToFit];
    view.tag=10000;
    [self.view addSubview:view];
    self.titleLabel.text=@"家庭信息变更";
    self.oneLabel.text=@"个人联系信息变更";
    self.threeLabel.text=@"家庭信息变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [bigPictureView sizeToFit];
//    [self.view addSubview:bigPictureView];
    //保全变更
    [self.typeImageV setImage:[UIImage imageNamed:@"bqbgsx dianji.png"] forState:UIControlStateNormal];
}
//投连投资比例
-(void)proportionChangeView{
    NSString *str=@"ProportionChangeView";
    UIView *view=[[[NSBundle mainBundle] loadNibNamed:str owner:nil options:nil] objectAtIndex:0];
    //ProportionChangeView *view=[ProportionChangeView awakeFromNib];
    view.frame=CGRectMake(1024-944, 768-638, 944, 638);
    [self.view addSubview:view];
    [view sizeToFit];
    view.tag=10000;
    self.titleLabel.text=@"投连账户投资比例变更";
    self.oneLabel.text=@"投资账户变更";
    self.threeLabel.text=@"投连账户投资比例变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
    //资产管理
    [self.typeImageV setImage:[UIImage imageNamed:@"zicanguanli-dianji.png"] forState:UIControlStateNormal];
}

//永久失效
-(void)getYongJiuTongZhi
{
    TongZhiBianGengView *bigShouFeiView = (TongZhiBianGengView *)[TongZhiBianGengView awakeFromNib];
  
    bigShouFeiView.frame = CGRectMake(165, 130, 844, 638);
    [self.view addSubview:bigShouFeiView];
    [bigShouFeiView sizeToFit];
    bigShouFeiView.tag=10000;
    self.titleLabel.text=@"永久失效通知书发送方式变更";
    self.oneLabel.text=@"通知方式变更";
    self.threeLabel.text=@"永久失效通知书发送方式变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
    [self.typeImageV setImage:[UIImage imageNamed:@"bqbgsx dianji.png"] forState:UIControlStateNormal];
}

//收费账号
- (void)getShouFeiZhangHao
{
    ShouFeiBianGengVIew *bigShouFeiView = (ShouFeiBianGengVIew *)[ShouFeiBianGengVIew awakeFromNib];
    bigShouFeiView.tag=10000;
    [bigShouFeiView sizeToFit];
    bigShouFeiView.frame = CGRectMake(130, 130, 844, 638);
    [self.view addSubview:bigShouFeiView];
    self.titleLabel.text=@"收费账号变更";
    self.oneLabel.text=@"收费信息变更";
    self.threeLabel.text=@"收费账号变更";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
//
//    [self.typeImageV setImage:[UIImage imageNamed:@"bqbgsx dianji.png"] forState:UIControlStateNormal];
}
//投连追加
- (void)getTouLianZhuiJiaView
{
    TouLianZhuiJiaView *bigTouLianV = (TouLianZhuiJiaView *)[TouLianZhuiJiaView awakeFromNib];
    bigTouLianV.tag=10000;
    [bigTouLianV sizeToFit];
    bigTouLianV.frame = CGRectMake(165, 136, 776, 632);
    [self.view addSubview:bigTouLianV];
    self.titleLabel.text=@"投连追加投资";
    self.oneLabel.text=@"投资账户变更";
    self.threeLabel.text=@"投连追加投资";
    

//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
    //资产管理
    [self.typeImageV setImage:[UIImage imageNamed:@"zicanguanli-dianji.png"] forState:UIControlStateNormal];
}

//犹豫期退保
-(void)vacillateSurrenderView{
    VacillateSurrenderView *view=[VacillateSurrenderView awakeFromNib];
    [view custemView];
    view.tag=10000;
    view.frame = CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    self.titleLabel.text=@"犹豫期退保";
    self.oneLabel.text=@"保单效力变更";
    self.threeLabel.text=@"犹豫期退保";

    //资产管理
    [self.typeImageV setImage:[UIImage imageNamed:@"zicanguanli-dianji.png"] forState:UIControlStateNormal];
}

//新增盈账户
-(void)newAddAccountView{
    //新增盈账户
    NewAddAccountView *view=[NewAddAccountView awakeFromNib];
    view.frame=CGRectMake(80, 768-638, 944, 638);
    [view custemView];
    view.tag=10000;
    [self.view addSubview:view];
    self.titleLabel.text=@"新增盈账户";
    self.oneLabel.text=@"投资账户变更";
    self.threeLabel.text=@"新增盈账户";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    //资产管理
    [self.typeImageV setImage:[UIImage imageNamed:@"zicanguanli-dianji.png"] forState:UIControlStateNormal];

}
//保单未按时交费
- (void)weiAnShiJiaoFeiChuLi
{
    WeiAnShiJiaoFeiView *weiAnShiView = (WeiAnShiJiaoFeiView *)[WeiAnShiJiaoFeiView awakeFromNib];
    weiAnShiView.frame = CGRectMake(165, 130, 844, 638);
    [weiAnShiView sizeToFit];
    [self.view addSubview:weiAnShiView];
    weiAnShiView.tag=10000;
    self.titleLabel.text=@"保单未按时交费处理结果选择";
    self.oneLabel.text=@"保单权益变更";
    self.threeLabel.text=@"保单未按时交费处理结果选择";
    
//        MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//        bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//        bigPictureView.tag=20000;
//        [self.view addSubview:bigPictureView];
    
    
}
//贷款清偿
-(void)loanPayOffView{
    LoanPayOffView *view=[[[NSBundle mainBundle] loadNibNamed:@"LoanPayOffView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"贷款清偿";
    self.oneLabel.text=@"保单贷款服务";
//    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//短期险预约终止
-(void)shortTimeAppointmentEndView{
    ShortTimeAppointmentEndView *view=[[[NSBundle mainBundle] loadNibNamed:@"ShortTimeAppointmentEndView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 844, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"短期险预约终止";
    self.oneLabel.text=@"保单效力变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}
//生存金领取方式变更
-(void)survivalGoldReceiveTypeChangeView{
    SurvivalGoldReceiveTypeChangeView *view=[[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"生存金领取方式变更";
    self.oneLabel.text=@"保单权益变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//投连投资账户转换
-(void)investAccountChange{
    InvestAccountChange *view=[[[NSBundle mainBundle] loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 844, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"投连投资账户转换";
    self.oneLabel.text=@"投连账户变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}
//万能追加投资
-(void)omnipotentAdditionalInvestView{
    OmnipotentAdditionalInvestView *view=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"万能追加投资";
    self.oneLabel.text=@"投连账户变更";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}
//万能险部分领取
-(void)omnipotentInsuranceSomeReceiveView{
    OmnipotentInsuranceSomeReceiveView *view=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentInsuranceSomeReceiveView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"万能险部分领取";
    self.oneLabel.text=@"投连账户变更";
//    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
}
//领取生存金
-(void)receiveSurvivalGoldView{
    ReceiveSurvivalGoldView *view=[[[NSBundle mainBundle] loadNibNamed:@"ReceiveSurvivalGoldView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"领取生存金";
    self.oneLabel.text=@"保单权益领取";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}
//退还保单结余款项
-(void)returnPolitySettleView{
    ReturnPolitySettleView *view=[[[NSBundle mainBundle] loadNibNamed:@"ReturnPolitySettleView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 844, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"退还保单结余款项";
    self.oneLabel.text=@"保单权益领取";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}
//历史变更记录查询
-(void)historyChangeQueryView{
    HistoryChangeQueryView *view=[[[NSBundle mainBundle] loadNibNamed:@"HistoryChangeQueryView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 844, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"历史变更记录查询";
    self.oneLabel.text=@"保单历史变更记录查询";
}
//贷款账户查询
-(void)loanAccountQueryView{
    self.polityNumberTF.alpha=0;
    LoanAccountQueryView *view=[[[NSBundle mainBundle] loadNibNamed:@"LoanAccountQueryView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"贷款账户查询";
    self.oneLabel.text=@"账户利益查询";
}

//领取投连账户价值
- (void)addTouLianZhanghuJiaZhi
{
    // NSString *str = @"LingQuTouLianView";
    LingQuTouLianView *lingView = [LingQuTouLianView awakeFromNib];
    lingView.frame = CGRectMake(165, 136, 776, 632);
    [lingView sizeToFit];
    lingView.tag = 10000;
    [self.view addSubview:lingView];
    self.titleLabel.text=@"领取投连账户价值";
    self.oneLabel.text=@"投资账户变更";
    self.threeLabel.text=@"领取投连账户价值";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//客户手机邮箱变更
- (void)addShouJiYouXiangBianGeng
{
    ShoujiYouxiangBianGengView *shoujiView = [ShoujiYouxiangBianGengView awakeFromNib];
    shoujiView.frame = CGRectMake(165, 130, 776, 240);
    [shoujiView sizeToFit];
    [self.view addSubview:shoujiView];
    shoujiView.tag = 10000;
    self.titleLabel.text=@"联系手机及邮箱变更";
    self.oneLabel.text=@"个人联系信息变更";
    self.threeLabel.text=@"领取投连账户价值";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//单位信息变更
- (void)addDanWeiXinXiBianGeng
{
    DanWeiXinXIBianGengView *danWeiView = [DanWeiXinXIBianGengView awakeFromNib];
    danWeiView.frame = CGRectMake(165, 130, 776, 305);
    [danWeiView sizeToFit];
    [self.view addSubview:danWeiView];
    danWeiView.tag = 10000;
    self.titleLabel.text=@"单位信息变更";
    self.oneLabel.text=@"个人联系信息变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [bigPictureView sizeToFit];
//    [self.view addSubview:bigPictureView];
    
}

//保单年度报告发送方式变更
- (void)addBaoDanNianDuFangShiBianGeng
{
    BaoDanNianDuBaoGaoView *baoDanNianView = [BaoDanNianDuBaoGaoView awakeFromNib];
    baoDanNianView.frame = CGRectMake(165, 130, 776, 638);
    baoDanNianView.pageTag = 103;
    [baoDanNianView sizeToFit];
    
    [self.view addSubview:baoDanNianView];
    baoDanNianView.tag = 10000;
    self.titleLabel.text=@"保单年度报告发送方式变更";
    self.oneLabel.text=@"通知方式变更";
    self.threeLabel.text=@"保单年度报告发送方式变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
}

// 转账成功通知书发送变更
- (void)addZhuanZhangChengGongTongZhiBianGeng
{
    BaoDanNianDuBaoGaoView *baoDanNianView = [BaoDanNianDuBaoGaoView awakeFromNib];
    baoDanNianView.frame = CGRectMake(165, 130, 776, 638);
    [baoDanNianView sizeToFit];
    baoDanNianView.pageTag = 104;
    [self.view addSubview:baoDanNianView];
    baoDanNianView.tag = 10000;
    self.titleLabel.text=@"转账成功通知书发送方式变更";
    self.oneLabel.text=@"通知方式变更";
    self.threeLabel.text=@"转账成功通知书发送方式变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//失效通知书发送方式变更
- (void)addShiXiaoTongZhiShuBianGeng
{
    BaoDanNianDuBaoGaoView *baoDanNianView = [BaoDanNianDuBaoGaoView awakeFromNib];
    baoDanNianView.frame = CGRectMake(165, 130, 776, 638);
    [baoDanNianView sizeToFit];
    baoDanNianView.pageTag = 105;
    [self.view addSubview:baoDanNianView];
    baoDanNianView.tag = 10000;
    self.titleLabel.text=@"失效通知书发送方式变更";
    self.oneLabel.text=@"通知方式变更";
    self.threeLabel.text=@"失效通知书发送方式变更";
//    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//收费地址变更
- (void)addShouFeiDiZhiBianGengView
{
    ShouFeiDiZhiBianGengView *shouFeiBianView = [ShouFeiDiZhiBianGengView awakeFromNib];
    shouFeiBianView.frame = CGRectMake(165, 130, 776, 638);
    [shouFeiBianView sizeToFit];
    [self.view addSubview:shouFeiBianView];
    shouFeiBianView.tag = 10000;
    self.titleLabel.text=@"收费地址变更";
    self.oneLabel.text=@"收费信息变更";
    self.threeLabel.text=@"收费地址变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//红利选择方式变更
-(void)addHongLiXuanZeFangShiBianGeng
{
    HongLiXuanZeFangShiBianGengView *hongliView = [HongLiXuanZeFangShiBianGengView awakeFromNib];
    hongliView.frame = CGRectMake(165, 130, 776, 638);
    [hongliView sizeToFit];
    [self.view addSubview:hongliView];
    hongliView.tag = 10000;
    self.titleLabel.text=@"红利选择方式变更";
    self.oneLabel.text=@"保单权益变更";
    self.threeLabel.text=@"红利选择方式变更";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
}

//结束保单自动垫缴
- (void)addJieShuBaoDanZiDongDianJiao
{
    JieShuBaoDanZiDongDianJiao *dianView = [JieShuBaoDanZiDongDianJiao awakeFromNib];
    dianView.frame = CGRectMake(165, 130, 776, 638);
    [dianView sizeToFit];
    [self.view addSubview:dianView];
    dianView.tag = 10000;
    self.titleLabel.text=@"结束保单自动垫缴";
    self.oneLabel.text=@"保单效力变更";
    self.threeLabel.text=@"结束保单自动垫缴";
    
//    MyPictureView *bigPictureView =(MyPictureView *)[MyPictureView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
}

//领取红利
- (void)addLingQuHongLiView
{
    LingQuHongLiView *dianView = [LingQuHongLiView awakeFromNib];
    dianView.frame = CGRectMake(165, 130, 776, 638);
    [dianView sizeToFit];
    [self.view addSubview:dianView];
    dianView.tag = 10000;
    self.titleLabel.text=@"领取红利";
    self.oneLabel.text=@"保单权益变更";
    self.threeLabel.text=@"领取红利";
    
//    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
//    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
//    bigPictureView.tag=20000;
//    [self.view addSubview:bigPictureView];
    
    
}

//分红账户查询
-(void)addFenHongZhangHuQueryView
{
    FenHongZhangHuView *dianView = [FenHongZhangHuView awakeFromNib];
    dianView.frame = CGRectMake(130, 130, 844, 638);
    [dianView sizeToFit];
    [self.view addSubview:dianView];
    dianView.tag = 10000;
    self.titleLabel.text=@"分红账户查询";
    self.oneLabel.text=@"账户利益查询";
    self.threeLabel.text=@"分红账户查询";
}

//红利领取方式变更
-(void)bounsReceiveTypeChangeView{
    BounsReceiveTypeChangeView *view=[[[NSBundle mainBundle] loadNibNamed:@"BounsReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"红利领取方式变更";
    self.oneLabel.text=@"保单权益变更";
    
}
//投连结束保险费假期
-(void)investEndHolidayView{
    InvestEndHolidayView *view=[[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:0];
    view.frame=CGRectMake(80, 130, 944, 638);
    [self.view addSubview:view];
    view.tag=10000;
    [view sizeToFit];
    self.titleLabel.text=@"投连结束保险费假期";
    self.oneLabel.text=@"保单效力变更";
}

//投连/万能结算账户查询
-(void)addTouLianWanNengJieSuanChaXunView
{
    TouLianWanNengJieSuanChaXunView *dianView = [TouLianWanNengJieSuanChaXunView awakeFromNib];
    dianView.frame = CGRectMake(130, 130, 844, 638);
    [dianView sizeToFit];
    [self.view addSubview:dianView];
    dianView.tag = 10000;
    self.titleLabel.text=@"投连/万能结算账户查询";
    self.oneLabel.text=@"账户利益查询";
    self.threeLabel.text=@"投连/万能结算账户查询";
    
}

//年金领取方式变更
- (void)addNianJinLingQuFangShiBianGengView
{
    
    NianJinLingQuFangShiBianGengView *dianView = [NianJinLingQuFangShiBianGengView awakeFromNib];
    dianView.frame = CGRectMake(165, 130, 776, 638);
    [dianView sizeToFit];
    [self.view addSubview:dianView];
    dianView.tag = 10000;
    self.titleLabel.text=@"年金领取方式变更";
    self.oneLabel.text=@"保单权益变更";
    self.threeLabel.text=@"年金领取方式变更";
    
    //    MyPictureFiveView *bigPictureView =(MyPictureFiveView *)[MyPictureFiveView awakeFromNib];
    //    bigPictureView.frame=CGRectMake(80, 64, 943, 704);
    //    bigPictureView.tag=20000;
    //    [self.view addSubview:bigPictureView];
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
