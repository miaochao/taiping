//
//  HongLiXuanZeFangShiBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "HongLiXuanZeFangShiBianGengView.h"

#import "PreserveServer-Prefix.pch"

#define HONGLIXUANZEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.QueryDrawAccountServlet"

#define HONGLIBIANGENG @"/servlet/hessian/com.cntaiping.intserv.custserv.draw.UpdateBonusWayServlet"


@implementation HongLiXuanZeFangShiBianGengView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
{
    HongLiXuanZeFangShiXiangQingView *dizhiBianGengView;

}


+(HongLiXuanZeFangShiBianGengView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HongLiXuanZeFangShiBianGengView" owner:nil options:nil] objectAtIndex:0];
    
}
- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
    self.diZhiTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 108)];
    //self.diZhiTabV.backgroundColor = [UIColor redColor];
    self.diZhiTabV.rowHeight = 35;
    [self addSubview:self.diZhiTabV];
    self.diZhiTabV.dataSource = self;
    self.diZhiTabV.delegate = self;
    
    // [self.baoDanNianTabV registerClass:[BaoDanNianDuViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tabvArray = [[NSMutableArray alloc] init];
    [self requestNumber];
}

//请求数据
- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,HONGLIXUANZEURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLListBOModel> listBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            NSLog(@"输出  %@",dic);
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *birthday = [dateFormatter dateFromString:[dic objectForKey:@"brithday"]];
            int gender = 0;
            if ([[dic objectForKey:@"gender"] isEqualToString:@"M"])
            {
                gender = 1;
            }
            listBOModel=[remoteService queryBonusWayWithAgentId:@"" andPolicyCode:@"100101012522202" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
            
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
        NSLog(@"hlxxxxxxxxxz%@",listBOModel.objList);
        NSLog(@" 9999%@ ",self.tabvArray);
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
                           //[self custemFrame];
                       });
        
    });
    
}


//表的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabvArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HongLiXuanZeFangShiBianGengViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[HongLiXuanZeFangShiBianGengViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    id<TPLBonusWayBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
   // NSLog(@" sdsfsf%@",dic);
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.danhaoLabel.text = dic.policyCode;
    cell.baorenLabel.text = dic.productAbbr;//险种名称
    cell.zhuangtaiLabel.text = dic.bonusType;//红利选择方式
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    if (dizhiBianGengView)
    {
        [dizhiBianGengView removeFromSuperview];
    }
    
    dizhiBianGengView = [[[NSBundle mainBundle] loadNibNamed:@"HongLiXuanZeFangShiBianGengView" owner:self options:nil] objectAtIndex:2];
    dizhiBianGengView.alpha=1;
    //将接收到的数据传递给下一级
    dizhiBianGengView.huoDeDic = [self.tabvArray objectAtIndex:indexPath.row];
    NSLog(@" 内容 %@  ",dizhiBianGengView.huoDeDic);
    [dizhiBianGengView sizeToFit];
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

@end


@implementation HongLiXuanZeFangShiBianGengViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HongLiXuanZeFangShiBianGengView" owner:nil options:nil] objectAtIndex:1];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


@implementation HongLiXuanZeFangShiXiangQingView

{
    UITableView *hongLiXiangTabv;
     BjcaInterfaceView *mypackage;//CA拍照
}


+(HongLiXuanZeFangShiXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"HongLiXuanZeFangShiBianGengView" owner:nil options:nil] objectAtIndex:2];
    
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
    self.chuanDiDic = [[NSMutableDictionary alloc] init];
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.xiangQingLabel.text = [NSString stringWithFormat:@"保单号： %@",self.huoDeDic.policyCode ];
    
    self.huoDeArray = [[NSMutableArray alloc] init];
    self.huoDeArray = self.huoDeDic.bonusWayBOs;
    
    
    hongLiXiangTabv = [[UITableView alloc] initWithFrame:CGRectMake(0, 72, 712, 105)];
    [self.smallHongLiView addSubview:hongLiXiangTabv];
    hongLiXiangTabv.rowHeight = 36;
    hongLiXiangTabv.delegate = self;
    hongLiXiangTabv.dataSource = self;
    
     
     
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
    return self.huoDeArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HongLiXuanZeFangShiXiangQingViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
    if (!cell)
    {
        cell = [[HongLiXuanZeFangShiXiangQingViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 36)];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    id<TPLBonusWayBOModel>dic = [self.huoDeArray objectAtIndex:indexPath.row];
    cell.xianzhongLabel.text = dic.productAbbr;
    cell.fangshiLabel.text = dic.bonusType;
    [cell.fangshiBtn addTarget:self action:@selector(fangshIBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.fangshiBtn.tag = indexPath.row+10;
    
    if ([dic.isBonus isEqualToString:@"1"])
    {
        cell.fenHongLabel.text = @"是";
    }
    else
    {
        cell.fenHongLabel.text = @"否";
    }
    if ([cell.fangshiLabel.text isEqualToString:@"现金领取"])
    {
        [cell.fangshiBtn setImage:[UIImage imageNamed:@"xianjinlingqu.png"] forState:UIControlStateNormal];
    }
    else if ([cell.fangshiLabel.text isEqualToString:@"累积生息"])
    {
        [cell.fangshiBtn setImage:[UIImage imageNamed:@"leijishengxi.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.fangshiBtn setImage:[UIImage imageNamed:@"dijiaobaofei.png"] forState:UIControlStateNormal];
        
    }
  
    
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
    
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    messV.delegate=self;
    messV.backgroundColor = [UIColor clearColor];
    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    [threeVC.view addSubview:messV];
    
    [self updateNumber];
    
}

- (void)updateNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,HONGLIBIANGENG]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> changeReturnBOModel=nil;
        @try {
            
           // NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            //            NSString *userName = [TPLSessionInfo shareInstance].isUserExt.userName;
            //            NSString *realName = [TPLSessionInfo shareInstance].isUserExt.realName;
            //            NSString *userCate = [TPLSessionInfo shareInstance].userCate;
            
            NSString *userName = @"2222";
            NSString *realName = @"2222";
            NSString *userCate = @"2222";
    
            NSDictionary*resultDic = (NSDictionary *)self.huoDeDic;
            
            changeReturnBOModel=[remoteService updateBonusWayWithBonusWayBO:resultDic andUserCate:userCate andUserName:userName andRealName:realName];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
          NSLog(@">>>>>>>>>>>>>hlxzbbbb%@",changeReturnBOModel);
//        for (int i=0; i<listBOModel.objList.count; i++)
//        {
//            [self.tabvArray addObject:[listBOModel.objList objectAtIndex:i]];
//            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            //            NSLog(@"%@",dic);
//        }
//        NSLog(@"hlxxxxxxxxxz%@",listBOModel.objList);
//        dispatch_async(dispatch_get_main_queue(), ^
//                       {
//                           NSString *errorStr = [listBOModel.errorBean errorInfo];
//                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                               [alert show];
//                               return;
//                               
//                           }
//                          
//                           //[self custemFrame];
//                       });
        
    });
    
}



-(void)fangshIBtnClick:(UIButton *)sender
{
    
     // NSLog(@" ggg%ld ",sender.tag);
    if (self.smallFangShiView)
    {
        [self.smallFangShiView removeFromSuperview];
    }
    self.smallFangShiView = [[UIView alloc] init];
    self.smallFangShiView.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    //smallFangShiView.backgroundColor = [UIColor redColor];
    [self.smallHongLiView addSubview:self.smallFangShiView];
    
    HongLiXuanZeFangShiXiangQingViewCell *cell = (HongLiXuanZeFangShiXiangQingViewCell *)[[[sender superview] superview] superview];
    
    self.smallFangShiView.frame = CGRectMake(591, cell.frame.origin.y+106+34*(sender.tag -10), 100, 95);
    
    UIButton *xuanZeBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanZeBtn1.tag = 1000+(sender.tag+1);
    //[xuanZeBtn1 setTitle:@"现金领取" forState:UIControlStateNormal];
   // xuanZeBtn1.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
   // xuanZeBtn1.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
   // [xuanZeBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuanZeBtn1 setImage:[UIImage imageNamed:@"xianjinlingqu.png"] forState:UIControlStateNormal];
    xuanZeBtn1.frame = CGRectMake(0, 0, 100, 31);
    [xuanZeBtn1 addTarget:self action:@selector(xuanzeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.smallFangShiView addSubview:xuanZeBtn1];
        
    UIButton *xuanZeBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanZeBtn2.tag = 2000+(sender.tag+1);
//    [xuanZeBtn2 setTitle:@"累积生息" forState:UIControlStateNormal];
//    xuanZeBtn2.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
//    [xuanZeBtn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuanZeBtn2 setImage:[UIImage imageNamed:@"leijishengxi.png"] forState:UIControlStateNormal];
    xuanZeBtn2.frame = CGRectMake(0, 32, 100, 31);
    [xuanZeBtn2 addTarget:self action:@selector(xuanzeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.smallFangShiView addSubview:xuanZeBtn2];
    
    UIButton *xuanZeBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    xuanZeBtn3.tag = 3000+(sender.tag +1);
//    [xuanZeBtn3 setTitle:@"抵交保费" forState:UIControlStateNormal];
//    xuanZeBtn3.backgroundColor = [UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1];
//    [xuanZeBtn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [xuanZeBtn3 setImage:[UIImage imageNamed:@"dijiaobaofei.png"] forState:UIControlStateNormal];
    xuanZeBtn3.frame = CGRectMake(0, 64, 100, 31);
    [xuanZeBtn3 addTarget:self action:@selector(xuanzeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.smallFangShiView addSubview:xuanZeBtn3];
    
}


- (void)xuanzeBtnClick:(UIButton *)btn
{
    
      NSLog(@" ggg999%ld ",(long)btn.tag);
     btn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    if (btn.tag/1000 == 1)
    {
       //[self.fangshiBtn setTitle:@"现金领取" forState:UIControlStateNormal];
       
      [UIView animateWithDuration:0.1 animations:^
      {
          [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1]];
      } completion:^(BOOL finished)
      {
          long btnTag = btn.tag -1000-1;
          UIButton *button = (UIButton *)[self viewWithTag:btnTag];
          
          id<TPLBonusWayBOModel>dic =  [self.huoDeArray objectAtIndex:btnTag-10];
          dic.bonusType = @"现金领取";
          
          [button setImage:[UIImage imageNamed:@"xianjinlingqu.png"] forState:UIControlStateNormal];
          [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1]];
          [self.smallFangShiView removeFromSuperview];
          
      }];
        
        
    }
    else if (btn.tag/1000 == 2)
    {

 
        long btnTag = btn.tag -2000-1;
        UIButton *button = (UIButton *)[self viewWithTag:btnTag];
        
        id<TPLBonusWayBOModel>dic =  [self.huoDeArray objectAtIndex:btnTag-10];
        dic.bonusType = @"累积生息";
        
        [button setImage:[UIImage imageNamed:@"leijishengxi.png"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1]];
        [self.smallFangShiView removeFromSuperview];
      
    }
    else
    {
    
        long btnTag = btn.tag -3000-1;
        UIButton *button = (UIButton *)[self viewWithTag:btnTag];
        
        id<TPLBonusWayBOModel>dic =  [self.huoDeArray objectAtIndex:btnTag-10];
        dic.bonusType = @"抵交保费";
        
        [button setImage:[UIImage imageNamed:@"dijiaobaofei.png"] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1]];
        [self.smallFangShiView removeFromSuperview];
    }
    
}

@end


@implementation  HongLiXuanZeFangShiXiangQingViewCell


-(instancetype)initWithFrame:(CGRect)frame
{
    self=[[[NSBundle mainBundle] loadNibNamed:@"HongLiXuanZeFangShiBianGengView" owner:nil options:nil] objectAtIndex:3];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}



@end


