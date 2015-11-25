//
//  InvestEndHolidayView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "InvestEndHolidayView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.QueryPolicyEffectivenessServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.UpdatePolicyEffectivenessServlet"
@implementation InvestEndHolidayView
{
    UITableView         *tableV;
    NSMutableArray          *chooseArray;
    InvestEndHolidayDetailView *detailView;
}
+(InvestEndHolidayView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:0];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryPutEndInsurancePremiumWithCustomerId:[dic objectForKey:@"customerId"]];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[listBOModel.objList objectAtIndex:i]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [tableV reloadData];
                
            }
            [self custemTableViewFrame];
            
        });
    });
}
-(void)custemView{
    self.mArray=[[NSMutableArray alloc] init];
    chooseArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(85, 36, 776, 0)];
    tableV.rowHeight=35;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    [self request];
//    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic];
//    NSDictionary *dic1=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic1];
//    NSDictionary *dic2=@{@"accountNumber":@"1001003",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic2];
//    
//    [self custemTableViewFrame];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<10) {
        tableV.frame=CGRectMake(85, 35, 776, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(85, 35, 776, 35*9);
    }
    self.allChooseView.frame=CGRectMake(85, tableV.frame.origin.y+tableV.frame.size.height, 776, 35);
    self.okBtn.frame=CGRectMake(771, self.allChooseView.frame.origin.y+self.allChooseView.frame.size.height+10, 90, 35);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestEndHolidayCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[InvestEndHolidayCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.chooseBtn.tag=indexPath.row;
    [cell.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    for (int i=0; i<chooseArray.count; i++) {
        if ([[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polityNumL.text=[dic objectForKey:@"policyCode"];
    cell.polityNameL.text=[dic objectForKey:@"productName"];
    cell.timeL.text=[dic objectForKey:@"holidayStartDate"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL  choose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [chooseArray removeObjectAtIndex:i];
            choose=NO;
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (choose) {
        //未选择，就添加
        [chooseArray addObject:[self.mArray objectAtIndex:indexPath.row]];
        if (chooseArray.count==self.mArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [tableV reloadData];
}
//单选
- (void)chooseBtnClick:(UIButton *)sender {
    
    BOOL  choose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.mArray objectAtIndex:sender.tag] objectForKey:@"policyCode"]]) {
            [chooseArray removeObjectAtIndex:i];
            choose=NO;
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
            break;
        }
        
    }
    if (choose) {
        //未选择，就添加
        [chooseArray addObject:[self.mArray objectAtIndex:sender.tag]];
        if (chooseArray.count==self.mArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [tableV reloadData];
    //NSLog(@"数组个数：n%d",chooseArray.count);
}

//全选
- (IBAction)allChooseBtnClick:(UIButton *)sender {
    if (chooseArray.count!=self.mArray.count) {
        //表示全选
        sender.tag=50;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [chooseArray removeAllObjects];
        for (NSDictionary *str in self.mArray) {
            [chooseArray addObject:str];
        }
        [tableV reloadData];
        return;
    }
    if (chooseArray.count==self.mArray.count) {
        //全部不选
        [chooseArray removeAllObjects];
        sender.tag=100;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [tableV reloadData];
    }
}
//确定按钮
- (IBAction)okBtnClick:(UIButton *)sender {
    if (chooseArray.count<1) {
        UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择保单后再进行操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    if (detailView) {
        [detailView removeFromSuperview];
    }
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:2];
    detailView.array=chooseArray;
    [detailView sizeToFit];
    detailView.tag=20000;
    detailView.frame=CGRectMake(1024, 64, 1024, 704);
    [[self superview] addSubview:detailView];
    [UIView animateWithDuration:1 animations:^{
        detailView.frame=CGRectMake(0, 64, 1024, 704);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


#pragma mark   InvestEndHolidayCell


@implementation InvestEndHolidayCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end



#pragma mark InvestEndHolidayDetailView

@implementation InvestEndHolidayDetailView
{
    UITableView     *tableV;
    
    BjcaInterfaceView *mypackage;//CA拍照
    //ChargeView  *bankView;
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSMutableArray *array=[[NSMutableArray alloc] init];
            for (int i=0; i<self.array.count; i++) {
                [array addObject:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
            }
            
            listBOModel=[remoteService queryPutEndInsurancePremiumDetailWithpolicyCodes:array];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[listBOModel.objList objectAtIndex:i]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                [tableV reloadData];
                
            }            
        });
    });
}
-(void)custemView{
    [self sendSubviewToBack:self.redDownView];
    self.chargV =[ChargeView awakeFromNib];
    self.chargV.frame=CGRectMake(0, self.redDownView.frame.origin.y-166, 712, 166);
    self.chargV.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [self.chargV createBtn];
    self.chargV.upOrdown=YES;
    [self.baseView addSubview:self.chargV];
    self.rightView.frame=CGRectMake(0, self.chargV.frame.origin.y-35, 712, 35);
    
    self.mArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 776, 350)];
    tableV.rowHeight=35;
    [self.baseView addSubview:tableV];
    [self.baseView sendSubviewToBack:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    [self request];
//    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic];
//    NSDictionary *dic1=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic1];
//    NSDictionary *dic2=@{@"accountNumber":@"1001003",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic2];
    
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[[self.mArray objectAtIndex:section] objectForKey:@"detailList"] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestEndHolidayDetailCellInCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellInCell"];
    if (!cell) {
        cell=[[InvestEndHolidayDetailCellInCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic=[[[self.mArray objectAtIndex:indexPath.section] objectForKey:@"detailList"] objectAtIndex:indexPath.row];
    cell.numberL.text=[dic objectForKey:@"internalId"];
    cell.nameL.text=[dic objectForKey:@"productName"];
    cell.timeL.text=[dic objectForKey:@"holidayStartDate"];
    cell.allL.text=[dic objectForKey:@"shouldFillAmount"];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor=[UIColor whiteColor];
    
    UILabel   *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    label.text=[[self.mArray objectAtIndex:section] objectForKey:@"policyCode"];
    label.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
    label.textColor=[UIColor whiteColor];
    [view addSubview:label];
    
    UILabel *lab1=[[UILabel alloc] initWithFrame:CGRectMake(0, 35, 121, 35)];
    lab1.textAlignment=NSTextAlignmentCenter;
    lab1.text=@"险种序号";
    [view addSubview:lab1];
    UILabel *lab2=[[UILabel alloc] initWithFrame:CGRectMake(122, 35, 294, 35)];
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.text=@"险种名称";
    [view addSubview:lab2];
    UILabel *lab3=[[UILabel alloc] initWithFrame:CGRectMake(417, 35, 155, 35)];
    lab3.textAlignment=NSTextAlignmentCenter;
    lab3.text=@"进入假期时间";
    [view addSubview:lab3];
    UILabel *lab4=[[UILabel alloc] initWithFrame:CGRectMake(573, 35, 139, 35)];
    lab4.textAlignment=NSTextAlignmentCenter;
    lab4.text=@"应补金额合计";
    [view addSubview:lab4];
    
    UILabel *ll=[[UILabel alloc] initWithFrame:CGRectMake(0, 69, 712, 1)];
    ll.backgroundColor=[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1];
    [view addSubview:ll];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

//下面的上下箭头
- (IBAction)upOrDownBtnClick:(UIButton *)sender {
    if (sender.tag==50) {
        //让箭头向上
        sender.tag=60;
        //self.redDownView.frame=CGRectMake(0, 535, 712, self.redDownView.frame.size.height);
        [sender setImage:[UIImage imageNamed:@"xlzhankai-dianji.png"] forState:UIControlStateNormal];
    }else{
        //让箭头向下
        sender.tag=50;
        //self.redDownView.frame=CGRectMake(0, 552, 712, self.redDownView.frame.size.height);
        [sender setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
    }
    ///bankView.frame=CGRectMake(0, self.redDownView.frame.origin.y-166, 712, 166);
    //self.rightView.frame=CGRectMake(0, bankView.frame.origin.y-35, 712, 35);
}
//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}
//确定变更
- (IBAction)okChangeBtnClick:(UIButton *)sender {
    [self changeRequest];
    if ([self.chargV.bankTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属银行！"];
        return;
    }
    if ([self.chargV.acountTextField.text isEqualToString:@""])
    {
        [self alertView:@"请输入收费账号！"];
        return;
    }
    if ([self.chargV.organizationTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属机构！"];
        return;
    }
    
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}
//确定变更请求
-(void)changeRequest{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            NSMutableArray *array=[[NSMutableArray alloc] init];
            for (int i=0; i<self.array.count; i++) {
                [array addObject:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
            }
            listBOModel=[remoteService putEndInsurancePremiumWithpolicyCodes:array bizChannel:@"123" flowNo:123 bankCode:self.chargV.bankTextField.text bankAccount:self.chargV.acountTextField.text accountType:self.chargV.typeTextField.text accoOwnername:self.chargV.nameTextField.text organId:self.chargV.organizationTextField.text ];
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([listBOModel.returnFlag  isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"变更失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                
            }
        });
        
    });
    
}

#pragma  mark  messageTestViewDelegate

-(void)massageTest{
    //    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
    //    view.delegate=self;
    //    [[self superview] addSubview:view];
    [mypackage reset];//先清空之前的数据
    [self startinterface];
}
//签名方法
- (void)startinterface{
    ThreeViewController *three=[ThreeViewController sharedManager];
    NSLog(@"startinterface")  ;
    signinfo info;
    // [self SetSignData:index];
    info= [self SetSignData:1 info:&info];
    //  NSLog(@"8888%@",info);
    NSString *strContextid=@"21";
    int CLS;
    @try
    {
        CLS=[strContextid intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    info.imgeInfo.Signrect=[UIScreen mainScreen].bounds;
    // info.geo=TRUE;
    bool res= [mypackage showInputDialog:CLS callBack:@"myPicture" signerInfo:info];
    if (res==TRUE) {
        [three.view addSubview:mypackage.view];
        
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"签名参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return;
        
    }
    
}
- (signinfo )SetSignData:(int)index info:(signinfo *)infodata{
    NSLog(@"SetSignData");
    
    signinfo info=*infodata;
    
    info.name=@"123565";//签名者名字
    info.IdNumber=@"13245678";//签名者证件号
    //info.cid=@"20";
    info.RuleType=@"2";
    info.Tid=@"12332";
    NSString *geoStr=@"true";
    if( [geoStr isEqualToString:@"true"])
    {
        info.geo=TRUE;
    }
    else
    {
        info.geo=FALSE;
        
    }
    info.kw=@"23232";
    info.kwPost=@"2";
    info.kwOffset=@"100";
    info.Left=@"11.01";
    info.Top=@"11.02" ;
    info.Right=@"40.00";
    info.Bottom=@"40.00";
    info.Pageno=@"1";
    info.imgeInfo.SignImageSize.height=260;
    info.imgeInfo.SignImageSize.width=300;
    return info;
}
#pragma mark 拍照之后、签名之后调用
- (void)getimage:(NSNotification *)noti{
    NSLog(@"family");
   	NSDictionary *info = [noti userInfo];
    UIImage *image=[info objectForKey:@"myimage"];
    
    
    
    NSData *data=UIImagePNGRepresentation(image);
    NSLog(@"大小%lu",(unsigned long)data.length);
    
}
-(void)dealloc{
    //    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
}
#pragma  mark  writeNameDelegate

-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
}


@end



#pragma mark InvestEndHolidayDetailCell

@implementation InvestEndHolidayDetailCell
{
    UITableView         *tableV;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
        [self custemView];
    }
    return self;
}
-(void)custemView{
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 70, 712, 105)];
    tableV.rowHeight=35;
    tableV.delegate=self;
    tableV.dataSource=self;
    [self addSubview:tableV];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestEndHolidayDetailCellInCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellInCell"];
    if (!cell) {
        cell=[[InvestEndHolidayDetailCellInCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}
@end



#pragma mark InvestEndHolidayDetailCellInCell


@implementation InvestEndHolidayDetailCellInCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestEndHolidayView" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}
@end