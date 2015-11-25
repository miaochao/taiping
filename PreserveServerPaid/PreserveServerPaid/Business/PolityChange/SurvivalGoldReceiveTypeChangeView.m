//
//  SurvivalGoldReceiveTypeChangeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/12.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

//生存金领取方式变更

#import "SurvivalGoldReceiveTypeChangeView.h"
#import "ChargeView.h"
#import "PreserveServer-Prefix.pch"
#import "BjcaInterfaceView.h"
#import "ThreeViewController.h"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
#define DETAILURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.UpdateBonusWayServlet"
@implementation SurvivalGoldReceiveTypeChangeView
{
    UITableView         *tableV;
    NSMutableArray          *chooseArray;
    SurvivalGoldReceiveTypeChangeDetailView *detailView;
}
+(SurvivalGoldReceiveTypeChangeView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:0];
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
            
            listBOModel=[remoteService querySurvivalGoldCollectionMethodWithCustomerId:[dic objectForKey:@"customerId"] ];
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
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(50, 36, 844, 50)];
    tableV.rowHeight=36;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    
    [self request];

}
-(void)custemTableViewFrame{
    if (self.mArray.count<10) {
        tableV.frame=CGRectMake(50, 36, 844, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 36, 844, 36*9);
    }
    self.allChooseView.frame=CGRectMake(50, tableV.frame.origin.y+tableV.frame.size.height, 844, 35);
    self.okBtn.frame=CGRectMake(804, self.allChooseView.frame.origin.y+self.allChooseView.frame.size.height+10, 90, 35);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SurvivalGoldReceiveTypeChangeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SurvivalGoldReceiveTypeChangeCell alloc] initWithFrame:CGRectMake(0, 0, 844, 36)];
        //cell.selectionStyle=UITableViewCellSelectionStyleNone;
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
    cell.typeL.text=[dic objectForKey:@"authName"];
    cell.numberL.text=[dic objectForKey:@"bankAccount"];
    cell.bankL.text=[dic objectForKey:@"bankName"];
    cell.nameL.text=[dic objectForKey:@"assigneeName"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BOOL  choose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [chooseArray removeObjectAtIndex:i];
            choose=NO;
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
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
            [self.allChooseBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
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
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:2];
    detailView.mArray=chooseArray;
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



#pragma mark  SurvivalGoldReceiveTypeChangeCell

@implementation SurvivalGoldReceiveTypeChangeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


#pragma mark  SurvivalGoldReceiveTypeChangeDetailView

@implementation SurvivalGoldReceiveTypeChangeDetailView
{
    //UITableView     *tableV;
    BjcaInterfaceView *mypackage;//CA拍照

}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)custemView{
    self.chargeV =[ChargeView awakeFromNib];
    self.chargeV.frame=CGRectMake(0, 35, 712, 166);
    self.chargeV.upOrdown=NO;
    self.chargeV.type=1;
    [self.chargeV createBtn];
    [self.chargeV createLabel];
    [self.rightView addSubview:self.chargeV];
    
//    self.mArray=[[NSMutableArray alloc] init];
//    tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 712, 402)];
//    tableV.rowHeight=166;
//    [self.rightView addSubview:tableV];
//    [self.rightView sendSubviewToBack:tableV];
//    
//    tableV.delegate=self;
//    tableV.dataSource=self;
//    
//    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic];
//    NSDictionary *dic1=@{@"accountNumber":@"1001002",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic1];
//    NSDictionary *dic2=@{@"accountNumber":@"1001003",@"accountName":@"XXXX账户",@"money":@"1000"};
//    [self.mArray addObject:dic2];
}
//-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.mArray.count;
//}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return self.mArray.count;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    SurvivalGoldReceiveTypeChangeDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
//    if (!cell) {
//        cell=[[SurvivalGoldReceiveTypeChangeDetailCell alloc]initWithFrame:CGRectMake(0, 0, 712, 166)];
//        //cell.frame=CGRectMake(0, 0, 712, 166);
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
//    return cell;
//}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    NSDictionary *dic=[self.mArray objectAtIndex:section];
//    UILabel   *label=[[UILabel alloc] init];
//    label.text=[dic objectForKey:@"accountNumber"];
//    label.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
//    label.textColor=[UIColor whiteColor];
//    return label;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 35;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 0;
//}
//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}

//确定变更
- (IBAction)okChangeBtnClick:(UIButton *)sender {
    if ([self.chargeV.bankTextField.text isEqualToString:@"现金"])
    {
        
        MessageTestView *view=[[MessageTestView alloc] init];
        view.frame=CGRectMake(0,0, 1024, 768);
        view.delegate=self;
        [[self superview] addSubview:view];
    }
    else
    {
        
        if ([self.chargeV.bankTextField.text isEqualToString:@""])
        {
            [self alertView:@"请选择授权方式！"];
            return;
        }
        if ([self.chargeV.acountTextField.text isEqualToString:@""])
        {
            [self alertView:@"请输入授权账号！"];
            return;
        }
        if ([self.chargeV.organizationTextField.text isEqualToString:@""])
        {
            [self alertView:@"请选择账号所属机构！"];
            return;
        }
        
        if ([self.chargeV.typeTextF.text isEqualToString:@""])
        {
            [self alertView:@"请选择账号所属银行！"];
            return;
        }
        
        MessageTestView *view=[[MessageTestView alloc] init];
        view.frame=CGRectMake(0,0, 1024, 768);
        view.delegate=self;
        [[self superview] addSubview:view];
    }
    
    
}
//确定变更请求
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,DETAILURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            NSMutableArray *array=[[NSMutableArray alloc] init];
            for (int i=0; i<self.mArray.count; i++) {
                NSDictionary *dic=[self.mArray objectAtIndex:i];
                [array addObject: [dic objectForKey:@"policyCode"] ];
            }
            
            
            listBOModel=[remoteService updateSurvivalGoldCollectionMethodWithpolicyCode:array bizChannel:@"123" authDraw:self.chargeV.bankTextField.text bankCode:self.chargeV.typeTextF.text bankAccount:self.chargeV.acountTextField.text accountType:self.chargeV.typeTextField.text accoOwnerName:self.chargeV.nameTextField.text organId:self.chargeV.organizationTextField.text];
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



@implementation SurvivalGoldReceiveTypeChangeDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"SurvivalGoldReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
        _chargeV=[ChargeView awakeFromNib];
        _chargeV.frame=CGRectMake(0, 0, 712, 166);
        [_chargeV createBtn];
        [self addSubview:_chargeV];
    }
    return self;
}

@end
