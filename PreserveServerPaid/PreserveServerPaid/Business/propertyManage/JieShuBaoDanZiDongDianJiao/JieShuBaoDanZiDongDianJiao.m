//
//  JieShuBaoDanZiDongDianJiao.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "JieShuBaoDanZiDongDianJiao.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

#define JIESHUBAODANURL @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.QueryPolicyEffectivenessServlet"

#define JIESHUBAODANXIANGXI @"/servlet/hessian/com.cntaiping.intserv.custserv.effect.QueryPolicyEffectivenessServlet"

@implementation JieShuBaoDanZiDongDianJiao

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

{
    
    int choose;
    JieShuBaoDanZiDongDianJiaoXiangQingView *dizhiBianGengView;
  
}


+(JieShuBaoDanZiDongDianJiao *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"JieShuBaoDanZiDongDianJiao" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit
{
    [super sizeToFit];
  
    [self custemView];
}


-(void)custemView
{
    //tableView.separatorStyle = UITableViewCellSelectionStyleNone
    self.diZhiTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 108)];
    //self.diZhiTabV.backgroundColor = [UIColor redColor];
    self.diZhiTabV.rowHeight = 36;
    [self addSubview:self.diZhiTabV];
    self.diZhiTabV.dataSource = self;
    self.diZhiTabV.delegate = self;
    
  
    self.chooseArray = [[NSMutableArray alloc] init];
    
    // [self.baoDanNianTabV registerClass:[BaoDanNianDuViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tabvArray = [[NSMutableArray alloc] init];
//    NSDictionary *dic1 = @{@"number":@"1",@"danhao":@"10010101201202",@"beibaoren":@"太平寿比南山附加养老险",@"zhuangTai":@"自动保费垫缴"};
//    [self.tabvArray addObject:dic1];
//    
//    NSDictionary *dic2 = @{@"number":@"2",@"danhao":@"10010101252226",@"beibaoren":@"xxxx保险",@"zhuangTai":@"自动保费垫缴"};
//    [self.tabvArray addObject:dic2];
//    
//    NSDictionary *dic3 = @{@"number":@"3",@"danhao":@"10010101289856",@"beibaoren":@"xxxx保险",@"zhuangTai":@"自动保费垫缴"};
//    [self.tabvArray addObject:dic3];
    
    [self requestNumber];
    
}



- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,JIESHUBAODANURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            listBOModel=[remoteService queryEndPolicyAutomaticPadWithCustomerID:[dic objectForKey:@"customerId"]];
            
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
            [self.tabvArray addObject:[listBOModel.objList objectAtIndex:i]];
//            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            NSLog(@"%@",dic);
        }
         NSLog(@"jsbd%@",listBOModel.objList);
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
                           [self.diZhiTabV reloadData];
                           [self custemFrame];
                       });
        
    });
    
}

-(void)custemFrame{
    if (35*self.tabvArray.count>600) {
        self.diZhiTabV.frame=CGRectMake(0, 35, 776, 385);
        self.quanXuanView.frame = CGRectMake(0, 420, 776, 35);
        self.querenBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else{
        self.diZhiTabV.frame=CGRectMake(0, 35, 776, 35*self.tabvArray.count);
        self.quanXuanView.frame = CGRectMake(0, 35*self.tabvArray.count-104, 776, 35);
        self.querenBtn.frame = CGRectMake(681, 35*self.tabvArray.count+50-104, 90, 35);
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabvArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JieShuBaoDanZiDongDianJiaoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[JieShuBaoDanZiDongDianJiaoCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    NSDictionary *dic = [self.tabvArray objectAtIndex:indexPath.row];
    
    cell.danhaoLabel.text = [dic objectForKey:@"policyCode"];
    cell.zhuXianLabel.text = [dic objectForKey:@"productName"];
    cell.zhuangtaiLabel.text = [dic objectForKey:@"premStatusName"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.danxuanBtn.tag=indexPath.row;
    [cell.danxuanBtn setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    [cell.danxuanBtn addTarget:self action:@selector(danXuanZeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    for (int i=0; i<self.chooseArray.count; i++)
    {
        if ([[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"] isEqualToString:[[self.tabvArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]])
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
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.tabvArray objectAtIndex:indexPath.row] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.tabvArray objectAtIndex:indexPath.row]];
        if (self.chooseArray.count==self.tabvArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.diZhiTabV reloadData];

}

- (IBAction)quanXuanBtnClick:(UIButton *)sender
{
    
    if (sender.tag==6601) {
        //表示全选
        sender.tag=6602;
        [sender setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        [self.chooseArray removeAllObjects];
        for (NSString *str in self.tabvArray) {
            [self.chooseArray addObject:str];
        }
        [self.diZhiTabV reloadData];
        return;
    }
    if (sender.tag==6602) {
        //全部不选
        [self.chooseArray removeAllObjects];
        sender.tag=6601;
        [sender setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
        [self.diZhiTabV reloadData];
    }
    
}

- (IBAction)queDingBtnClick:(id)sender
{
    if (self.chooseArray.count == 0)
    {
        [self alertView:@"请选择保单后再进行操作！"];
        return;
    }
    
    if (dizhiBianGengView)
    {
        [dizhiBianGengView removeFromSuperview];
    }
    
    dizhiBianGengView = [[[NSBundle mainBundle] loadNibNamed:@"JieShuBaoDanZiDongDianJiao" owner:self options:nil] objectAtIndex:2];
    dizhiBianGengView.alpha=1;
    [dizhiBianGengView sizeToFit];
    dizhiBianGengView.tag=20000;
    dizhiBianGengView.huodeArray = self.chooseArray;
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

-(void)danXuanZeBtnClick:(UIButton *)sender
{
    BOOL  isChoose=YES;
    for (int i=0;i<self.chooseArray.count;i++) {
        NSString *str=[[self.chooseArray objectAtIndex:i] objectForKey:@"policyCode"];
        if ([str isEqualToString:[[self.tabvArray objectAtIndex:sender.tag] objectForKey:@"policyCode"]]) {
            [self.chooseArray removeObjectAtIndex:i];
            isChoose=NO;
            break;
        }
        [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe weidianji.png"] forState:UIControlStateNormal];
    }
    if (isChoose) {
        //未选择，就添加
        [self.chooseArray addObject:[self.tabvArray objectAtIndex:sender.tag]];
        if (self.chooseArray.count==self.tabvArray.count) {
            [self.allChooseBtn  setImage:[UIImage imageNamed:@"xuanzhe dianji.png"] forState:UIControlStateNormal];
        }
    }
    [self.diZhiTabV reloadData];
    
}

-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}


@end


@implementation JieShuBaoDanZiDongDianJiaoCell


-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"JieShuBaoDanZiDongDianJiao" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


@implementation JieShuBaoDanZiDongDianJiaoXiangQingView

{
    UITableView *xiangTabV;
     BjcaInterfaceView *mypackage;//CA拍照
}


+(JieShuBaoDanZiDongDianJiaoXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"JieShuBaoDanZiDongDianJiao" owner:nil options:nil] objectAtIndex:2];
    
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
    //详情页多区表
    xiangTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 712, 372)];
    [self.smallXiangView addSubview:xiangTabV];
    xiangTabV.rowHeight = 108;
    xiangTabV.dataSource = self;
    xiangTabV.delegate = self;
    [self.smallXiangView sendSubviewToBack:xiangTabV];
    
    self.lingQuXinXiLabel.layer.borderWidth = 1;
    self.lingQuXinXiLabel.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.lingQuXinXiLabel.frame = CGRectMake(0, 330, 712, 35);
    self.wenXinView.frame = CGRectMake(0, 531, 712, 290);
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
//    self.kongBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    self.kongBtn.frame = CGRectMake(281, 641, 150, 16);
//    //self.kongBtn.backgroundColor = [UIColor redColor];
//    [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
//    self.kongBtn.backgroundColor = [UIColor colorWithRed:217/255.0 green:217/255.0 blue:217/255.0 alpha:1];
//    [self.kongBtn addTarget:self action:@selector(kongBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.smallXiangView addSubview:self.kongBtn];
//    [self.smallXiangView bringSubviewToFront:self.kongBtn];
    
    self.chargeV = [ChargeView awakeFromNib];
    self.chargeV.frame=CGRectMake(0, 365, 712, 166);
    self.chargeV.upOrdown = YES;
    [self.chargeV createBtn];
    self.chargeV.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
    [self.smallXiangView addSubview:self.chargeV];
    
    self.huodeArray = [[NSMutableArray alloc] init];
    self.detailArray = [[NSMutableArray alloc] init];
    [self requestDetailNumber];
}



- (void)requestDetailNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,JIESHUBAODANURL]];
    
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
          
            listBOModel=[remoteService queryEndPolicyAutomaticPadDetailWithPolityArray:resultArray];
            
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
            [self.detailArray addObject:[listBOModel.objList objectAtIndex:i]];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
        }
        NSLog(@"jsbdxq%@",self.detailArray);
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
                           [xiangTabV reloadData];
                          // [self custemFrame];
                       });
        
    });
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.detailArray.count;
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 35;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 20;

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    
    UILabel  *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 712, 35)];
    
    NSDictionary *headdic = [self.huodeArray objectAtIndex:section];
    NSString *headStr = [headdic objectForKey:@"policyCode"];
    cellLabel.text = [NSString stringWithFormat:@"      保单号：%@",headStr];
    
    cellLabel.font = [UIFont systemFontOfSize:18];
    cellLabel.textColor = [UIColor whiteColor];
    [view addSubview:cellLabel];
    
    return view;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JieShuBaoDanZiDongDianJiaoXiangQingViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell9"];

    if (!cell)
    {
        cell = [[JieShuBaoDanZiDongDianJiaoXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 712, 108)];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *rowDic = [self.detailArray objectAtIndex:indexPath.section];
    
    cell.xuhaoLabel.text = [rowDic objectForKey:@"internalId"];
    cell.xianmingLabel.text = [rowDic objectForKey:@"productName"];
    cell.zhuangtaiLabel.text = [rowDic objectForKey:@"premStatusName"];
    cell.dangqianFeiLabel.text = [rowDic objectForKey:@"curDisPrem"];
    cell.xiaqiFeiLabel.text = [rowDic objectForKey:@"nextDisFrem"];
    cell.hejiJinLabel.text = [NSString stringWithFormat:@"    该保单结束自缴 应补金额合计： %@",[rowDic objectForKey:@"endFee"]];
    
    return cell;
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
    self.alpha=0;
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



- (IBAction)yinCangBtnClick:(id)sender
{
    
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
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
        [self alertView:@"请输入收费账号！"];
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

/*
-(void)kongBtnClick
{
    if (self.isUp == NO)
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 170, 712, 35);
        self.chargeV.frame =CGRectMake(0, 205, 712, 166);
        self.wenXinView.frame = CGRectMake(0, 371, 712, 290);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-dianji.png"] forState:UIControlStateNormal];
        self.isUp = YES;
    }
    else
    {
        self.lingQuXinXiLabel.frame = CGRectMake(0, 330, 712, 35);
        self.chargeV.frame =CGRectMake(0, 365, 712, 166);
        [self.kongBtn setImage:[UIImage imageNamed:@"xlzhankai-weidianji.png"] forState:UIControlStateNormal];
        self.wenXinView.frame = CGRectMake(0, 531, 712, 290);
        self.isUp = NO;
        
    }

    
}
*/

@end


@implementation JieShuBaoDanZiDongDianJiaoXiangQingViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"JieShuBaoDanZiDongDianJiao" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}


@end






