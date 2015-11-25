//
//  TouLianWanNengJieSuanChaXunView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//投连/万能结算账户查询

#import "TouLianWanNengJieSuanChaXunView.h"
#import "PreserveServer-Prefix.pch"


#define TOULIANWANNENGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"

#define TOULIANWANNENGXIANGQING @"/servlet/hessian/com.cntaiping.intserv.custserv.settle.QuerySettleAccountServlet"


@implementation TouLianWanNengJieSuanChaXunView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


{
    UITableView *wanNengTabV;
    int             time;
    NSMutableArray *bArray;
    TouLianWanNengChaXunXiangQingView *xiangView;//万能
    TouLianWanNengChaXunTwoXiangQingView*twoXiangView;//投连
    NSString *productCate;//险种类别  0投连 1 万能
    
}

+(TouLianWanNengJieSuanChaXunView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:0];
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    time=10;
    self.tabArray = [[NSMutableArray alloc] init];
    bArray = [[NSMutableArray alloc] init];

    
    
    
    wanNengTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 844, 140)];
    [self addSubview:wanNengTabV];
    wanNengTabV.delegate = self;
    wanNengTabV.dataSource =self;
    wanNengTabV.rowHeight = 35;
    
    
    bArray=[NSMutableArray arrayWithArray:self.tabArray];
    wanNengTabV.frame=CGRectMake(0, 35, 844, 35*self.tabArray.count);
    if (35*self.tabArray.count>603)
    {
        wanNengTabV.frame=CGRectMake(0, 35, 844, 603);
    }
    [wanNengTabV reloadData];
    
   [self requestNumber];
}

//请求数据
- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,TOULIANWANNENGURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *birthday = [dateFormatter dateFromString:[dic objectForKey:@"brithday"]];
            int gender=0;//性别，0表示女
            if ([[dic objectForKey:@"gender"] isEqualToString:@"M"]) {
                gender=1;//表示男
            }
            
           
            //listBOModel=[remoteService querySettleAccountsWithPolicyCode:@"15031842745980" andProductCate:@"0"];
               listBOModel=[remoteService queryDrawAccOrSetPolicyWithAgentId:@"123" andAccountType:2 andPolicyCode:@"13213" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"] ];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
       
        [self.tabArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++) {
            id<TPLPolicyBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.tabArray addObject:dic];
        }
        bArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [wanNengTabV reloadData];
                
            }
            [self custemTableViewFrame];
        });
        
    });
    
}

-(void)custemTableViewFrame{
    if (35*self.tabArray.count>603)
    {
        wanNengTabV.frame=CGRectMake(0, 35, 844, 603);
    }else{
        wanNengTabV.frame=CGRectMake(0, 35, 844, 35*self.tabArray.count);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return self.tabArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouLianWanNengJieSuanChaXunViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[TouLianWanNengJieSuanChaXunViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    //id<TPLChargeFeeAddrBOModel>dic
    id<TPLPolicyBOModel>dic;
    if (time==10) {
        dic=[self.tabArray objectAtIndex:indexPath.row];
    }else{
        dic=[self.tabArray objectAtIndex:(self.tabArray.count-indexPath.row-1)];
    }

    cell.numberLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.polityNumLabel.text=dic.policyCode;
    cell.typeLabel.text=dic.liabilityStatus;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    cell.timeLabel.text=[dateFormatter stringFromDate:dic.validateDate];
    cell.insureLabel.text=dic.applicantName;
    cell.insuredLabel.text=dic.insurantName;
    cell.polityNameLabel.text=dic.productName;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    id<TPLPolicyBOModel>aDic = [self.tabArray objectAtIndex:indexPath.row];
    productCate = aDic.productCate;
    NSLog(@"  oooooo%@ ",productCate);
    
    if ([productCate isEqualToString:@"1"])
    {
        if (xiangView)
        {
            [xiangView removeFromSuperview];
        }
        
        xiangView = [[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:self options:nil] objectAtIndex:2];
        xiangView.alpha=1;
        
        xiangView.huoDeDic = [self.tabArray objectAtIndex:indexPath.row];
        [xiangView sizeToFit];
        xiangView.tag=20000;
        xiangView.frame = CGRectMake(1024, 64, 1024, 704);
        xiangView.backgroundColor = [UIColor clearColor];
        [[self superview] addSubview:xiangView];
        
        [UIView animateWithDuration:1 animations:^
         {
             
             xiangView.frame = CGRectMake(0, 64, 1024, 704);
             
         } completion:^(BOOL finished)
         {
             
         }];
    }
    else
    {
        if (twoXiangView)
        {
            [twoXiangView removeFromSuperview];
        }
        
        twoXiangView = [[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:self options:nil] objectAtIndex:4];
        twoXiangView.alpha=1;
        
        twoXiangView.huoDeDic = [self.tabArray objectAtIndex:indexPath.row];
        [twoXiangView sizeToFit];
        twoXiangView.tag=20000;
        twoXiangView.frame = CGRectMake(1024, 64, 1024, 704);
        twoXiangView.backgroundColor = [UIColor clearColor];
        [[self superview] addSubview:twoXiangView];
        
        [UIView animateWithDuration:1 animations:^
         {
             
             twoXiangView.frame = CGRectMake(0, 64, 1024, 704);
             
         } completion:^(BOOL finished)
         {
             
         }];
    
    }
    
}


//点击生效日期
- (IBAction)dateBtnClick:(UIButton *)sender {
    if (sender.tag==50) {
        sender.tag=40;
        [self.timeImageV setImage:[UIImage imageNamed:@"shengxu.png"]];
        time=20;
    }else{
        sender.tag=50;
        [self.timeImageV setImage:[UIImage imageNamed:@"jiangxu.png"]];
        time=10;
    }
    [wanNengTabV reloadData];
}
//责任状态
- (IBAction)stateBtnClick:(UIButton *)sender {
    //    NSMutableArray *array=@[@"有效",@"无效",@"无"];
    //    enumView *view=[[enumView alloc] initWithFrame:CGRectMake(386, 35, 72, 100) mArray:array tag:1];
    ////    view.backgroundColor=[UIColor greenColor];
    //    [self addSubview:view];
    sender.enabled=NO;
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(302, 35, 94, 100)];
    view.layer.borderWidth=0.5;
    view.backgroundColor=[UIColor grayColor];
    [self addSubview:view];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 94, 33);
    [view addSubview:btn];
    btn.tag=7100;
    [btn setTitle:@"有效" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blueColor]];
    [btn addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn1];
    btn1.frame=CGRectMake(0, 33, 94, 33);
    btn1.tag=7200;
    [btn1 setTitle:@"无效" forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor whiteColor]];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn2];
    btn2.frame=CGRectMake(0, 66, 94, 33);
    btn2.tag=7300;
    [btn2 setTitle:@"无" forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor whiteColor]];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(typeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//责任状态点击
-(void)typeBtnClick:(UIButton *)sender{
    self.typeBtn.enabled=YES;
    [self.tabArray removeAllObjects];
    if (sender.tag==7100) {
        //有效
        for (int i=0; i<bArray.count; i++) {
            id<TPLPolicyBOModel>dic=[bArray objectAtIndex:i];
            if ([dic.liabilityStatus isEqualToString:@"有效"]) {
                [self.tabArray addObject:dic];
            }
        }
    }
    if (sender.tag==7200) {
        //有效
        for (int i=0; i<bArray.count; i++) {
            id<TPLPolicyBOModel>dic=[bArray objectAtIndex:i];
            if ([dic.liabilityStatus isEqualToString:@"无效"]) {
                [self.tabArray addObject:dic];
            }
        }
    }
    if (sender.tag==7300) {
        self.tabArray=[NSMutableArray arrayWithArray:bArray];
    }
    
    wanNengTabV.frame=CGRectMake(0, 35, 844, 35*self.tabArray.count);
    if (35*self.tabArray.count>603) {
        wanNengTabV.frame=CGRectMake(0, 35, 844, 603);
    }
    [wanNengTabV reloadData];
    [[sender superview] removeFromSuperview];
}


@end



@implementation TouLianWanNengJieSuanChaXunViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end

@implementation TouLianWanNengChaXunXiangQingView

{
    UITableView *fenXiangTabV;
    NSString *productCate;
    
}


+(TouLianWanNengChaXunXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:2];
    
}

- (IBAction)yinCangBtnClick:(id)sender
{
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.xiangTabVarray = [[NSMutableArray alloc] init];
    fenXiangTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 712, 35) style:UITableViewStylePlain];
    [self.smallXiangView addSubview:fenXiangTabV];
    fenXiangTabV.rowHeight = 35;
    fenXiangTabV.delegate = self;
    fenXiangTabV.dataSource = self;
    
    [self requestDetailNumber];
}


-(void)requestDetailNumber{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,TOULIANWANNENGXIANGQING]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
       
            NSString *PolicyCode = self.huoDeDic.policyCode;
            productCate = self.huoDeDic.productCate;
//            NSLog(@" 898989p%@ ",PolicyCode);
//            NSLog(@" 898989cc%@ ",productCate);
            
             //ProductCate  0 投连  1 万能
            listBOModel=[remoteService querySettleAccountsWithPolicyCode:PolicyCode andProductCate:productCate];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally
        {
            
        }
        NSLog(@">>>mmmcc999>>>>>>>>>>%@",listBOModel.objList);
        [self.xiangTabVarray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            
              id<TPLUniversalBOModel>dic=[listBOModel.objList objectAtIndex:i];
              [self.xiangTabVarray addObject:dic];
            
        }
        NSLog(@"  >>>>mmm8888%@ ",self.xiangTabVarray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [fenXiangTabV reloadData];
                
            }
            [self custemTableViewFrame];
        });
        
    });
    
}


- (void)custemTableViewFrame
{
    if (self.xiangTabVarray.count >10)
    {
        fenXiangTabV.frame = CGRectMake(0, 70, 712, 360);
    }
    else
    {
        fenXiangTabV.frame = CGRectMake(0, 70, 712, 36*(self.xiangTabVarray.count));
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"  mmmmmm%lu ",(unsigned long)self.xiangTabVarray.count);
    return self.xiangTabVarray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouLianWanNengChaXunXiangQingViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[TouLianWanNengChaXunXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    }
    
//    if ([productCate isEqualToString:@"0"])
//    {
//       id<TPLInvestmentBOModel>dic = [self.xiangTabVarray objectAtIndex:indexPath.row];

       id<TPLUniversalBOModel>dic = [self.xiangTabVarray objectAtIndex:indexPath.row];
 
     cell.xianZhongLabel.text=dic.productName;
     cell.jiaZhiLabel.text=dic.accumAmount;
     NSDate *timeDate=dic.pricingDate ;//日期转化为字符串
     NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
     [timeFormat setDateFormat:@"yyyy-MM-dd"];
     NSString *zongShiJianString = [timeFormat stringFromDate:timeDate];
     cell.jieSuanRi.text=zongShiJianString;
    
    NSDate *timeDate1=dic.publishDate ;//日期转化为字符串
    NSDateFormatter *timeFormat1 = [[NSDateFormatter alloc]init];
    [timeFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString *zongShiJianString1 = [timeFormat stringFromDate:timeDate1];
    cell.jieSuanRi.text=zongShiJianString1;
    //annualRate 年利率 (服务器返回值包含年利率)
    cell.riLiLv.text = dic.dayRate;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}



@end

//万能  cell
@implementation TouLianWanNengChaXunXiangQingViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}



@end

//投连
@implementation TouLianWanNengChaXunTwoXiangQingView

{
    UITableView *twoXiangTabV;
    NSString *productCate;
    
}


+(TouLianWanNengChaXunTwoXiangQingView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:4];
}



- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.detailArray = [[NSMutableArray alloc] init];
    twoXiangTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, 712, 35) style:UITableViewStylePlain];
    [self.smallTwoView addSubview:twoXiangTabV];
    twoXiangTabV.rowHeight = 35;
    twoXiangTabV.delegate = self;
    twoXiangTabV.dataSource = self;
    
    [self requestDetailNumber];
}


-(void)requestDetailNumber{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,TOULIANWANNENGXIANGQING]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSString *PolicyCode = self.huoDeDic.policyCode;
            productCate = self.huoDeDic.productCate;
            NSLog(@" 898989p%@ ",PolicyCode);
            NSLog(@" 898989cc%@ ",productCate);
            
            //ProductCate  0 投连  1 万能
            listBOModel=[remoteService querySettleAccountsWithPolicyCode:PolicyCode andProductCate:productCate];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally
        {
            
        }
        NSLog(@">>>mmmcc999>>>>>>>>>>%@",listBOModel.objList);
        [self.detailArray removeAllObjects];
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            
            id<TPLUniversalBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.detailArray addObject:dic];
            
        }
        NSLog(@"  >>>>mmm8888%@ ",self.detailArray);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [twoXiangTabV reloadData];
                
            }
            [self custemTableViewFrame];
        });
    });
    
}
- (void)custemTableViewFrame
{
    if (self.detailArray.count >10)
    {
        twoXiangTabV.frame = CGRectMake(0, 70, 712, 360);
    }
    else
    {
        twoXiangTabV.frame = CGRectMake(0, 70, 712, 36*(self.detailArray.count));
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.detailArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TouLianWanNengChaXunTwoXiangQingViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
    if (!cell)
    {
        cell = [[TouLianWanNengChaXunTwoXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    }
    
    //    if ([productCate isEqualToString:@"0"])
    //    {
    //       id<TPLInvestmentBOModel>dic = [self.xiangTabVarray objectAtIndex:indexPath.row];
 
    
    id<TPLInvestmentBOModel>dic = [self.detailArray objectAtIndex:indexPath.row];
    
    cell.xianZhongLabel.text=dic.productName;
    cell.zhanghuLabel.text=dic.investAccountName;
    cell.danWeiShuLabel.text = dic.accumUnits;
    
    NSDate *timeDate1=dic.pricingDate ;//日期转化为字符串
    NSDateFormatter *timeFormat1 = [[NSDateFormatter alloc]init];
    [timeFormat1 setDateFormat:@"yyyy-MM-dd"];
    NSString *zongShiJianString1 = [timeFormat1 stringFromDate:timeDate1];
    cell.pingGuRi.text=zongShiJianString1;
    //annualRate 年利率 (服务器返回值包含年利率)
    cell.maiChuLabel.text = dic.fundSellPrice;
    cell.maiRuLabel.text = dic.fundPurcPrice;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (IBAction)yinCanBtnClick:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}



@end


@implementation TouLianWanNengChaXunTwoXiangQingViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"TouLianWanNengJieSuanChaXunView" owner:nil options:nil] objectAtIndex:5];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}



@end






