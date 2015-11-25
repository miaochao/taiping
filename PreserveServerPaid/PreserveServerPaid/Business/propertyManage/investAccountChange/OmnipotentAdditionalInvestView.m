//
//  OmnipotentAdditionalInvestView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/13.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//万能追加投资
#import "OmnipotentAdditionalInvestView.h"
#import "ChargeView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"
@implementation OmnipotentAdditionalInvestView
{
    UITableView             *tableV;
    NSMutableArray          *chooseArray;
    OmnipotentAdditionalInvestDetailView   *detailView;
}

+(OmnipotentAdditionalInvestView*)awakeFromNib{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:0];
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
            
            listBOModel=[remoteService queryInvestmentUniversalAdditionalInvestmentWithCustemerId:[dic objectForKey:@"customerId"] busiType:@"41" ];
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
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(85, 35, 776, 50)];
    tableV.rowHeight=35;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    [self request];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<9) {
        tableV.frame=CGRectMake(85, 35, 776, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(85, 35, 776, 35*9);
    }
    self.allChooseView.frame=CGRectMake(85, tableV.frame.origin.y+tableV.frame.size.height, 776, 35);
    self.okBtn.frame=CGRectMake(770, tableV.frame.origin.y+tableV.frame.size.height+10+35, 90, 35);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OmnipotentAdditionalInvestCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[OmnipotentAdditionalInvestCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    cell.polityNumL.text=[dic objectForKey:@"policyCode"];
    cell.nameL.text=[dic objectForKey:@"productName"];
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
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:2];
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



#pragma mark  OmnipotentAdditionalInvestCell

@implementation OmnipotentAdditionalInvestCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


#pragma mark  OmnipotentAdditionalInvestDetailView

@implementation OmnipotentAdditionalInvestDetailView
{
    UITableView     *tableV;
    ChargeView      *bankView;
    BjcaInterfaceView *mypackage;//CA拍照
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)request:(NSMutableArray *)code{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            listBOModel=[remoteService queryUniversalAdditionalInvestmentWithPolityArray:code];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[[listBOModel.objList objectAtIndex:i] objectForKey:@"UniversalPolicyList"]];
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
    bankView =[ChargeView awakeFromNib];
    bankView.frame=CGRectMake(0, self.redDownView.frame.origin.y-166, 712, 166);
    bankView.backgroundColor=[UIColor colorWithRed:244/255.0 green:244/255.0 blue:244/255.0 alpha:1];
    [bankView createBtn];
    bankView.upOrdown=YES;
    [self.baseView addSubview:bankView];
    self.rightView.frame=CGRectMake(0, bankView.frame.origin.y-70, 712, 35);

    self.mArray=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 712, 350)];
    tableV.rowHeight=84;
    [self.baseView addSubview:tableV];
    [self.baseView sendSubviewToBack:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    NSMutableArray  *requestArray=[[NSMutableArray alloc] init];
    
    for (int i=0; i<self.array.count; i++) {
        //[self request:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
        [requestArray addObject:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
    }
    [self request:requestArray];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mArray objectAtIndex:section] count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OmnipotentAdditionalInvestDetailCellInCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellInCell"];
    if (!cell) {
        cell=[[OmnipotentAdditionalInvestDetailCellInCell alloc] initWithFrame:CGRectMake(0, 0, 712, 84)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic=[[self.mArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.productName.text=[NSString stringWithFormat:@"险种名称：%@",[dic objectForKey:@"productName"]];
    cell.accountValue.text=[NSString stringWithFormat:@"险种名称：%@",[dic objectForKey:@"accountValue"]];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSDictionary *dic=[self.array objectAtIndex:section];
    UILabel   *label=[[UILabel alloc] init];
    label.text=[dic objectForKey:@"policyCode"];
    label.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
    label.textColor=[UIColor whiteColor];
    return label;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


//下面的上下箭头
- (IBAction)upOrDownBtnClick:(UIButton *)sender {
    if (sender.tag==50) {
        //让箭头向上
        sender.tag=60;
        self.redDownView.frame=CGRectMake(0, 557, 712, 78);
        [sender setImage:[UIImage imageNamed:@"xlzhankai-dianji.png"] forState:UIControlStateNormal];
        [[self.redDownView viewWithTag:33] setAlpha:1];
    }else{
        //让箭头向下
        sender.tag=50;
        self.redDownView.frame=CGRectMake(0, 579, 712, 78);
        [sender setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
        [[self.redDownView viewWithTag:33] setAlpha:0];
    }
    bankView.frame=CGRectMake(0, self.redDownView.frame.origin.y-166, 712, 166);
    self.rightView.frame=CGRectMake(0, bankView.frame.origin.y-70, 712, 35);
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
        [self alertView:@"请输入收费账号！"];
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


#pragma mark OmnipotentAdditionalInvestDetailCell

@implementation OmnipotentAdditionalInvestDetailCell
{
    UITableView         *tableV;
}
-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
        [self custemView];
    }
    return self;
}
-(void)custemView{
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 35, 712, 140)];
    tableV.rowHeight=84;
    tableV.delegate=self;
    tableV.dataSource=self;
    [self addSubview:tableV];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OmnipotentAdditionalInvestDetailCellInCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellInCell"];
    if (!cell) {
        cell=[[OmnipotentAdditionalInvestDetailCellInCell alloc] initWithFrame:CGRectMake(0, 0, 712, 84)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end



#pragma mark OmnipotentAdditionalInvestDetailCellInCell


@implementation OmnipotentAdditionalInvestDetailCellInCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"OmnipotentAdditionalInvestView" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}
@end
