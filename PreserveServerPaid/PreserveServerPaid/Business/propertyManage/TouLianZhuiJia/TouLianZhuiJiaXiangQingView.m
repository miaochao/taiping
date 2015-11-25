//
//  TouLianZhuiJiaXiangQingView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/28.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "TouLianZhuiJiaXiangQingView.h"
#import "TouLianXiangQingViewCell.h"
#import "MessageTestView.h"
#import "ThreeViewController.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"

#define TOULIANXIAYIJI @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"

@implementation TouLianZhuiJiaXiangQingView

{
    BjcaInterfaceView *mypackage;//CA拍照

}


//+(instancetype)sharedManager{
//    static TouLianZhuiJiaXiangQingView *sharedAccountManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^
//    {
//        sharedAccountManagerInstance = (TouLianZhuiJiaXiangQingView *)[self awakeFromNib];
//        
//    });
//    return sharedAccountManagerInstance;
//}


/*
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"TouLianZhuiJiaXiangQingView" owner:self options:nil];
    
    TouLianZhuiJiaXiangQingView *toulianView = [array lastObject];
    toulianView.bianGengBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    [toulianView.bianGengBtn setTitle:@"确定变更" forState:UIControlStateNormal];
    [toulianView.bianGengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    toulianView.chargV = [ChargeView awakeFromNib];
    toulianView.chargV.frame=CGRectMake(0, 365, 712, 166);
    toulianView.chargV.bankTextField.text = @"";
    toulianView.chargV.acountTextField.text = @"";
    toulianView.chargV.organizationTextField.text = @"";
    
    toulianView.chargV.upOrdown = YES;
    //toulianView.chargV.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [toulianView.chargV createBtn];
    toulianView.chargV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [toulianView.smallTouLianView addSubview:toulianView.chargV];
    toulianView.bianGengBtnView.layer.borderWidth = 1;
    toulianView.bianGengBtnView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    toulianView.xinXiLabel.layer.borderWidth = 1;
    toulianView.xinXiLabel.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    //toulianView.xinXiLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    toulianView.touLianxiangTableView.frame = CGRectMake(0, 35, 712, 35*5);
    toulianView.tiShiLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    toulianView.bianGengBtnView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
//    toulianView.kongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    toulianView.kongBtn.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
//    [toulianView.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji"] forState:UIControlStateNormal];
//    toulianView.kongBtn.frame = CGRectMake(281, 105, 150, 15);
//    [toulianView.kongBtn addTarget:self action:@selector(kongzhiBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [toulianView.tiShiView addSubview:toulianView.kongBtn];
    
    return toulianView;
}

//+ (LingQuTouLianView *)awakeFromNib
//{
//    return [[[NSBundle mainBundle] loadNibNamed:@"LingQuTouLianView" owner:nil options:nil] objectAtIndex:0];
//}
*/

+(TouLianZhuiJiaXiangQingView *)awakeFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"TouLianZhuiJiaXiangQingView" owner:nil options:nil] objectAtIndex:0];
}



- (void)sizeToFit
{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    [self custemView];
}

- (void)custemView
{
    self.bianGengBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    [self.bianGengBtn setTitle:@"确定变更" forState:UIControlStateNormal];
    [self.bianGengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    self.chargV = [ChargeView awakeFromNib];
    self.chargV.frame=CGRectMake(0, 365, 712, 166);
    self.chargV.bankTextField.text = @"";
    self.chargV.acountTextField.text = @"";
    self.chargV.organizationTextField.text = @"";
    
    self.chargV.upOrdown = YES;
    //toulianView.chargV.backgroundColor=[UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.chargV createBtn];
    self.chargV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.smallTouLianView addSubview:self.chargV];
    self.bianGengBtnView.layer.borderWidth = 1;
    self.bianGengBtnView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.xinXiLabel.layer.borderWidth = 1;
    self.xinXiLabel.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    //toulianView.xinXiLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.touLianxiangTableView.frame = CGRectMake(0, 35, 712, 35*5);
    self.tiShiLabel.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    self.bianGengBtnView.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    
    self.detailArray = [[NSMutableArray alloc] init];
    self.smallArray = [[NSMutableArray alloc] init];
   
        NSDictionary *dic1 = @{@"accountCode":@"12599",
                               @"accountName":@"第一主险",
                               @"accountUnits":@"100"};
        [self.smallArray insertObject:dic1 atIndex:0];
        NSDictionary *dic2 = @{@"accountCode":@"19898",
                               @"accountName":@"第一主险",
                               @"accountUnits":@"100"};
        [self.smallArray insertObject:dic2 atIndex:0];
  
   
    self.rowArray = [[NSMutableArray alloc] init];
    self.huodeArray = [[NSMutableArray alloc] init];
    self.smallDic = [[NSDictionary alloc] init];
    self.detailDic = [[NSDictionary alloc] init];
    self.mArray = [[NSMutableArray alloc] init];
    
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,TOULIANXIAYIJI]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
           // NSDictionary *dic1 = [[TPLSessionInfo shareInstance] custmerDic];
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<self.huodeArray.count ; i++)
            {
                NSDictionary *huodeDic = [self.huodeArray objectAtIndex:i];
                NSString *huodeStr = [huodeDic objectForKey:@"policyCode"];
                [resultArray addObject:huodeStr];
            }
            
            NSLog(@"  ccc%lu ",(unsigned long)resultArray.count);
            listBOModel=[remoteService queryInvestmentAdditionalInvestmentWithpolicyCode:resultArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        NSLog(@">>>>>>>>>>>>>tlxxqqqzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.detailArray addObject:[listBOModel.objList objectAtIndex:i]];
           // NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
           // NSLog(@"%@",dic);
        }
        
        for (int a = 0; a< self.detailArray.count; a++)
        {
            NSDictionary *dic1 = [self.detailArray objectAtIndex:a];
           // NSLog(@" mmm %@ ",dic1);
            NSMutableArray *array1 = [dic1 objectForKey:@"productList"];
            
           // NSLog(@"vvvv   %lu",(unsigned long)array1.count);
            for (int b = 0; b<array1.count ; b++)
            {
                NSDictionary *dic2 = [array1 objectAtIndex:b];
                NSMutableArray *array2 = [dic2 objectForKey:@"accountList"];
                [self.mArray addObject:array2];
            }
            
        }
       // NSLog(@" 输出 %@",self.mArray);
        
        
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                               // NSLog(@"收费账号%@",listBOModel.objList);
                           }
                           [self.touLianxiangTableView reloadData];
                          // [self custemFrame];
                       });
        
    });
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.detailArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;

}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    
    self.qutouLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    //self.qutouLabel.text = @"      保单号：15300990549000";
    self.detailDic = [self.detailArray objectAtIndex:section];
    NSString *deStr = [self.detailDic objectForKey:@"policyCode"];
    self.qutouLabel.text = [NSString stringWithFormat:@"     保单号：  %@",deStr];
    self.qutouLabel.font = [UIFont systemFontOfSize:18];
    self.qutouLabel.textColor = [UIColor whiteColor];
    [view addSubview:self.qutouLabel];
    
    return view;
}


//redefinition of method parameter section
//section used as the name of the previous parameter rather than as part of the selector

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   // NSLog(@" uuu%lu ",(unsigned long)[[self.mArray objectAtIndex:section] count]);
    return [[self.mArray objectAtIndex:section] count]+2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    /*
     //自定义cell
     static NSString *cellIdeitifier1 = @"Cell1";
     static NSString *cellIdeitifier2 = @"Cell2";
     ZYTableViewCell *cell = nil;
     
     NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"ZYTableViewCell" owner:nil options:nil];
     
     if (news.newsType != 6)
     {
     // cell1
     cell = [tableView dequeueReusableCellWithIdentifier:cellIdeitifier1];
     if (cell == nil)
     {
     cell = xibArray[0];
     }
     */
    
    self.rowArray = [self.mArray objectAtIndex:indexPath.section];
    for (int a = 0; a<self.rowArray.count; a++)
    {
        NSDictionary *dic1 = [self.rowArray objectAtIndex:a];
        [self.smallArray addObject:dic1];
    }
    
    //NSLog(@" ggg%@  ",self.smallArray);
    
    self.smallDic = [self.smallArray objectAtIndex:indexPath.row];
    
    static NSString * cellIdentifer1 = @"cell1";
    static NSString * cellIdentifer2 = @"cell2";
    static NSString * cellIdentifer3 = @"cell3";
  
    TouLianXiangQingViewCell *cell = nil;
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"TouLianXiangQingViewCell" owner:nil options:nil];
    
   // NSLog(@"uuuuuuuu%d",xibArray.count);
    if (indexPath.row == 0)
    {
        cell = (TouLianXiangQingViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer1];
        if (cell==nil)
        {
           
            cell = xibArray[0];
            
        }
    }
    else if (indexPath.row == 1)
    {
        cell = (TouLianXiangQingViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer2];
        if (cell==nil)
        {
            cell = xibArray[1];
        }
        
    }
    else
    {
        cell = (TouLianXiangQingViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifer3];
        if (cell==nil)
        {
            cell = xibArray[2];
        }
        cell.daiMaLabel.text = [self.smallDic objectForKey:@"accountCode"];
        cell.huMingLabel.text = [self.smallDic objectForKey:@"accountName"];
        NSString *jiJinStr = [NSString stringWithFormat:@"%@",[self.smallDic objectForKey:@"accountUnits"]];
        
        cell.jiJinShuLabel.text = jiJinStr;
        
    }

//    UILabel *daiMaLabel;
//    UILabel *huMingLabel;
//    UILabel *jiJinShuLabel;
    
//    NSString *identier = @"cell";
//    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    [self.rowArray removeAllObjects];
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

}

//此处应谨记//当使用xib 自定义多个cell时，所有控件都会关联到cell1 上，需要重新关联
- (IBAction)bianGengBtnClick:(id)sender
{
    //先判断比例有没有超过100
    NSArray *array=[self.touLianxiangTableView visibleCells];
    int sum=0;
    for (int i=0; i<array.count; i++) {
        TouLianXiangQingViewCell *cell=[array objectAtIndex:i];
        sum=sum+[cell.biLiTf.text integerValue];
    }
    NSLog(@"99999999%d",sum);
    
    if (sum>100) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"提示信息" message:@"分配比例总和不能超过100%" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
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

    //[self removeFromSuperview];
 
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    messV.delegate=self;
    
    messV.backgroundColor = [UIColor clearColor];
    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    [threeVC.view addSubview:messV];
    
}

- (IBAction)kongBtnClick:(id)sender
{
    if (self.isUp == NO)
    {
        self.xinXiLabel.frame = CGRectMake(0, 250, 712, 35);
        self.chargV.frame =CGRectMake(0, 285, 712, 166);
        self.tiShiView.frame = CGRectMake(0, 451, 712, 290);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-dianji.png"] forState:UIControlStateNormal];
        self.isUp = YES;
    }
    else
    {
        self.xinXiLabel.frame = CGRectMake(0, 330, 712, 35);
        self.chargV.frame =CGRectMake(0, 365, 712, 166);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
        self.tiShiView.frame = CGRectMake(0, 531, 712, 290);
        self.isUp = NO;
        
    }
    
}

//隐藏详情
- (IBAction)toumingBtnClick:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        self.chargV.frame =CGRectMake(0, 365, 712, 166);
    }];
    
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

-(void)massageTest{
//    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    view.delegate=self;
//    [[self superview] addSubview:view];
    
    [mypackage reset];//先清空之前的数据
    [self startinterface];
    
}
-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
    //self.alpha=0;
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



@end
