//
//  InvestAccountChange.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/12.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//投连投资账户转换
#import "InvestAccountChange.h"
#import "ChargeViewCell.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.UpdateInvestmentAccountServlet"
@implementation InvestAccountChange
{
    UITableView         *tableV;
    InvestAccountChangeDetailView   *detailView;
}

+(InvestAccountChange*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:0];
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
            
            listBOModel=[remoteService queryInvestmentAccountConversionWithCustomerId:[dic objectForKey:@"customerId"] ];
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
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(50, 35, 845, 50)];
    [self addSubview:tableV];
    
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=50;
    [self request];
//    NSDictionary *dic=@{@"number":@"15300990549000",@"name":@"第一主险"};
//    [self.mArray addObject:dic];
//    NSDictionary *dic1=@{@"number":@"18398080985003",@"name":@"第一主险"};
//    [self.mArray addObject:dic1];
//    NSDictionary *dic2=@{@"number":@"15308573878799",@"name":@"第一主险"};
//    [self.mArray addObject:dic2];
   
}
-(void)custemTableViewFrame{
    if (self.mArray.count>9) {
        tableV.frame=CGRectMake(50, 35, 845, 9*50);
    }else{
        tableV.frame=CGRectMake(50, 35, 845, self.mArray.count*50);
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.mArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    InvestAccountChangeCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    
    if (!cell) {
        cell=[[InvestAccountChangeCell alloc] initWithFrame:CGRectMake(0, 0, 845, 35)];
    }
    cell.numberL.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    NSDictionary    *dic=[self.mArray objectAtIndex:indexPath.row];
    cell.polityNumL.text=[dic objectForKey:@"policyCode"];
    cell.nameL.text=[dic objectForKey:@"productName"];
    cell.stableAccountNameL.text=[dic objectForKey:@"averageAcount"];
    cell.stableAccountNumL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"averageAmount"] doubleValue]];
    
    cell.upAccountNameL.text=[dic objectForKey:@"powerAcount"];
    cell.upAccountNumL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"powerAmount"] doubleValue]];
    
    cell.radicalAccountNameL.text=[dic objectForKey:@"radicalAcount"];
    cell.radicalAccountNumL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"radicalAmount"] doubleValue]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(detailView){
        [detailView removeFromSuperview];
    }
    detailView=[[[NSBundle mainBundle] loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:2];
    detailView.tag=20000;
    detailView.dic=[self.mArray objectAtIndex:indexPath.row];
    detailView.polityStr=[[self.mArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"];
    [detailView sizeToFit];
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


#pragma mark  InvestAccountChangeCell

@implementation InvestAccountChangeCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


#pragma mark  InvestAccountChangeDetailView

@implementation InvestAccountChangeDetailView
{
    UITableView     *upTableV;
    UITableView     *downTableV;
    NSMutableArray  *downArray;
    
    NSMutableArray  *smallArray;//用来存btn数据
    UIView          *chooseView;
    UITableView     *smallTableV;//chooseView上对应的
    
    BjcaInterfaceView *mypackage;//CA拍照
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
            listBOModel=[remoteService queryInvestmentAccountConversionDetailWithPolityCode:self.polityStr ];
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
                [upTableV reloadData];
                
            }
            [self custemTableVFrame];
            
        });
        
    });
    
}
-(void)custemView{
    self.mArray=[[NSMutableArray alloc] init];
    downArray=[[NSMutableArray alloc] init];
    smallArray=[[NSMutableArray alloc] init];
    self.numberTextF.delegate=self;
    self.polityCode.text=[NSString stringWithFormat:@"保单号：%@",self.polityStr];

    
    self.stableAccountBtn.layer.borderWidth=1;
    self.targetAccountBtn.layer.borderWidth=1;
    
    upTableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 35, 712, 107)];
    [self.baseView addSubview:upTableV];
    upTableV.tag=100;
    upTableV.rowHeight=107;
    upTableV.delegate=self;
    upTableV.dataSource=self;
    
    downTableV=[[UITableView alloc] initWithFrame:CGRectMake(0, self.upView.frame.origin.y+self.upView.frame.size.height+1 , 712, 0)];
    [self.baseView addSubview:downTableV];
    downTableV.tag=200;
    downTableV.rowHeight=35;
    downTableV.delegate=self;
    downTableV.dataSource=self;
    
    [self request];
}
-(void)custemTableVFrame{
//    if (self.mArray.count<4) {
//        upTableV.frame=CGRectMake(0, 107, 712, self.mArray.count*35);
//    }else{
//        upTableV.frame=CGRectMake(0, 107, 712, 3*35);
//    }
    self.upLabel.frame=CGRectMake(0, upTableV.frame.origin.y+upTableV.frame.size.height+1, 712, 15);
    self.upView.frame=CGRectMake(0, upTableV.frame.origin.y+upTableV.frame.size.height+17, 712, self.upView.frame.size.height);
    if (downArray.count<4) {
        downTableV.frame=CGRectMake(0,self.upView.frame.origin.y+self.upView.frame.size.height+1, 712, downArray.count*35);
    }else{
        downTableV.frame=CGRectMake(0, self.upView.frame.origin.y+self.upView.frame.size.height+1, 712, 3*35);
    }
}
//创建选择账户对应的view
-(void)createChooseView{
    chooseView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 77)];
    [self.upView addSubview:chooseView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 18)];
    [chooseView addSubview:label];
    label.text=@"请选择账户";
    label.textAlignment=UITextAlignmentCenter;
    label.backgroundColor=[UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
    
    smallTableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 18, 160, 54)];
    [chooseView addSubview:smallTableV];
    smallTableV.tag=300;
    smallTableV.delegate=self;
    smallTableV.dataSource=self;
    smallTableV.rowHeight=18;
    [smallTableV registerNib:[UINib nibWithNibName:@"ChargeViewCell" bundle:nil] forCellReuseIdentifier:@"chargeCell"];
}
#pragma mark tableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag==100) {
        return self.mArray.count;
    }
    if (tableView.tag==200) {
        return downArray.count;
    }
    return smallArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag==100) {
        InvestAccountChangeDetailUpCell *cell=[tableView dequeueReusableCellWithIdentifier:@"upCell"];
        if (!cell) {
            cell=[[InvestAccountChangeDetailUpCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
        }
        
        NSDictionary *dic=[self.mArray objectAtIndex:indexPath.row];
        cell.accountNameL.text=[dic objectForKey:@"fundName"];
        cell.accountCodeL.text=[dic objectForKey:@"accountCode"];
        cell.numberL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"accumUnits"] doubleValue]];
        cell.sellNumL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"applyUnits"] doubleValue]];
        cell.overNumL.text=[NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"outUnits"] doubleValue]];
        cell.productName.text=[NSString stringWithFormat:@"    险种名称：%@",[dic objectForKey:@"productName"]];
        cell.productType.text=[NSString stringWithFormat:@"险种状态：%@",[dic objectForKey:@"productStatus"]];
        
        return cell;
    }else if (tableView.tag==200){
        InvestAccountChangeDetailDownCell *cell=[tableView dequeueReusableCellWithIdentifier:@"downCell"];
        if (!cell) {
            cell=[[InvestAccountChangeDetailDownCell alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
        }
        NSDictionary *dic=[downArray objectAtIndex:indexPath.row];
        cell.basicAccountL.text=[dic objectForKey:@"basicAccountL"];
        cell.targetAccountL.text=[dic objectForKey:@"targetAccountL"];
        cell.numberL.text=[dic objectForKey:@"number"];
        return cell;
    }else{
        ChargeViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"chargeCell"];
//        if (!cell) {
//            cell=[[ChargeViewCell alloc] initWithFrame:CGRectMake(0, 0, 167, 18)];
//           
//        }
        cell.textColor=[UIColor blackColor];
        cell.backgroundColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
        cell.label.text=[smallArray objectAtIndex:indexPath.row];
        
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    chooseView.alpha=0;
    if (tableView.tag==300) {
        if (chooseView.frame.origin.x<150) {
            //表示左边的
            self.stableAccountL.text=[smallArray objectAtIndex:indexPath.row];
        }else{
            //表示右边
            self.targetAccountL.text=[smallArray objectAtIndex:indexPath.row];
        }
    }
}
#pragma mark textFiledDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
//选择账户点击
- (IBAction)chooseAccountBtnClick:(UIButton *)sender {
    if (!chooseView) {
        [self createChooseView];
    }
    chooseView.alpha=1;
    if (sender.tag==110) {
        //左边
        chooseView.frame=CGRectMake(self.stableAccountBtn.frame.origin.x, self.stableAccountBtn.frame.origin.y+self.stableAccountBtn.frame.size.height+1, 160, 77);
        [smallArray removeAllObjects];
        [smallArray addObject:@"平均稳健账户"];
        [smallArray addObject:@"XXXX账户"];
        [smallArray addObject:@"XXXX账户"];
    }else{
        //右边120
        chooseView.frame=CGRectMake(self.targetAccountBtn.frame.origin.x, self.stableAccountBtn.frame.origin.y+self.stableAccountBtn.frame.size.height+1, 160, 77);
        [smallArray removeAllObjects];
//        smallArray=@[@"平均稳健账户",@"激进账户",@"XXXX账户"];
        [smallArray addObject:@"平均稳健账户"];
        [smallArray addObject:@"激进账户"];
        [smallArray addObject:@"XXXX账户"];
    }
    [smallTableV reloadData];
}

//添加按钮
- (IBAction)addAccountBtnClick:(UIButton *)sender {
    if(self.numberTextF.text.length<1){
        UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请输入投资账户转换单位数！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    NSDictionary *dic=@{@"basicAccountL":self.stableAccountL.text,@"targetAccountL":self.targetAccountL.text,@"number":self.numberTextF.text};
    [downArray addObject:dic];
    [self custemTableVFrame];
    [downTableV reloadData];
}

//左边的按钮
- (IBAction)backBtnClick:(UIButton *)sender {
    [self removeFromSuperview];    
}
//确定变更
- (IBAction)okChooseBtn:(UIButton *)sender {
    [self changeRequest];
    if (downArray.count<=0) {
        UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请添加后在操作" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0,0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
}
//确定变更请求
-(void)changeRequest{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            
            listBOModel=[remoteService investmentAccountConversionWithpolicyCode:[self.dic objectForKey:@"policyCode"] productId:[self.dic objectForKey:@"productId"] array:downArray bizChannel:@"123323"];
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



#pragma mark InvestAccountChangeDetailUpCell

@implementation InvestAccountChangeDetailUpCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


#pragma mark InvestAccountChangeDetailDownCell

@implementation InvestAccountChangeDetailDownCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"InvestAccountChange" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end