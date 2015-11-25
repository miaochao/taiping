//
//Users/wondertek/Documents/ 苗超/PreserveServerPaid/PreserveServerPaid.xcodeproj/  BaoDanXiangQingView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/24.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "BaoDanXiangQingView.h"
#import "MessageTestView.h"
#import "ThreeViewController.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"

#define YONGJIUXIANGQING @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"


@implementation BaoDanXiangQingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//+(instancetype)sharedManager{
//    static BaoDanXiangQingView *sharedAccountManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        sharedAccountManagerInstance = [[self alloc] init];
//    });
//    return sharedAccountManagerInstance;
//}

{

      BjcaInterfaceView *mypackage;//CA拍照

}

+(BaoDanXiangQingView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"BaoDanXiangQingView" owner:nil options:nil] objectAtIndex:0];
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
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.zhiZhiBtn.layer.cornerRadius = 10;
    self.zhiZhiBtn.layer.masksToBounds = 10;
    self.zhiZhiBtn.backgroundColor = [UIColor grayColor];
    
    self.youXiangBtn.layer.cornerRadius = 10;
    self.youXiangBtn.layer.masksToBounds = 10;
    self.youXiangBtn.backgroundColor = [UIColor grayColor];
    
    self.ziZhuBtn.layer.cornerRadius = 10;
    self.ziZhuBtn.layer.masksToBounds = 10;
    self.ziZhuBtn.backgroundColor = [UIColor grayColor];
   // [self.bianGengBtn addTarget:self action:@selector(bianGengBtnClick::) forControlEvents:UIControlEventTouchUpInside];
    
    NSLog(@" 保单 %@",self.detailDic);
    
    if ([[self.detailDic objectForKey:@"paperNotice"] isEqualToString:@"Y"])
    {
        [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
    }
    
    if ([[self.detailDic objectForKey:@"emailNotice"] isEqualToString:@"Y"])
    {
        [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
    }
    if ([[self.detailDic objectForKey:@"selfNotice"] isEqualToString:@"Y"])
    {
        [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji.png"] forState:UIControlStateNormal];
    }
    
    
}
/*
-(id)init
{
    self = [super init];
 
    if (self)
    {
 
        self = [[[NSBundle mainBundle] loadNibNamed:@"BaoDanXiangQingView" owner:nil options:nil] lastObject];
    //圆形  和  边框
        self.bianGengView.layer.borderWidth = 1;
        self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
        
//        self.xinJianLabel.layer.borderWidth = 1;
//        self.xinJianLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.zhiZhiLabel.layer.borderWidth = 1;
//        self.zhiZhiLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.duanXinLabel.layer.borderWidth = 1;
//        self.duanXinLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.youXiangLabel.layer.borderWidth = 1;
//        self.youXiangLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.ziZhuLabel.layer.borderWidth = 1;
//        self.ziZhuLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        
//        self.tongZhiShuLabel.layer.borderWidth = 1;
//        self.tongZhiShuLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.zhiZhiQueRenLabel.layer.borderWidth = 1;
//        self.zhiZhiQueRenLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.gaoZhiLabel.layer.borderWidth = 1;
//        self.gaoZhiLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.youXiangQueRenLabel.layer.borderWidth = 1;
//        self.youXiangQueRenLabel.layer.borderColor = [[UIColor grayColor] CGColor];
//        self.ziZhuQueRenLabel.layer.borderWidth = 1;
//        self.ziZhuQueRenLabel.layer.borderColor = [[UIColor grayColor] CGColor];
        
//        btn.layer.cornerRdius = width/2.0;
//        btn.layer.maskToBounds = width/2.0；
        
        self.zhiZhiBtn.layer.cornerRadius = 10;
        self.zhiZhiBtn.layer.masksToBounds = 10;
        self.zhiZhiBtn.backgroundColor = [UIColor grayColor];
        
        self.youXiangBtn.layer.cornerRadius = 10;
        self.youXiangBtn.layer.masksToBounds = 10;
        self.youXiangBtn.backgroundColor = [UIColor grayColor];
        
        self.ziZhuBtn.layer.cornerRadius = 10;
        self.ziZhuBtn.layer.masksToBounds = 10;
        self.ziZhuBtn.backgroundColor = [UIColor grayColor];
        
    }
    
    return self;
}
*/
 
 

- (IBAction)queRenBtnClick:(id)sender
{
   [self requestNumberWithnoticeWay:self.fangshiStr noticeType:self.leixingStr];
    
    
//    MessageTestView *messV = [[MessageTestView alloc] init];
//    messV.frame = CGRectMake(0, 0, 1024, 768);
//    messV.delegate=self;
//    messV.backgroundColor = [UIColor clearColor];
//    ThreeViewController *threeVC = [ThreeViewController sharedManager];
//    [threeVC.view addSubview:messV];
    
   
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
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    self.fangshiStr = @"纸质报告";
    self.leixingStr = @"Y";
    
}

- (IBAction)youXiangBtnClick:(id)sender
{
    
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    self.fangshiStr = @"电子邮箱";
    self.leixingStr = @"Y";
  
}

- (IBAction)ziZhuBtnClick:(id)sender
{
//    [self.zhiZhiBtn setBackgroundColor:[UIColor grayColor]];
//    [self.youXiangBtn setBackgroundColor:[UIColor grayColor]];
//    [self.ziZhuBtn setBackgroundColor:[UIColor blueColor]];
    [self.zhiZhiBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.youXiangBtn setImage:[UIImage imageNamed:@"danxuan weidianji"] forState:UIControlStateNormal];
    [self.ziZhuBtn setImage:[UIImage imageNamed:@"danxuan dianji"] forState:UIControlStateNormal];
    
    self.fangshiStr = @"自助查询";
    self.leixingStr = @"Y";
    
}

- (void)requestNumberWithnoticeWay:(NSString *)fangshi noticeType:(NSString *)leiXing 
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,YONGJIUXIANGQING]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> ChangeReturnBOModel=nil;
        @try {
            
           // NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            NSString *policyC = [self.detailDic objectForKey:@"policyCode"];
            //NSString *userName = [dic objectForKey:@"customerId"];
            ChangeReturnBOModel=[remoteService updateNoticeWayWithPolicyCode:policyC noticeWay:fangshi noticeType:leiXing bizChannel:@"bizChannel" ecsOperator:@"ecsOperator"];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
   
        NSLog(@"yyyjjj%@",ChangeReturnBOModel);
        dispatch_async(dispatch_get_main_queue(), ^
                       {
//                           NSString *errorStr = [ChangeReturnBOModel.errorBean errorInfo];
//                           if ([[ChangeReturnBOModel.errorBean errorCode] isEqualToString:@"1"])
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                               [alert show];
//                               
//                               
//                               [self.baoDanTabelView reloadData];
//                               
//
//                               
//                               [self custemFrame];
//                           }
//                           return;
                       });
        
    });
    
    
}


@end
