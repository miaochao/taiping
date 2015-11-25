//
//  ReceiveSurvivalGoldView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/13.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//领取生存金
#import "ReceiveSurvivalGoldView.h"
#import "ChargeView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.receive.QueryPolicyInterestCollectionServlet"
@implementation ReceiveSurvivalGoldView
{
    UITableView             *tableV;
    NSMutableArray          *chooseArray;
    ReceiveSurvivalGoldDetailView   *detailView;
}
+(ReceiveSurvivalGoldView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"ReceiveSurvivalGoldView" owner:nil options:nil] objectAtIndex:0];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService queryReceiveExistenceGoldWithCustomerID:[dic objectForKey:@"customerId"]];
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
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 35, 844, 50)];
    tableV.rowHeight=35;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    [self request];
    [self custemTableViewFrame];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<9) {
        tableV.frame=CGRectMake(50, 35, 844, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 35, 844, 35*9);
    }
    self.allChooseView.frame=CGRectMake(50, tableV.frame.origin.y+tableV.frame.size.height, 844, 35);
    self.okBtn.frame=CGRectMake(804, tableV.frame.origin.y+tableV.frame.size.height+10+35, 90, 35);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReceiveSurvivalGoldCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ReceiveSurvivalGoldCell alloc] initWithFrame:CGRectMake(0, 0, 844, 35)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.chooseBtn.tag=indexPath.row;
    [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    for (int i=0; i<chooseArray.count; i++) {
        if ([[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    [cell.chooseBtn addTarget:self action:@selector(oneChooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polciyCode.text=[dic objectForKey:@"policyCode"];
    cell.survivalInterest.text=[dic objectForKey:@"survivalInterest"];
    cell.endInterest.text=[dic objectForKey:@"endInterest"];
    cell.annuityInterest.text=[dic objectForKey:@"annuityInterest"];
    cell.terminalBonus.text=[dic objectForKey:@"terminalBonus"];
    cell.payingFee.text=[dic objectForKey:@"payingFee"];
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
//单选按钮
-(void)oneChooseBtnClick:(UIButton *)sender{
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
    
}



//全选按钮
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
    
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"ReceiveSurvivalGoldView" owner:nil options:nil] objectAtIndex:2];
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

#pragma mark  ReceiveSurvivalGoldCell

@implementation ReceiveSurvivalGoldCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ReceiveSurvivalGoldView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


#pragma mark  ReceiveSurvivalGoldDetailView

@implementation ReceiveSurvivalGoldDetailView
{
    ChargeView  *bankView;
    BjcaInterfaceView *mypackage;//CA拍照
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)custemView{
    bankView =[ChargeView awakeFromNib];
    bankView.frame=CGRectMake(0, 35, 712, 166);
    bankView.backgroundColor=[UIColor whiteColor];
    [bankView createBtn];
    [bankView recriveSurvivalGold];
    bankView.upOrdown=NO;
    [self.baseView addSubview:bankView];    
}

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}

//确定变更
- (IBAction)okChooseBtn:(UIButton *)sender {
    
    if ([bankView.bankTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属银行！"];
        return;
    }
    if ([bankView.acountTextField.text isEqualToString:@""])
    {
        [self alertView:@"请输入付费账号！"];
        return;
    }
    if ([bankView.organizationTextField.text isEqualToString:@""])
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
