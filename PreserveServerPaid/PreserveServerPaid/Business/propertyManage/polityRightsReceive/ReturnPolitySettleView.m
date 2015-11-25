//
//  ReturnPolitySettleView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//退还保单结余款项
#import "ReturnPolitySettleView.h"
#import "OmnipotentAdditionalInvestView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.receive.QueryPolicyInterestCollectionServlet"
@implementation ReturnPolitySettleView
{
    UITableView             *tableV;
    NSMutableArray          *chooseArray;
    ReturnPolitySettleDetailView   *detailView;
    
}
+(ReturnPolitySettleView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"ReturnPolitySettleView" owner:nil options:nil] objectAtIndex:0];
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
            listBOModel=[remoteService queryRefundPolicyBalanceWithCustomerID:[dic objectForKey:@"customerId"]];
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
    [self custemTableViewFrame];
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
        cell=[[OmnipotentAdditionalInvestCell alloc] initWithFrame:CGRectMake(0, 0, 845, 35)];
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
    cell.polityNumL.text=[dic objectForKey:@"policyCode"];
    cell.nameL.text=[dic objectForKey:@"balanceFrem"];
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
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
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
    
    if (detailView) {
        [detailView removeFromSuperview];
    }
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"ReturnPolitySettleView" owner:nil options:nil] objectAtIndex:1];
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





#pragma mark ReturnPolitySettleDetailView


@implementation ReturnPolitySettleDetailView
{
    UITableView             *tableV;
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)requestPolityNum:(NSMutableArray *)array{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            listBOModel=[remoteService queryRefundPolicyBalanceDetailWithPolityArray:array];
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
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 50)];
    tableV.rowHeight=123;
    [self.baseView addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    NSMutableArray  *requestArray=[[NSMutableArray alloc] init];
    for (int i=0; i<self.array.count; i++) {
        [requestArray addObject:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
    }
    [self requestPolityNum:requestArray];
    [self custemTableViewFrame];
}
-(void)custemTableViewFrame{
    if (self.mArray.count<3) {
        tableV.frame=CGRectMake(0, 0, 712, self.mArray.count*123);
    }else{
        tableV.frame=CGRectMake(0, 0, 712, 123*3);
    }
    self.redView.frame=CGRectMake(0, tableV.frame.size.height+70, 712, self.redView.frame.size.height);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ReturnPolitySettleDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailcell"];
    if (!cell) {
        cell=[[ReturnPolitySettleDetailCell alloc] initWithFrame:CGRectMake(0, 0, 712, 123)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polityNumL.text=[dic objectForKey:@"policyCode"];
    cell.balanceFrem.text=[dic objectForKey:@"balanceFrem"];
    cell.bankAccount.text=[dic objectForKey:@"bankAccount"];
    cell.bankName.text=[dic objectForKey:@"bankName"];
    cell.accoOwnerName.text=[dic objectForKey:@"accoOwnerName"];
    cell.accountName.text=[dic objectForKey:@"accountName"];
    return cell;
}

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}

//确定变更
- (IBAction)okChooseBtn:(UIButton *)sender {
    ReturnPolitySettlePiWenView *view=[ReturnPolitySettlePiWenView awakeFromNib];
    [view sizeToFit];
    view.frame=CGRectMake(0, 0, 1024, 768);
    [[self superview] addSubview:view];
    
}



@end





#pragma mark  ReturnPolitySettleDetailCell


@implementation ReturnPolitySettleDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ReturnPolitySettleView" owner:nil options:nil] objectAtIndex:2];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end




#pragma mark  ReturnPolitySettlePiWenView

@implementation ReturnPolitySettlePiWenView
{
    BjcaInterfaceView *mypackage;//CA拍照
}
+(ReturnPolitySettlePiWenView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"ReturnPolitySettleView" owner:nil options:nil] objectAtIndex:3];
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)custemView{
//    self.rightView.frame=CGRectMake(0, 0, 763, 447);
//    [self.rightView setBackgroundColor:[UIColor whiteColor]];
    UITextView  *textV=[[UITextView alloc] initWithFrame:CGRectMake(18, 58, 727, 328)];
    textV.backgroundColor=[UIColor whiteColor] ;
    [self.rightView addSubview:textV];
    [textV setEditable:NO];
    [textV setText:@"       保单号：1546654156453213143\n\n             投保人（小丽）与原账户所有人（晓丽）不一致"];
    textV.layer.borderWidth=2;
//    textV.layer.backgroundColor=[[UIColor grayColor] CGColor];
    self.rightLabel.layer.borderWidth=2;
    self.rightLabel.layer.backgroundColor=[[UIColor grayColor] CGColor];
    
    self.rightLabel.frame=CGRectMake(18, textV.frame.origin.y+textV.frame.size.height-2, self.rightLabel.frame.size.width, self.rightLabel.frame.size.height);
}
- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag==10) {
        MessageTestView *view=[[MessageTestView alloc] init];
        view.frame=CGRectMake(0,0, 1024, 768);
        view.end=10;
        view.delegate=self;
        [[self superview] addSubview:view];
    }else{
        [self removeFromSuperview];
    }
}
#pragma  mark  messageTestViewDelegate

-(void)massageTest{
//    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    view.delegate=self;
//    view.end=10;
//    [self addSubview:view];
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
    [self addSubview:view];
}

@end
