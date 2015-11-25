//
//  ShortTimeAppointmentEndView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "ShortTimeAppointmentEndView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.QueryPolicyEffectivenessServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.UpdatePolicyEffectivenessServlet"
@implementation ShortTimeAppointmentEndView
{
    UITableView             *tableV;
    NSMutableArray          *chooseArray;
    ShortTimeAppointmentEndDetailView   *detailView;
    
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
            
            listBOModel=[remoteService queryTerminationShortTermRiskWithCustmerId:[dic objectForKey:@"customerId"]];
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
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(84, 35, 776, 50)];
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
    if (self.mArray.count<9) {
        tableV.frame=CGRectMake(84, 35, 776, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(84, 35, 776, 35*9);
    }
    self.allChooseView.frame=CGRectMake(84, tableV.frame.origin.y+tableV.frame.size.height, 776, 35);
    self.okBtn.frame=CGRectMake(770, tableV.frame.origin.y+tableV.frame.size.height+10+35, 90, 35);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShortTimeAppointmentEndCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[ShortTimeAppointmentEndCell alloc] initWithFrame:CGRectMake(0, 0, 845, 35)];
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
    cell.insuranceNameL.text=[dic objectForKey:@"productName"];
    cell.timeL.text=[dic objectForKey:@"paymentDate"];
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
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"ShortTimeAppointmentEndView" owner:nil options:nil] objectAtIndex:2];
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

#pragma mark  ShortTimeAppointmentEndCell

@implementation ShortTimeAppointmentEndCell


-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShortTimeAppointmentEndView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}
@end



#pragma mark  ShortTimeAppointmentEndDetailView

@implementation ShortTimeAppointmentEndDetailView
{
    UITableView             *tableV;
    NSMutableArray          *chooseArray;
    NSMutableArray          *allChooseA;

    BjcaInterfaceView *mypackage;//CA拍照
}

-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)requestPolityNum:(NSMutableArray *)array{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            listBOModel=[remoteService queryTerminationShortTermRiskDetailWithPolityArray:array];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.mArray addObject:[[listBOModel.objList objectAtIndex:i] objectForKey:@"ShortTermInternalList"]];
        }
        //[self.mArray addObject:listBOModel.objList];
        
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
    self.mArray=[[NSMutableArray alloc] init];
    chooseArray=[[NSMutableArray alloc] init];
    allChooseA=[[NSMutableArray alloc] init];
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 600)];
    [self.rightView addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=36;
    
    NSMutableArray  *RequestArray=[[NSMutableArray alloc] init];
    for (int i=0; i<self.array.count; i++) {
        [allChooseA addObject:@"0"];
        NSMutableArray  *array=[[NSMutableArray alloc] init];
        [chooseArray addObject:array];
        
        //[self requestPolityNum:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
        [RequestArray addObject:[[self.array objectAtIndex:i] objectForKey:@"policyCode"]];
    }
    [self requestPolityNum:RequestArray];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.mArray.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.mArray objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShortTimeAppointmentEndDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell=[[ShortTimeAppointmentEndDetailTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 36)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.chooseBtn.tag=(indexPath.section+1)*100+indexPath.row;
    [cell.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    
    NSArray *array=[self.mArray objectAtIndex:indexPath.section];
    for (int i=0; i<[[chooseArray objectAtIndex:indexPath.section] count]; i++)
    {
        if ([[[[chooseArray objectAtIndex:indexPath.section] objectAtIndex:i ] objectForKey:@"internalId"] isEqualToString:[[array objectAtIndex:indexPath.row] objectForKey:@"internalId"]])
        {
            [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    NSDictionary *dic=[array objectAtIndex:indexPath.row];
    cell.insuranceNumL.text=[dic objectForKey:@"internalId"];
    cell.insuranceNameL.text=[dic objectForKey:@"productName"];
    cell.insuranceTypeL.text=[dic objectForKey:@"liaStatusName"];
    cell.nextTimeL.text=[dic objectForKey:@"payDueDate"];
    cell.beginTimeL.text=[dic objectForKey:@"endDateBefore"];
    cell.endTimeL.text=[dic objectForKey:@"endDateAfter"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 73;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 36;
}
//区尾
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] init];
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(70, 0, 50, 36)];
    [view addSubview:label];
    label.text=@"全选";
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [view addSubview:btn];
    btn.frame=CGRectMake(0, 0, 50, 36);
    btn.tag = 1300+section+1;
    [btn addTarget:self action:@selector(quanBuXuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    NSString *str=[allChooseA objectAtIndex:section];
    if ([str isEqual:@"1"]) {
        //证明全选有
        [btn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
    }
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ShortTimeAppointmentEndDetailTableView *view=[[[NSBundle mainBundle] loadNibNamed:@"ShortTimeAppointmentEndView" owner:nil options:nil] objectAtIndex:3];
    view.polityCode.text=[[self.array objectAtIndex:section] objectForKey:@"policyCode"];
//    UIView *view=[[UIView alloc] init];
//    view.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255.0/255.0 alpha:1];
//    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 300, 36)];
//    NSString *str=[[self.array objectAtIndex:section] objectForKey:@"policyCode"];
//    label.text=[NSString stringWithFormat:@"保单号：%@",str];
//    label.textColor=[UIColor whiteColor];
//    label.backgroundColor=[UIColor clearColor];
//    [view addSubview:label];
    return view;
}
//区委的全选按钮
-(void)quanBuXuanBtnClick:(UIButton *)sender
{
    int num=sender.tag%1300-1;
    if ([[allChooseA objectAtIndex:num] isEqualToString:@"0"]) {
        //表示还未选择
        [[chooseArray objectAtIndex:num] removeAllObjects];
        for (int i=0; i<[[self.mArray objectAtIndex:num] count]; i++) {
            NSMutableArray *array=[self.mArray objectAtIndex:num];
            [[chooseArray objectAtIndex:num] addObject:[array objectAtIndex:i]];
        }
        [allChooseA replaceObjectAtIndex:num withObject:@"1"];
    }else{
        //证明已经是全选了
        [[chooseArray objectAtIndex:num] removeAllObjects];
        [allChooseA replaceObjectAtIndex:num withObject:@"0"];
        
    }
    [tableV reloadData];
    return;
}
//单选
- (void)chooseBtnClick:(UIButton *)sender {
    BOOL  isChoose=YES;
    int    section=sender.tag/100-1;//得到那个区
    for (int i=0;i<[[chooseArray objectAtIndex:section] count];i++) {
            NSString *str=[[[chooseArray objectAtIndex:section] objectAtIndex:i] objectForKey:@"internalId"];
        
            if ([str isEqualToString:[[[self.mArray objectAtIndex:section] objectAtIndex:sender.tag%100] objectForKey:@"internalId"]]) {
            [[chooseArray objectAtIndex:section] removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        
        [allChooseA replaceObjectAtIndex:section withObject:@"0"];
        
    }
    if (isChoose) {
        //未选择，就添加
        [[chooseArray objectAtIndex:section] addObject:[[self.mArray objectAtIndex:section] objectAtIndex:sender.tag%100]];
        if ([[chooseArray objectAtIndex:section] count]==[[self.mArray objectAtIndex:section] count]) {
            //说明选择玩了
            [allChooseA replaceObjectAtIndex:section withObject:@"1"];
            
        }
    }
    [tableV reloadData];
}

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}

//确定变更
- (IBAction)okChooseBtn:(UIButton *)sender {
    [self request];
    if (chooseArray.count<=0) {
        UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请选择后在操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
}
//确定变更请求
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            NSMutableArray *polityArray=[[NSMutableArray alloc] init];
            NSMutableArray *itemArray=[[NSMutableArray alloc] init];
            for (int i=0; i<self.array.count; i++) {
                NSDictionary *dic=[self.mArray objectAtIndex:i];
                [polityArray addObject: [dic objectForKey:@"policyCode"] ];
                [itemArray addObject: [dic objectForKey:@"itemId"] ];
            }
            NSDictionary *dic=@{@"bizChannel":@"13213",@"policyCode":polityArray,@"itemList":itemArray};
//            NSMutableDictionary *diction=[[NSMutableDictionary alloc] init];
//            [diction setObject:@"1322" forKey:@"bizChannel"];
//            [diction setObject:polityArray forKey:@"policyCode"];
//            [diction setObject:itemArray forKey:@"itemList"];
            listBOModel=[remoteService terminationShortTermRiskWithbizChannel:dic];
            //listBOModel=[remoteService testInterfaceWithbizChanne:@"122"];
            
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
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


#pragma mark  ShortTimeAppointmentEndDetailTableView

@implementation ShortTimeAppointmentEndDetailTableView
{
    UITableView         *tableV;
    NSMutableArray          *chooseArray;
    
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
}
-(void)custemView{
    if (tableV) {
        //如果已经创建过了。那就return
        return;
    }
    self.mArray=[[NSMutableArray alloc] init];
    chooseArray=[[NSMutableArray alloc] init];
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 36, 712, 50)];
    tableV.rowHeight=35;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
    [self.mArray addObject:dic];
    NSDictionary *dic1=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
    [self.mArray addObject:dic1];
    NSDictionary *dic2=@{@"accountNumber":@"1001003",@"accountName":@"XXXX账户",@"money":@"1000"};
    [self.mArray addObject:dic2];
    
    [self custemTableViewFrame];
    
}
-(void)custemTableViewFrame{
    if (self.mArray.count<4) {
        tableV.frame=CGRectMake(0, 36, 712, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(0, 36, 712, 36*3);
    }
    self.allChooseView.frame=CGRectMake(0, tableV.frame.origin.y+tableV.frame.size.height, 712, 35);
    self.downLabel.frame=CGRectMake(0, self.allChooseView.frame.origin.y+self.allChooseView.frame.size.height+1, 712, 207-self.allChooseView.frame.origin.y-self.allChooseView.frame.size.height-1);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShortTimeAppointmentEndDetailTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell) {
        cell=[[ShortTimeAppointmentEndDetailTableViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 36)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    cell.chooseBtn.tag=indexPath.row;
    [cell.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    for (int i=0; i<chooseArray.count; i++) {
            if ([[[chooseArray objectAtIndex:i] objectForKey:@"accountNumber"] isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"accountNumber"]]) {
                [cell.chooseBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
                break;
            }
        }
    return cell;
}
//单选
- (void)chooseBtnClick:(UIButton *)sender {
    
    BOOL  choose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"accountNumber"];
        if ([str isEqualToString:[[self.mArray objectAtIndex:sender.tag] objectForKey:@"accountNumber"]]) {
            [chooseArray removeObjectAtIndex:i];
            choose=NO;
            break;
        }
        [self.detailAllChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        
        
    }
    if (choose) {
        //未选择，就添加
        [chooseArray addObject:[self.mArray objectAtIndex:sender.tag]];
        if (chooseArray.count==self.mArray.count) {
            [self.detailAllChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [tableV reloadData];
    NSLog(@"数组个数：n%lu",(unsigned long)chooseArray.count);
}

//全选
- (IBAction)allChooseBtnClick:(UIButton *)sender {
    if (sender.tag==100) {
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
    if (sender.tag==50) {
        //全部不选
        [chooseArray removeAllObjects];
        sender.tag=100;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [tableV reloadData];
    }
}


@end


#pragma mark ShortTimeAppointmentEndDetailTableViewCell

@implementation ShortTimeAppointmentEndDetailTableViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ShortTimeAppointmentEndView" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end