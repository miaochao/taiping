//
//  BaoDanNianDuBaoGaoView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "BaoDanNianDuBaoGaoView.h"
#import "PreserveServer-Prefix.pch"


#define BAODANNIANDUURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
#define BAODANBIANGENG @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"


@implementation BaoDanNianDuBaoGaoView
{
    BaoDanNianDuXiangQingView *baoXiangQingView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(BaoDanNianDuBaoGaoView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"BaoDanNianDuBaoGaoView" owner:nil options:nil] objectAtIndex:0];
    
}
- (void)sizeToFit
{
    [super sizeToFit];
    [self custemView];
}


-(void)custemView
{
   //tableView.separatorStyle = UITableViewCellSelectionStyleNone
    
    
    self.baoDanNianTabV = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, 776, 108)];
    [self addSubview:self.baoDanNianTabV];
    self.baoDanNianTabV.rowHeight = 35;
    self.baoDanNianTabV.dataSource = self;
    self.baoDanNianTabV.delegate = self;
   // [self.baoDanNianTabV registerClass:[BaoDanNianDuViewCell class] forCellReuseIdentifier:@"cell"];
   
    self.tabvArray = [[NSMutableArray alloc] init];
//    NSDictionary *dic1 = @{@"number":@"1",@"danhao":@"10010101201202",@"beibaoren":@"宋晓丽",@"zhuangTai":@"有效"};
//    [self.tabvArray addObject:dic1];
//    
//    NSDictionary *dic2 = @{@"number":@"2",@"danhao":@"100101012522202",@"beibaoren":@"宋晓丽",@"zhuangTai":@"有效"};
//    [self.tabvArray addObject:dic2];
//    
//    NSDictionary *dic3 = @{@"number":@"3",@"danhao":@"100126666201202",@"beibaoren":@"宋晓丽",@"zhuangTai":@"有效"};
//    [self.tabvArray addObject:dic3];
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,BAODANNIANDUURL]];
    
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
            
            if (self.pageTag == 103)
            {
                 listBOModel=[remoteService queryPolicyYearReportWithAgentId:@"64646" andPolicyCode:@"100126666201202" andSendModel:1 andCustomerName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
            }
            else if (self.pageTag == 104)
            {
                  listBOModel=[remoteService queryPolicyYearReportWithAgentId:@"64646" andPolicyCode:@"100126666201202" andSendModel:3 andCustomerName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
            }
            else
            {
               listBOModel=[remoteService queryPolicyYearReportWithAgentId:@"64646" andPolicyCode:@"100126666201202" andSendModel:4 andCustomerName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
            
            }
            
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
            id<TPLSendWayBOModel>dic=[listBOModel.objList objectAtIndex:i];
            [self.tabvArray addObject:dic];
            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
            //            NSLog(@"%@",dic);
        }
        NSLog(@"baodanqqqqqq%@",listBOModel.objList);
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        NSLog(@" baodanqqqqqq  %@",self.tabvArray);
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [listBOModel.errorBean errorInfo];
                           if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                           }
                           [self.baoDanNianTabV reloadData];
                           [self custemFrame];
                       });
        
    });
    
}

-(void)custemFrame{
    if (35*self.tabvArray.count>600) {
        self.baoDanNianTabV.frame=CGRectMake(0, 35, 776, 385);
        //self.quanxuanView.frame = CGRectMake(0, 420, 776, 35);
        //self.quddingBtn.frame = CGRectMake(686, 440+35, 90, 35);
        
    }else{
        self.baoDanNianTabV.frame=CGRectMake(0, 35, 776, 35*self.tabvArray.count);
        //self.quanxuanView.frame = CGRectMake(0, 35*self.quanArray.count-104, 776, 35);
        //self.quddingBtn.frame = CGRectMake(681, 35*self.quanArray.count+50-104, 90, 35);
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.tabvArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BaoDanNianDuViewCell  *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[BaoDanNianDuViewCell alloc] initWithFrame:CGRectMake(0, 0, 776, 35)];
    }
    cell.backgroundColor = [UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1];
    id<TPLSendWayBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
    
    cell.numberLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
    cell.danhaoLabel.text = dic.policyCode;
    cell.baorenLabel.text = dic.insurantName;
    if ([dic.liabilityState isEqualToString:@"1"])
    {
       cell.zhuangtaiLabel.text = @"有效";
    }
    else if ([dic.liabilityState isEqualToString:@"2"])
    {
       cell.zhuangtaiLabel.text = @"停效";
    }
    else
    {
       cell.zhuangtaiLabel.text = @"终止";
    }
//
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:( NSIndexPath *)indexPath
{
    
    if (baoXiangQingView)
    {
        [baoXiangQingView removeFromSuperview];
    }
     baoXiangQingView= [[[NSBundle mainBundle] loadNibNamed:@"BaoDanNianDuBaoGaoView" owner:self options:nil] objectAtIndex:1];
    
    //此处将获得到的数据传给详情
    if (self.pageTag == 103)
    {
        baoXiangQingView.xiangQingTag = 103;
        id<TPLSendWayBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
        baoXiangQingView.huoDeDic = dic;
    }
    else if (self.pageTag == 104)
    {
        baoXiangQingView.xiangQingTag = 104;
        id<TPLSendWayBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
        baoXiangQingView.huoDeDic = dic;
    }
    else
    {
        baoXiangQingView.xiangQingTag = 105;
        id<TPLSendWayBOModel>dic = [self.tabvArray objectAtIndex:indexPath.row];
        baoXiangQingView.huoDeDic = dic;
    }
    //"发送方式变更查询(1代表保单年度报告发送方式变更，3代表转账成功通知书发送方式变更，
    //4代表失效通知书发送方式变更)"
    baoXiangQingView.alpha=1;
    [baoXiangQingView sizeToFit];
//    if (baoXiangQingView.xiangQingTag == 103)
//    {
//
//    }
//    else if (baoXiangQingView.xiangQingTag == 104)
//    {
//        baoXiangQingView.huodeDic = [self.tabvArray objectAtIndex:indexPath.row];
//    }
//    else
//    {
//       baoXiangQingView.huodeDic = [self.tabvArray objectAtIndex:indexPath.row];
//    
//    }
    
    baoXiangQingView.tag=20000;
    baoXiangQingView.frame = CGRectMake(1024, 64, 1024, 704);
    baoXiangQingView.backgroundColor = [UIColor clearColor];
    
    
    [[self superview] addSubview:baoXiangQingView];
    
    [UIView animateWithDuration:1 animations:^
     {
         
         baoXiangQingView.frame = CGRectMake(0, 64, 1024, 704);
         
         
     } completion:^(BOOL finished)
     {
         nil;
     }];
    

}


@end


@implementation BaoDanNianDuViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self=[[[NSBundle mainBundle] loadNibNamed:@"BaoDanNianDuBaoGaoView" owner:nil options:nil] objectAtIndex:2];
    if (self) {
        [self setFrame:frame];
    }
    return self;
}

@end


@implementation BaoDanNianDuXiangQingView

{
    BjcaInterfaceView *mypackage;//CA拍照
}


+(BaoDanNianDuXiangQingView *)awakeFromNib
{
    
    return [[[NSBundle mainBundle] loadNibNamed:@"BaoDanNianDuBaoGaoView" owner:nil options:nil] objectAtIndex:1];
    
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
    self.zhiZhiBtn.layer.cornerRadius = 10;
    self.zhiZhiBtn.layer.masksToBounds = 10;
    self.zhiZhiBtn.backgroundColor = [UIColor grayColor];
    
    self.youXiangBtn.layer.cornerRadius = 10;
    self.youXiangBtn.layer.masksToBounds = 10;
    self.youXiangBtn.backgroundColor = [UIColor grayColor];
    
    self.ziZhuBtn.layer.cornerRadius = 10;
    self.ziZhuBtn.layer.masksToBounds = 10;
    self.ziZhuBtn.backgroundColor = [UIColor grayColor];
   // self.huoDeDic = [[NSDictionary alloc] init];
    NSLog(@" huode %@ ",self.huoDeDic);
    
    if (self.xiangQingTag == 103)
    {
        self.gongyongLabel.text = @"保单年度报告";
        self.duanXinBtn.hidden = YES;
        self.duanXinYesLabel.hidden = YES;
        UILabel *duanLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 36, 141, 35)];
        duanLabel.textAlignment = NSTextAlignmentCenter;
        duanLabel.text = @"--";
        [self.addBtnView addSubview:duanLabel];
        //根据获取到的数据设置图片
        if ([self.huoDeDic.paperNotice isEqualToString:@"Y"])
        {
            [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
          [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
        if ([self.huoDeDic.emailNotice isEqualToString:@"Y"])
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        if ([self.huoDeDic.selfNotice isEqualToString:@"Y"])
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
        
    }
    else if (self.xiangQingTag == 104)
    {
       self.duanXinBtn.hidden = NO;
       self.duanXinYesLabel.hidden = NO;
       self.gongyongLabel.text = @"转账成功通知书";
        if ([self.huoDeDic.paperNotice isEqualToString:@"Y"])
        {
            [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
        if ([self.huoDeDic.emailNotice isEqualToString:@"Y"])
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        if ([self.huoDeDic.selfNotice isEqualToString:@"Y"])
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
        if ([self.huoDeDic.smsNotice isEqualToString:@"Y"])
        {
            [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
    }
    else
    {
      self.gongyongLabel.text = @"失效通知书";
      self.duanXinBtn.hidden = YES;
      self.duanXinYesLabel.hidden = YES;
      UILabel *duanLabel = [[UILabel alloc] initWithFrame:CGRectMake(285, 36, 141, 35)];
      duanLabel.textAlignment = NSTextAlignmentCenter;
      duanLabel.text = @"--";
      [self.addBtnView addSubview:duanLabel];
       
        if ([self.huoDeDic.paperNotice isEqualToString:@"Y"])
        {
            [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
        if ([self.huoDeDic.emailNotice isEqualToString:@"Y"])
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        if ([self.huoDeDic.selfNotice isEqualToString:@"Y"])
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
        }
        
    }
    //NSLog(@" ooooooooo%d ",self.xiangQingTag);
    
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.titleLabel.text = self.huoDeDic.policyCode;
    
    
    
    
}



- (IBAction)queRenBtnClick:(id)sender
{
    
   // NSLog(@"888888888 %d",self.xiangQingTag);
    
    [self updateNumber];
    
    //[self removeFromSuperview];
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    messV.delegate=self;
    messV.backgroundColor = [UIColor clearColor];
    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    [threeVC.view addSubview:messV];
    
}

- (void)updateNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,BAODANBIANGENG]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> changeReturnBO=nil;
        @try {
            
      
            NSString *danHao = self.huoDeDic.policyCode;
//            NSString *userName = [TPLSessionInfo shareInstance].isUserExt.userName;
//            NSString *realName = [TPLSessionInfo shareInstance].isUserExt.realName;
//            NSString *userCate = [TPLSessionInfo shareInstance].userCate;
            
            NSString *userName = @"2222";
            NSString *realName = @"2222";
            NSString *userCate = @"2222";
            
            if (self.xiangQingTag == 103)
            {
                changeReturnBO=[remoteService updatePolicyYearReportWithPolicyCode:danHao andNotiveWay:self.noticeWayString andNoticeType:@"1" andUserCate:userCate andUserName:userName andRealName:realName];
                
            }
            else if (self.xiangQingTag == 104)
            {
                 changeReturnBO=[remoteService updatePolicyYearReportWithPolicyCode:danHao andNotiveWay:self.noticeWayString andNoticeType:@"3" andUserCate:userCate andUserName:userName andRealName:realName];
                
            }
            else
            {
                changeReturnBO=[remoteService updatePolicyYearReportWithPolicyCode:danHao andNotiveWay:self.noticeWayString andNoticeType:@"4" andUserCate:userCate andUserName:userName andRealName:realName];
                
            }
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
          NSLog(@">>>>>>>>>>>>>bdndz000mc%@",changeReturnBO);
//        for (int i=0; i<changeReturnBO.objList.count; i++)
//        {
//            id<TPLSendWayBOModel>dic=[changeReturnBO.objList objectAtIndex:i];
//            [self.tabvArray addObject:dic];
//            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            //            NSLog(@"%@",dic);
//        }
   
        dispatch_async(dispatch_get_main_queue(), ^
                       {
//                           NSString *errorStr = [changeReturnBO.errorBean errorInfo];
                           if ([changeReturnBO.returnFlag isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:changeReturnBO.returnMessage delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                           }
                           
                           
                          // [self.baoDanNianTabV reloadData];
                          // [self custemFrame];
                       });
        
    });
    
}


- (IBAction)yinCangBtnClick:(id)sender
{
    [UIView animateWithDuration:1 animations:^{
        self.frame = CGRectMake(1024, 64, 1024, 704);
        
    } completion:^(BOOL finished) {
        
    }];
    
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


- (IBAction)zhiZhiBtnClick:(id)sender
{
    self.noticeWayString = @"纸质告知";
    
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    
    
}

- (IBAction)youXiangBtnClick:(id)sender
{
    
    self.noticeWayString = @"电子邮箱";
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    
    
}

- (IBAction)ziZhuBtnClick:(id)sender
{
   
    self.noticeWayString = @"自助查询";
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    
    
}

- (IBAction)duanXinBtnClick:(id)sender
{
    
    self.noticeWayString = @"短信告知";
    [self.duanXinBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    
}


@end




