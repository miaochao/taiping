//
//  LingQuTouLianView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/10.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "LingQuTouLianView.h"
#import "LingQuTouLianJiaZhiTableViewCell.h"
#import "LingQutouLianXiangQingTableViewCell.h"
#import "PreserveServer-Prefix.pch"


#define LINGQUTOULIAN  @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"

#define LINGQUXIANGQINGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.investment.QueryInvestmentAccountServlet"

@implementation LingQuTouLianView
{
    UITableView *lingQuTouLianTabv;
    LingQuTouLianXiangQingView *bigtouLianView;
}



+ (LingQuTouLianView *)awakeFromNib
{
  return [[[NSBundle mainBundle] loadNibNamed:@"LingQuTouLianView" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}

- (void)custemView
{
    lingQuTouLianTabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 105) style:UITableViewStylePlain];
    lingQuTouLianTabv.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    //lingQuTouLianTabv.backgroundColor=[UIColor redColor];
    [self addSubview:lingQuTouLianTabv];
    lingQuTouLianTabv.rowHeight = 35;
    lingQuTouLianTabv.delegate = self;
    lingQuTouLianTabv.dataSource =self;
   
    
    self.quanArray = [[NSMutableArray alloc] init];
    self.chooseArray = [[NSMutableArray alloc]init];
    
    
//    NSDictionary *dic=@{@"number":@"15300990549000",@"name":@"第一主险"};
//    [self.quanArray addObject:dic];
//    NSDictionary *dic1=@{@"number":@"18398080985003",@"name":@"第一主险"};
//    [self.quanArray addObject:dic1];
//    NSDictionary *dic2=@{@"number":@"15308573878799",@"name":@"第一主险"};
//    [self.quanArray addObject:dic2];
    
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,LINGQUTOULIAN]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService queryReceiveInvestmentLinkedAccountValueWithcustomerId:[dic objectForKey:@"customerId"]];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
       //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.quanArray addObject:[listBOModel.objList objectAtIndex:i]];
            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            NSLog(@"%@",dic);
        }
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
                           [lingQuTouLianTabv reloadData];
                           [self custemFrame];
                       });
        
    });
    
}

-(void)custemFrame{
    if (35*self.quanArray.count>385) {
        lingQuTouLianTabv.frame=CGRectMake(0, 35, 776, 385);
        self.quanXuanView.frame = CGRectMake(0, 420, 776, 35);
        self.touLianQueRenBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else{
        lingQuTouLianTabv.frame=CGRectMake(0, 35, 776, 35*self.quanArray.count);
        self.quanXuanView.frame = CGRectMake(0, 35+35*self.quanArray.count, 776, 35);
        self.touLianQueRenBtn.frame = CGRectMake(681, 35+35*self.quanArray.count+50, 90, 35);
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    NSLog(@"  uiiiiii%lu ",(unsigned long)self.quanArray.count);
    return self.quanArray.count;
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    static NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"LingQuTouLianJiaZhiTableViewCell" owner:nil options:nil];
    
    LingQuTouLianJiaZhiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell)
    {
        cell = xibArray[0];
        
    }
    NSDictionary *dic=[self.quanArray objectAtIndex:indexPath.row];
    //cell.baodanhaoLabel.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.baodanhaoLabel.text=[dic objectForKey:@"policyCode"];
    NSString *pinString = [NSString stringWithFormat:@"      %@",[dic objectForKey:@"productName"]];
    cell.zhuXianLabel.text= pinString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.xuanZeBtn addTarget:self action:@selector(danxuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.xuanZeBtn.tag=indexPath.row;
    [cell.xuanZeBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.xuanZeBtn addTarget:self action:@selector(danxuanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            [cell.xuanZeBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [lingQuTouLianTabv reloadData];

}


- (IBAction)jiazhiQueDingBtnClick:(id)sender
{
    
    if (self.chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    
    if (bigtouLianView)
    {
        [bigtouLianView removeFromSuperview];
    }
    
    bigtouLianView = [[[NSBundle mainBundle] loadNibNamed:@"LingQuTouLianView" owner:self options:nil] objectAtIndex:1];
    bigtouLianView.alpha=1;
    [bigtouLianView sizeToFit];
    bigtouLianView.tag=20000;
    bigtouLianView.huodeArray = self.chooseArray;
    bigtouLianView.frame = CGRectMake(1024, 64, 1024, 704);
    bigtouLianView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:bigtouLianView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         bigtouLianView.frame = CGRectMake(0, 64, 1024, 704);
         
         
     } completion:^(BOOL finished)
     {
         nil;
     }];
   
    
}

- (IBAction)quanxuanBtnClick:(UIButton *)sender
{
    if (sender.tag==8651) {
        //表示全选
        sender.tag=8652;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSString *str in self.quanArray) {
            [self.chooseArray addObject:str];
        }
        [lingQuTouLianTabv reloadData];
        return;
    }
    if (sender.tag==8652) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=8651;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [lingQuTouLianTabv reloadData];
    }
    
}

-(void)danxuanBtnClick:(UIButton *)btn
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:btn.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.quanArray objectAtIndex:btn.tag]];
        if (self.chooseArray.count==self.quanArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [lingQuTouLianTabv reloadData];
    
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

@end





@implementation LingQuTouLianXiangQingView

/*
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"ProportionChangeView" owner:nil options:nil] lastObject];
    if (self) {
        [self setFrame:frame];
        
        
        self.xiangQingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, 712, 105) style:UITableViewStylePlain];
        [self.smallXiangView addSubview:self.xiangQingTableView];
        self.xiangQingTableView.delegate = self;
        self.xiangQingTableView.dataSource = self;
        
    }
    return self;
}
*/
{
  BjcaInterfaceView *mypackage;//CA拍照

}


+(LingQuTouLianXiangQingView*)awakeFromNib
{
    return [[[NSBundle mainBundle]loadNibNamed:@"LingQuTouLianView" owner:nil options:nil] objectAtIndex:1];
}

- (void)sizeToFit
{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    
    [self custemView];
}

-(void)custemView{
    self.wenXinView.clipsToBounds=YES;
    self.detailArray=[[NSMutableArray alloc] init];
    self.mArray = [[NSMutableArray alloc] init];
    self.huodeArray = [[NSMutableArray alloc] init];
    self.smallArray = [[NSMutableArray alloc] init];
    
    //chooseArray=[[NSMutableArray alloc] init];
    self.xiangQingTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 300)];
    [self bringSubviewToFront:self.biangengView];
    [self.smallXiangView addSubview:self.xiangQingTableView];
    self.xiangQingTableView.rowHeight=36;
    self.xiangQingTableView.delegate=self;
    self.xiangQingTableView.dataSource=self;
    
    self.kongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.kongBtn.frame = CGRectMake(281, 646, 150, 16);
    //self.kongBtn.backgroundColor = [UIColor redColor];
    self.kongBtn.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.kongBtn addTarget:self action:@selector(kongBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
    [self.smallXiangView addSubview:self.kongBtn];
    [self.smallXiangView bringSubviewToFront:self.kongBtn];
    
    self.biangengView = [[UIView alloc] initWithFrame:CGRectMake(0, 661, 712, 35)];
    self.biangengView.layer.borderWidth = 1;
    self.biangengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    //[self.biangengView setBackgroundColor:[UIColor blackColor]];
    [self.smallXiangView addSubview:self.biangengView];
    [self.smallXiangView bringSubviewToFront:self.biangengView];
    
    self.biangengBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.biangengBtn.frame = CGRectMake(580, 3, 95, 28);
    self.biangengBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    [self.biangengBtn setTitle:@"确定变更" forState:UIControlStateNormal];
    [self.biangengBtn addTarget:self action:@selector(quedingBianBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.biangengView addSubview:self.biangengBtn];
                        
    self.chargeV = [ChargeView awakeFromNib];
    self.chargeV.frame=CGRectMake(0, 365, 712, 166);
    self.chargeV.upOrdown = YES;
    [self.chargeV createBtn];
    [self.chargeV recriveSurvivalGold];
    self.chargeV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.smallXiangView addSubview:self.chargeV];
    
    self.lingQuXinXiLabel.layer.borderWidth = 1;
    self.lingQuXinXiLabel.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    [self.smallXiangView bringSubviewToFront:self.lingQuXinXiLabel];
    
    
    
//    NSDictionary *dic=@{@"accountNumber":@"1001001",@"accountName":@"XXXX保险",@"jiJin":@"10000",@"shenQing":@"20250"};
//    [self.detailArray addObject:dic];
//    NSDictionary *dic2=@{@"accountNumber":@"1001002",@"accountName":@"XXXX保险",@"jiJin":@"20000",@"shenQing":@"11000"};
//    [self.detailArray addObject:dic2];
  
    [self requestDetailNumber];
}


- (void)requestDetailNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,LINGQUXIANGQINGURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSMutableArray *resultArray = [[NSMutableArray alloc] init];
            for (int i = 0; i<self.huodeArray.count ; i++)
            {
                NSDictionary *huodeDic = [self.huodeArray objectAtIndex:i];
                NSString *huodeStr = [huodeDic objectForKey:@"policyCode"];
                [resultArray addObject:huodeStr];
            }
            
            listBOModel=[remoteService queryReceiveInvestmentLinkedAccountValueDetailWithpolicyCode:resultArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        NSLog(@">>>>>>>>>>>>>lqtlxqzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++) {
            [self.detailArray addObject:[listBOModel.objList objectAtIndex:i]];
            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //NSLog(@"%@",dic);
        }
        for (int a = 0; a< self.detailArray.count; a++)
        {
            NSDictionary *dic1 = [self.detailArray objectAtIndex:a];
            // NSLog(@" mmm %@ ",dic1);
            NSMutableArray *array1 = [dic1 objectForKey:@"internalAccountList"];
            
            // NSLog(@"vvvv   %lu",(unsigned long)array1.count);
            [self.mArray addObject:array1];
            
        }
        //NSLog(@" 9mmmm%@ ",self.mArray);
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
                           [self.xiangQingTableView reloadData];
                           //[self custemDetailFrame];
                       });
        
    });
    
}

//-(void)custemDetailFrame{
//    if (35*self.quanArray.count>385) {
//        lingQuTouLianTabv.frame=CGRectMake(0, 35, 776, 385);
//        self.quanXuanView.frame = CGRectMake(0, 420, 776, 35);
//        self.touLianQueRenBtn.frame = CGRectMake(686, 440+35, 90, 35);
//        
//    }else{
//        lingQuTouLianTabv.frame=CGRectMake(0, 35, 776, 35*self.quanArray.count);
//        self.quanXuanView.frame = CGRectMake(0, 35+35*self.quanArray.count, 776, 35);
//        self.touLianQueRenBtn.frame = CGRectMake(681, 35+35*self.quanArray.count+50, 90, 35);
//    }
//}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.mArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
 
    return 107;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSLog(@" 个数 %lu ",(unsigned long)[[self.mArray objectAtIndex:section] count]);
    return [[self.mArray objectAtIndex:section] count];
   
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString * cellIdentifer = @"cell";
    NSArray *xibArray = [[NSBundle mainBundle] loadNibNamed:@"LingQutouLianXiangQingTableViewCell" owner:nil options:nil];
    
     LingQutouLianXiangQingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    self.smallArray = [self.mArray objectAtIndex:indexPath.section];
    
    if (!cell)
    {
        cell = xibArray[0];
        
    }
    NSDictionary *dic = [self.smallArray objectAtIndex:indexPath.row];
    NSLog(@" jieguo%@ ",dic);
    cell.zhanghuLabel.text = [dic objectForKey:@"accountCode"];
    cell.mingChengLabel.text = [dic objectForKey:@"accountName"];
    NSString *jiJinStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"accunUnits"]];
    cell.jijinZongShuLabel.text = jiJinStr;
    NSString *weiMaiStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"saleApply"]];
    cell.weiMaiLabel.text = weiMaiStr;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LingQuTabHeadView *headView = [LingQuTabHeadView awakeFromNib];
    [headView sizeToFit];
    NSDictionary *dic3 = [self.detailArray objectAtIndex:section];
    headView.policyCode.text = [NSString stringWithFormat:@"保单号:%@",[dic3 objectForKey:@"policyCode"]];
    headView.xianMingLabel.text = [NSString stringWithFormat:@"险种名称: %@",[dic3 objectForKey:@"productName"]];
    //headView.xianMingLabel.text = [dic3 objectForKey:@"productName"];
    
    return headView;
}



- (IBAction)yinCangBtnClick:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished)
    {
        [self removeFromSuperview];
    }];
    
    
}

- (void)quedingBianBtnClick
{
    if ([self.chargeV.bankTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属银行！"];
        return;
    }
    if ([self.chargeV.acountTextField.text isEqualToString:@""])
    {
        [self alertView:@"请输入付费账号！"];
        return;
    }
    if ([self.chargeV.organizationTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属机构！"];
        return;
    }
  
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    messV.delegate=self;
    
    messV.backgroundColor = [UIColor clearColor];
    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    [threeVC.view addSubview:messV];

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



-(void)kongBtnClick
{
    if (self.isUp == NO)
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 170, 712, 35);
        //self.lingQuXinXiLabel.frame = CGRectMake(0, 100, 712, 35);
        self.chargeV.frame =CGRectMake(0, 205, 712, 166);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
        self.wenXinView.frame = CGRectMake(0, 371, 712, 290);
        self.isUp = YES;
    }
    else
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 330, 712, 35);
        self.chargeV.frame =CGRectMake(0, 365, 712, 166);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-dianji.png"] forState:UIControlStateNormal];
        self.wenXinView.frame = CGRectMake(0, 531, 712, 133);
        self.isUp = NO;
    
    }
}

@end


@implementation LingQuTabHeadView


+(LingQuTabHeadView*)awakeFromNib{
    return [[[NSBundle mainBundle]loadNibNamed:@"LingQuTouLianView" owner:nil options:nil] objectAtIndex:2];
}

- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}

-(void)custemView
{

    
    
}
    
@end


