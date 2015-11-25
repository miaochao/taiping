//
//  LingQuHongLiView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "LingQuHongLiView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

#define LINGQUHONGLI  @"/servlet/hessian/com.cntaiping.intserv.custserv.receive.QueryPolicyInterestCollectionServlet"


@implementation LingQuHongLiView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    NSMutableArray *chooseArray;
    UITableView *hongLiTabV;
    LingQuHongLiXinagQingView *dizhiBianGengView;
}

+(LingQuHongLiView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone
    hongLiTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 108)];
    //self.diZhiTabV.backgroundColor = [UIColor redColor];
    hongLiTabV.rowHeight = 36;
    [self addSubview:hongLiTabV];
    hongLiTabV.dataSource = self;
    hongLiTabV.delegate = self;
    
    self.quanArray = [[NSMutableArray alloc] init];
    chooseArray = [[NSMutableArray alloc] init];
    
    // [self.baoDanNianTabV registerClass:[BaoDanNianDuViewCell class] forCellReuseIdentifier:@"cell"];
    
//    self.quanArray = [[NSMutableArray alloc] init];
//    NSDictionary *dic1 = @{@"number":@"1",@"danhao":@"10010101201202",@"beibaoren":@"太平寿比南山附加养老险",@"zhuangTai":@"300000"};
//    [self.quanArray addObject:dic1];
//    
//    NSDictionary *dic2 = @{@"number":@"2",@"danhao":@"10010101252226",@"beibaoren":@"xxxx保险",@"zhuangTai":@"200000"};
//    [self.quanArray addObject:dic2];
//    
//    NSDictionary *dic3 = @{@"number":@"3",@"danhao":@"10010101289856",@"beibaoren":@"xxxx保险",@"zhuangTai":@"100000"};
//    [self.quanArray addObject:dic3];
 
    [self requestNumber];
    
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,LINGQUHONGLI]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService queryReceiveBonusWithCustomerID:[dic objectForKey:@"customerId"]];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            [self.quanArray addObject:[listBOModel.objList objectAtIndex:i]];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
        }
        NSLog(@"lqhl%@",listBOModel.objList);
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                    
                           }
                           [hongLiTabV reloadData];
                           //[self custemFrame];
                       });
        
    });
    
}


-(void)custemFrame{
    if (35*self.quanArray.count>600)
    {
        hongLiTabV.frame=CGRectMake(0, 35, 776, 385);
        self.quanXuanView.frame = CGRectMake(0, 420, 776, 35);
        self.queDingBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else
    {
        hongLiTabV.frame=CGRectMake(0, 35, 776, 35*self.quanArray.count);
        self.quanXuanView.frame = CGRectMake(0, 35*self.quanArray.count-104, 776, 35);
        self.queDingBtn.frame = CGRectMake(681, 35*self.quanArray.count+50-104, 90, 35);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.quanArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LingQuHongLiViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[LingQuHongLiViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    NSDictionary *dic = [self.quanArray objectAtIndex:indexPath.row];
    
    cell.danhaoLabel.text = [dic objectForKey:@"policyCode"];
    NSString *jinStr = [NSString stringWithFormat:@"%@",[dic objectForKey:@"cashBonusSa"]];
    cell.jinELabel.text = jinStr;
    
    [cell.danxuanBtn addTarget:self action:@selector(danXuanZeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.danxuanBtn.tag=indexPath.row;
    [cell.danxuanBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];

    
    for (int i=0; i<chooseArray.count; i++)
    {
        if ([[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
        {
            [cell.danxuanBtn setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
            break;
        }
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL  isChoose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [chooseArray addObject:[self.quanArray objectAtIndex:indexPath.row]];
        if (self.quanArray.count==chooseArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [hongLiTabV reloadData];
}



- (void)danXuanZeBtnClick:(UIButton *)sender
{
    BOOL  isChoose=YES;
    for (int i=0;i<chooseArray.count;i++) {
        NSString *str=[[chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.quanArray objectAtIndex:sender.tag] objectForKey:@"policyCode"]]) {
            [chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [chooseArray addObject:[self.quanArray objectAtIndex:sender.tag]];
        if (self.quanArray.count==chooseArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [hongLiTabV reloadData];
    

}

- (IBAction)quanXuanBtnClick:(UIButton *)sender
{
    if (sender.tag==7851) {
        //表示全选
        sender.tag=7852;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [chooseArray removeAllObjects];
        for (NSString *str in self.quanArray) {
            [chooseArray addObject:str];
        }
        [hongLiTabV reloadData];
        return;
    }
    if (sender.tag==7852) {
        //全部不选
        [chooseArray removeAllObjects];
        sender.tag=7851;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [hongLiTabV reloadData];
    }
    

}


- (IBAction)queDingBtnClick:(id)sender
{
    if (chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    if (dizhiBianGengView)
    {
        [dizhiBianGengView removeFromSuperview];
    }
    
    dizhiBianGengView = [[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:self options:nil] objectAtIndex:2];
    dizhiBianGengView.alpha=1;
    [dizhiBianGengView sizeToFit];
    dizhiBianGengView.huodeArray = chooseArray;
    dizhiBianGengView.tag=20000;
    dizhiBianGengView.frame = CGRectMake(1024, 64, 1024, 704);
    dizhiBianGengView.backgroundColor = [UIColor clearColor];
    [[self superview] addSubview:dizhiBianGengView];
    
    [UIView animateWithDuration:1 animations:^
     {
         dizhiBianGengView.frame = CGRectMake(0, 64, 1024, 704);
         
     } completion:^(BOOL finished)
     {
         nil;
     }];

}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

@end



@implementation LingQuHongLiViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end

//领取红利详情页

@implementation LingQuHongLiXinagQingView

{

  BjcaInterfaceView *mypackage;//CA拍照
}


+(LingQuHongLiXinagQingView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:nil options:nil] objectAtIndex:2];
    
}

- (void)sizeToFit
{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    
    [self custemView];
}


-(void)custemView
{
    self.huodeArray = [[NSMutableArray alloc] init];
    self.xiangArray = [[NSMutableArray alloc] init];
    
    self.xiangTabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 320)];
    [self.smallXiangView addSubview:self.xiangTabv];
    self.xiangTabv.rowHeight = 108;
    self.xiangTabv.delegate = self;
    self.xiangTabv.dataSource = self;
    
    self.lingQuXinXiLabel.layer.borderWidth = 1;
    self.lingQuXinXiLabel.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.lingQuXinXiLabel.frame = CGRectMake(0, 330, 712, 35);
    self.wenXinView.frame = CGRectMake(0, 531, 712, 290);
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.kongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.kongBtn.frame = CGRectMake(281, 641, 150, 16);
    //self.kongBtn.backgroundColor = [UIColor redColor];
    [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
    self.kongBtn.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
    [self.kongBtn addTarget:self action:@selector(kongBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.smallXiangView addSubview:self.kongBtn];
    [self.smallXiangView bringSubviewToFront:self.kongBtn];
    self.chargeV = [ChargeView awakeFromNib];
    self.chargeV.frame=CGRectMake(0, 365, 712, 166);
    self.chargeV.upOrdown = YES;
    [self.chargeV createBtn];
    [self.chargeV  recriveSurvivalGold];
    self.chargeV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.smallXiangView addSubview:self.chargeV];
    
    [self requestDetailNumber];
}

//请求详情
- (void)requestDetailNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,LINGQUHONGLI]];
    
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
            listBOModel=[remoteService queryReceiveBonusDetailWithPolityArray:resultArray];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
        for (int i=0; i<listBOModel.objList.count; i++)
        {
            [self.xiangArray addObject:[listBOModel.objList objectAtIndex:i]];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
        }
        NSLog(@"lqhlxxxqqq%@",listBOModel.objList);
        NSLog(@"  xxx%@ ",self.xiangArray);
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                           }
                           [self.xiangTabv reloadData];
                           [self custemFrame];
                       });
        
    });
    
}

-(void)custemFrame
{


}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   
    return self.xiangArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LingQuHongLiXinagQingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
    
    if (!cell)
    {
        cell = [[LingQuHongLiXinagQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 108)];
        
    }
    NSDictionary *rowDic = [self.xiangArray objectAtIndex:indexPath.section];
    NSLog(@"zzz%@ ",rowDic);
    NSMutableArray *array1 = [rowDic objectForKey:@"productList"];
    NSDictionary *rDic = [array1 objectAtIndex:0];
    NSLog(@"ppp%@ ",rDic);
    cell.xuhaoLabel.text = [rDic objectForKey:@"internal"];
    cell.xianMIngLabel.text = [rDic objectForKey:@"productName"];
    NSString *benStr = [NSString stringWithFormat:@"%@",[rowDic objectForKey:@"cashBonusSa"]];
    cell.benxihejiLabel.text = benStr;
    NSString *baoStr = [NSString stringWithFormat:@"%@",[rDic objectForKey:@"proBonusSa"]];
    cell.baodanHejiLabel.text = baoStr;

    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    LingQuHongLiSmallheadView *headView = [LingQuHongLiSmallheadView awakeFromNib];
    [headView sizeToFit];
    NSDictionary *rwDic = [self.xiangArray objectAtIndex:section];
    headView.headLabel.text = [NSString stringWithFormat:@" 保单号：%@",[rwDic objectForKey:@"policyCode"]];
    
    return headView;
}



- (IBAction)yinCangBtnClick:(id)sender
{
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}

-(void)kongBtnClick
{
    if (self.isUp == NO)
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 250, 712, 35);
        self.chargeV.frame =CGRectMake(0, 285, 712, 166);
        self.wenXinView.frame = CGRectMake(0, 451, 712, 290);
        self.isUp = YES;
    }
    else
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 330, 712, 35);
        self.chargeV.frame =CGRectMake(0, 365, 712, 166);
        self.wenXinView.frame = CGRectMake(0, 531, 712, 290);
        self.isUp = NO;
    }
 
}

- (IBAction)baingengBtnClick:(id)sender
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
   // self.alpha=0;
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


@implementation LingQuHongLiSmallheadView


+(LingQuHongLiSmallheadView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:nil options:nil] objectAtIndex:3];
    
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


@implementation LingQuHongLiXinagQingViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"LingQuHongLiView" owner:nil options:nil] objectAtIndex:4];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end

