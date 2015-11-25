//
//  BounsReceiveTypeChangeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//红利领取方式变更
#import "BounsReceiveTypeChangeView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"
#define DETAILURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.UpdateBonusWayServlet"
@implementation BounsReceiveTypeChangeView

{
    UITableView         *tableV;
    NSMutableArray          *chooseArray;
    BounsReceiveTypeChangeDetailView *detailView;
}
+(BounsReceiveTypeChangeView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"BounsReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:0];
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
            
            listBOModel=[remoteService queryBonusCollectionMethodWithCustmerId:[dic objectForKey:@"customerId"] ];
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
    tableV=[[UITableView alloc]initWithFrame:CGRectMake(50, 36, 844, 0)];
    tableV.rowHeight=35;
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    [self request];

}
-(void)custemTableViewFrame{
    if (self.mArray.count<10) {
        tableV.frame=CGRectMake(50, 35, 844, self.mArray.count*35);
    }else{
        tableV.frame=CGRectMake(50, 35, 844, 35*9);
    }
    self.allChooseView.frame=CGRectMake(50, tableV.frame.origin.y+tableV.frame.size.height, 844, 35);
    self.okBtn.frame=CGRectMake(804, self.allChooseView.frame.origin.y+self.allChooseView.frame.size.height+10, 90, 35);
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BounsReceiveTypeChangeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[BounsReceiveTypeChangeCell alloc] initWithFrame:CGRectMake(0, 0, 844, 36)];
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
    cell.payTypeL.text=[dic objectForKey:@"authName"];
    cell.moneyL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"accountNameL"] doubleValue]];
    cell.bankNumL.text=[dic objectForKey:@"bankCode"];
    cell.bankL.text=[dic objectForKey:@"bankName"];
    cell.accountNameL.text=[dic objectForKey:@"assigneeName"];
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
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"BounsReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:2];
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





@implementation BounsReceiveTypeChangeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"BounsReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end



#pragma mark  BounsReceiveTypeChangeDetailView

@implementation BounsReceiveTypeChangeDetailView
{
    UITableView         *tableV;
    
    BjcaInterfaceView *mypackage;//CA拍照
}
-(void)sizeToFit{
    [super sizeToFit];
    [self custemView];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}
-(void)custemView{
    
    self.cView=[ChargeView awakeFromNib];
    self.cView.frame=CGRectMake(0, 35, 712, 166);
    self.cView.upOrdown=NO;
    self.cView.type=1;
    [self.cView createBtn];
    [self.cView createLabel];
    [self.baseView addSubview:self.cView];
    
//    self.mArray=[[NSMutableArray alloc] init];
//    tableV=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 712, 0)];
//    tableV.rowHeight=202;
//    [self.baseView addSubview:tableV];
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
//    
//    [self custemTableViewFrame];
}
//-(void)custemTableViewFrame{
//    if (self.mArray.count<2) {
//        tableV.frame=CGRectMake(0, 0, 712, self.mArray.count*202);
//    }else{
//        tableV.frame=CGRectMake(0, 0, 712, 202*2);
//    }
//    
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return self.mArray.count;
//}
//-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    BounsReceiveTypeChangeDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
//    if (!cell) {
//        cell=[[BounsReceiveTypeChangeDetailCell alloc] initWithFrame:CGRectMake(0, 0, 712, 202)];
//        cell.selectionStyle=UITableViewCellSelectionStyleNone;
//    }
//    return cell;
//}

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    //self.alpha=0;
    [self removeFromSuperview];
}
//确定变更
- (IBAction)okChangeBtnClick:(UIButton *)sender {

    if ([self.cView.bankTextField.text isEqualToString:@"现金"])
    {
        
        MessageTestView *view=[[MessageTestView alloc] init];
        view.frame=CGRectMake(0,0, 1024, 768);
        view.delegate=self;
        [[self superview] addSubview:view];
    }
    else
    {
        
        if ([self.cView.bankTextField.text isEqualToString:@""])
        {
            [self alertView:@"请选择授权方式！"];
            return;
        }
        if ([self.cView.acountTextField.text isEqualToString:@""])
        {
            [self alertView:@"请输入授权账号！"];
            return;
        }
        if ([self.cView.organizationTextField.text isEqualToString:@""])
        {
            [self alertView:@"请选择账号所属机构！"];
            return;
        }
        
        if ([self.cView.typeTextF.text isEqualToString:@""])
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
            
            
            listBOModel=[remoteService updateBonusCollectionMethodWithpolicyCodes:array authDraw:self.cView.bankTextField.text authBankCode:self.cView.typeTextF.text authBankAccount:self.cView.acountTextField.text accountType:@"普通卡" accoName:self.cView.nameTextField.text  authCertiType:@"122332" authCertiCode:@"113555655" issueBankName:@"13131" organID:self.cView.organizationTextField.text bizChinnel:@"221233"];
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



#pragma mark  BounsReceiveTypeChangeDetailCell

@implementation BounsReceiveTypeChangeDetailCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"BounsReceiveTypeChangeView" owner:nil options:nil] objectAtIndex:3];
    if(self){
        [self setFrame:frame];
        _chargeView=[[[NSBundle mainBundle] loadNibNamed:@"ChargeView" owner:nil options:nil] objectAtIndex:0];
        _chargeView.frame=CGRectMake(0, 35, 712, 166);
        _chargeView.upOrdown=NO;
        [self addSubview:_chargeView];
        [_chargeView createBtn];
        [_chargeView bounsReceiveType];
    }
    return self;
}

@end
