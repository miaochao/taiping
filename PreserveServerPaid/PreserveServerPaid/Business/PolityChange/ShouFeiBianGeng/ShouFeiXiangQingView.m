//
//  ShouFeiXiangQingView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "ShouFeiXiangQingView.h"
#import "MessageTestView.h"
#import "ThreeViewController.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"

#define SHOUFEIXIANGQINGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"

@implementation ShouFeiXiangQingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//+(instancetype)sharedManager{
//    static ShouFeiXiangQingView *sharedAccountManagerInstance = nil;
//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        sharedAccountManagerInstance = (ShouFeiXiangQingView *)[ShouFeiXiangQingView awakeFromNib];
//    });
//    return sharedAccountManagerInstance;
//}



//+(UIView*)awakeFromNib{
//    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ShouFeiXiangQingView" owner:self options:nil];
//    
//    ShouFeiXiangQingView *shouFeiView = [array lastObject];
//   
//    shouFeiView.chargView = [ChargeView awakeFromNib];
//    shouFeiView.chargView.frame=CGRectMake(0, 35, 712, 166);
//    shouFeiView.chargView.upOrdown = NO;
//    [shouFeiView.chargView createBtn];
//    
//    shouFeiView.bianGengView.layer.borderWidth = 1;
//    shouFeiView.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
//    
//    [shouFeiView.smallXiangView addSubview:shouFeiView.chargView];
//    return shouFeiView;
//}
{

  BjcaInterfaceView *mypackage;//CA拍照
}


+(ShouFeiXiangQingView *)awakeFromNib
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShouFeiXiangQingView" owner:nil options:nil] objectAtIndex:0];
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
    
    self.detailArray = [[NSMutableArray alloc] init];
    self.chargView = [ChargeView awakeFromNib];
    self.chargView.frame=CGRectMake(0, 35, 712, 166);
    self.chargView.upOrdown = NO;
    [self.chargView createBtn];
    
    self.bianGengView.layer.borderWidth = 1;
    self.bianGengView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    [self.smallXiangView addSubview:self.chargView];
    
    
    
}

- (IBAction)bianGengBtnClick:(id)sender
{
    if ([self.chargView.bankTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属银行！"];
        return;
    }
    if ([self.chargView.acountTextField.text isEqualToString:@""])
    {
        [self alertView:@"请输入收费账号！"];
        return;
    }
    if ([self.chargView.organizationTextField.text isEqualToString:@""])
    {
        [self alertView:@"请选择账号所属机构！"];
        return;
    }
    
    [self requestNumber];
    
    
  

}



-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

-(void)massageTest{
//    WriteNameView  *view=[[WriteNameView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
//    view.delegate=self;
//    [[self superview] addSubview:view];
//    self.alpha=0;
    [mypackage reset];//先清空之前的数据
    [self startinterface];
    
}
-(void)writeNameEnd{
    BaoQuanPiWenView *view=(BaoQuanPiWenView *)[BaoQuanPiWenView awakeFromNib];
    //    view.frame
    [[self superview] addSubview:view];
    
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
        
    }];
    
}

- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,SHOUFEIXIANGQINGURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> ChangeReturnBO=nil;
        @try {
            
//            NSDictionary * custmerDic = [[TPLSessionInfo shareInstance] custmerDic];
//            NSLog(@"  内容%@ ",custmerDic);
            NSDictionary *shoufeiDic = [self.detailArray objectAtIndex:0];
            
            ChangeReturnBO=[remoteService updateChargeAccountWithPolicyCode:[shoufeiDic objectForKey:@"policyCode"] addressFee:@"addressFee" zipLink:@"zipLink" bankCode:self.chargView.bankTextField.text bankAccount:self.chargView.acountTextField.text accoOwnername:[shoufeiDic objectForKey:@"accountOwner"] accountType:[shoufeiDic objectForKey:@"accountType"] organId:self.chargView.organizationTextField.text bizChannel:@"bizChannel" ecsOperator:@"ecsOperator"];
            
            
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>mmmmc%@",ChangeReturnBO);
        NSLog(@">>>>>>>>>>>>>mmmmc%@",ChangeReturnBO.returnMessage);
       // [self custemFrame];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
//                           NSString *errorStr = [ChangeReturnBO.errorBean errorInfo];
//                           if ([[ChangeReturnBO.errorBean errorCode] isEqualToString:@"1"])
//                           {
//                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//                               [alert show];
//                             
                           
                               // NSLog(@"收费账号%@",listBOModel.objList);
                           
                           //}
                        
                           MessageTestView *messV = [[MessageTestView alloc] init];
                           messV.frame = CGRectMake(0, 0, 1024, 768);
                           
                           messV.delegate=self;
                           messV.backgroundColor = [UIColor clearColor];
                           
                           //    ThreeViewController *threeVC = [ThreeViewController sharedManager];
                           //    [threeVC.view addSubview:messV];
                           [[self superview] addSubview:messV];
                           //    [self removeFromSuperview];
    
                           
                           
                       });

        
    });
}

@end
