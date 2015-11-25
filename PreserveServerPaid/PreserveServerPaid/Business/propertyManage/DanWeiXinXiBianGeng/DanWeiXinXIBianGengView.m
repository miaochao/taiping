//
//  DanWeiXinXIBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "DanWeiXinXIBianGengView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"


#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"
@implementation DanWeiXinXIBianGengView
{
    id<TPLCustomerBOModel>customer;
    
    BjcaInterfaceView *mypackage;//CA拍照
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


+(DanWeiXinXIBianGengView *)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"DanWeiXinXIBianGengView" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    [self custemView];
}
-(void)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLBasicBOModel> basicBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *birthday = [dateFormatter dateFromString:[dic objectForKey:@"brithday"]];
            int gender=0;//性别，0表示女
            if ([[dic objectForKey:@"gender"] isEqualToString:@"M"]) {
                gender=1;//表示男
            }
            basicBOModel=[remoteService queryCustomerWithAgentId:@"" andPolicyCode:@"" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"] ];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>%@",basicBOModel);
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[basicBOModel.error errorCode] isEqualToString:@"1"]) {
                //表示请求出错
                UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[basicBOModel.error errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alertV show];
            }else{
                customer=basicBOModel.basic;
                self.dizhiTf.text=customer.jobAddress;
                self.youbianTf.text=customer.jobZip;
                self.dianhuaTf.text=customer.jobPhone;
            }
        });
        
    });
    
}
- (void)custemView
{
    self.smallDanWeiView.layer.borderWidth = 1;
    self.smallDanWeiView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.dizhiTf = [[UITextField alloc] init];
    self.dizhiTf.frame = CGRectMake(185, 28, 460, 39);
    self.dizhiTf.font = [UIFont systemFontOfSize:14];
    self.dizhiTf.text = @"上海市浦东新区卡园三路";
    self.dizhiTf.borderStyle = UITextBorderStyleNone;
    self.dizhiTf.layer.borderWidth = 1;
    self.dizhiTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    [self.smallDanWeiView addSubview:self.dizhiTf];
    
    self.youbianTf = [[UITextField alloc] init];
    self.youbianTf.frame = CGRectMake(185, 108, 460, 39);
    self.youbianTf.font = [UIFont systemFontOfSize:14];
    self.youbianTf.text = @"454650";
    self.youbianTf.borderStyle = UITextBorderStyleNone;
    self.youbianTf.layer.borderWidth = 1;
    self.youbianTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    [self.smallDanWeiView addSubview:self.youbianTf];
    
    self.dianhuaTf = [[UITextField alloc] init];
    self.dianhuaTf.frame = CGRectMake(185, 189, 460, 39);
    self.dianhuaTf.font = [UIFont systemFontOfSize:14];
    self.dianhuaTf.text = @"021-545581425";
    self.dianhuaTf.borderStyle = UITextBorderStyleNone;
    self.dianhuaTf.layer.borderWidth = 1;
    self.dianhuaTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    [self.smallDanWeiView addSubview:self.dianhuaTf];
    
    self.address=self.dizhiTf.text;
    self.postcode=self.youbianTf.text;
    self.phone=self.dianhuaTf.text;
    
    [self request];
}

- (IBAction)queDingDanWeiBtnClick:(id)sender
{
   
    
    if ([self.address isEqualToString:self.dizhiTf.text]&&[self.postcode isEqualToString:self.youbianTf.text]&&[self.phone isEqualToString:self.dianhuaTf.text]) {
        [self alertView:@"您未变更任何信息"];
        return;
    }
    [self changeRequest];
    MessageTestView *messV = [[MessageTestView alloc] init];
    messV.frame = CGRectMake(0, 0, 1024, 768);
    
    messV.delegate=self;
    messV.backgroundColor = [UIColor clearColor];
    
    //    ThreeViewController *threeVC = [ThreeViewController sharedManager];
    //    [threeVC.view addSubview:messV];
    [[self superview] addSubview:messV];
    //    [self removeFromSuperview];
    
}
//确定变更请求
-(void)changeRequest{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,CHANGEURL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLChangeReturnBOModel> listBOModel=nil;
        @try {
            NSDictionary *dic=[[TPLSessionInfo shareInstance] custmerDic];
            
            listBOModel=[remoteService updateCustomerWithCustomerId:[dic objectForKey:@"customerId"] andPolicyCode:@"1" andJobAddress:self.dizhiTf.text andJobZip:self.youbianTf.text andJobPhone:self.dianhuaTf.text andAddress:customer.address andZip:customer.zip andTell:customer.phone andCeller:customer.mobile andEmail:customer.email andUserCate:[TPLSessionInfo shareInstance].userCate andUserName:[TPLSessionInfo shareInstance].isUserExt.userName andRealName:[TPLSessionInfo shareInstance].isUserExt.realName];
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


-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}


@end
