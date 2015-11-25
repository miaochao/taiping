//
//  ShoujiYouxiangBianGengView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "ShoujiYouxiangBianGengView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"


#define SHOUJIYOUXIANGURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"
@implementation ShoujiYouxiangBianGengView
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

+(ShoujiYouxiangBianGengView *)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShoujiYouxiangBianGengView" owner:nil options:nil] objectAtIndex:0];
}


- (void)sizeToFit{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
    
    [self custemView];
}

- (void)custemView
{
    
    self.smallBianView.layer.borderWidth = 1;
    self.smallBianView.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.shouJiTf.frame = CGRectMake(216, 28, 451, 39);
    self.shouJiTf.text = @"15033695689";
    self.youxiangTf.frame = CGRectMake(216, 108, 451, 39);
    self.youxiangTf.text = @"xxxxx@163.com";
    self.shouJiTf.borderStyle = UITextBorderStyleNone;
    self.shouJiTf.layer.borderWidth = 1;
    self.shouJiTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.youxiangTf.borderStyle = UITextBorderStyleNone;
    self.youxiangTf.layer.borderWidth = 1;
    self.youxiangTf.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    self.address=self.youxiangTf.text;
    self.postcode=self.shouJiTf.text;
 
    [self requestNumber];
}


- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,SHOUJIYOUXIANGURL]];
    
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
            basicBOModel=[remoteService queryCustomerWithAgentId:@"" andPolicyCode:@"" andRealName:[dic objectForKey:@"realName"] andGender:gender andBirthday:birthday andAuthCertiCode:[dic objectForKey:@"certiCode"]];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        NSLog(@">>>>>>>>>>>>>lqtlzmc%@",basicBOModel);
//        for (int i=0; i<listBOModel.objList.count; i++) {
//            [self.quanArray addObject:[listBOModel.objList objectAtIndex:i]];
//            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            NSLog(@"%@",dic);
//        }
        // receiveArray=[NSMutableArray arrayWithArray:self.tabArray];
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                           NSString *errorStr = [basicBOModel.error errorInfo];
                           if ([[basicBOModel.error errorCode] isEqualToString:@"1"])
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:errorStr delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
                               [alert show];
                               return;
                               
                               // NSLog(@"收费账号%@",listBOModel.objList);
                               
                           }else{
                               customer=basicBOModel.basic;
                               self.shouJiTf.text=customer.mobile;
                               self.youxiangTf.text=customer.email;
                           }
                      
                          
                       });
        
    });
    
}



- (IBAction)biangengBtnClick:(id)sender
{
    
    if ([self.postcode isEqualToString:self.shouJiTf.text]&&[self.address isEqualToString:self.youxiangTf.text]) {
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
            
            listBOModel=[remoteService updateCustomerWithCustomerId:[dic objectForKey:@"customerId"] andPolicyCode:@"1" andJobAddress:customer.jobAddress andJobZip:customer.jobZip andJobPhone:customer.jobPhone andAddress:customer.address andZip:customer.zip andTell:customer.phone andCeller:self.shouJiTf.text andEmail:self.youxiangTf.text andUserCate:[TPLSessionInfo shareInstance].userCate andUserName:[TPLSessionInfo shareInstance].isUserExt.userName andRealName:[TPLSessionInfo shareInstance].isUserExt.realName];
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



-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

@end
