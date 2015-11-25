//
//  FamilyChangeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/29.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "FamilyChangeView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "PreserveServer-Prefix.pch"
#import "ThreeViewController.h"

#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.QueryPreserveServlet"
#define CHANGEURL @"/servlet/hessian/com.cntaiping.intserv.custserv.preserve.UpdatePreserveServlet"
@implementation FamilyChangeView
{
    id<TPLCustomerBOModel>customer;
    
    BjcaInterfaceView *mypackage;//CA拍照
}
+(FamilyChangeView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"FamilyChangeView" owner:nil options:nil] lastObject];
}
-(void)sizeToFit{
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
            NSLog(@"%@",exception);
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
                self.addressTF.text=customer.address;
                self.postcodeTF.text=customer.zip;
                self.phoneTF.text=customer.phone;
                NSLog(@"%@,%@",customer.zip,customer.phone);
                
                self.address=self.addressTF.text;
                self.postcode=self.postcodeTF.text;
                self.phone=self.phoneTF.text;
                
            }
        });
        
    });
    
}
-(void)custemView{
    self.backView.layer.borderWidth=1;
    self.backView.layer.borderColor=[[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1] CGColor];
    self.addressTF.layer.borderWidth=1;
    self.addressTF.layer.borderColor=[[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1] CGColor];
    self.phoneTF.layer.borderWidth=1;
    self.phoneTF.layer.borderColor=[[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1] CGColor];
    self.postcodeTF.layer.borderWidth=1;
    self.postcodeTF.layer.borderColor=[[UIColor colorWithRed:198/255.0 green:198/255.0 blue:198/255.0 alpha:1] CGColor];
    
    self.addressTF.layer.borderWidth = 1;
    self.addressTF.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.postcodeTF.layer.borderWidth = 1;
    self.postcodeTF.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    self.phoneTF.layer.borderWidth = 1;
    self.phoneTF.layer.borderColor = [[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1] CGColor];
    
    
    [self request];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
//    addressTF.alpha=0;
//    postcodeTF.alpha=0;
//    numberTF.alpha=0;
//    textField.alpha=1;
//    rect=textField.frame;
//    textField.frame=CGRectMake(208, 147, 450, 40);
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
//    addressTF.alpha=1;
//    postcodeTF.alpha=1;
//    numberTF.alpha=1;
//    textField.frame=rect;
}
- (IBAction)btnClick:(UIButton *)sender {
    [self changeRequest];
    if (self.addressTF.text.length<=0) {
        [self alertView:@"请填写地址信息"];
        return;
    }
    if (self.postcodeTF.text.length<=0) {
        [self alertView:@"请填写邮编"];
        return;
    }
    if (self.phoneTF.text.length<=0) {
        [self alertView:@"请填写电话号码"];
        return;
    }
    if ([self.address isEqualToString:self.addressTF.text]&&[self.postcode isEqualToString:self.postcodeTF.text]&&[self.phone isEqualToString:self.phoneTF.text]) {
        [self alertView:@"您未变更任何信息"];
        return;
    }
    
    //短信验证
    MessageTestView *view=[[MessageTestView alloc] init];
    view.frame=CGRectMake(0, 0, 1024, 768);
    view.delegate=self;
    [[self superview] addSubview:view];
    
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
            
            listBOModel=[remoteService updateCustomerWithCustomerId:[dic objectForKey:@"customerId"] andPolicyCode:@"1" andJobAddress:customer.jobAddress andJobZip:customer.jobZip andJobPhone:customer.jobPhone andAddress:self.addressTF.text andZip:self.phoneTF.text andTell:self.postcodeTF.text andCeller:customer.mobile andEmail:customer.email andUserCate:[TPLSessionInfo shareInstance].userCate andUserName:[TPLSessionInfo shareInstance].isUserExt.userName andRealName:[TPLSessionInfo shareInstance].isUserExt.realName];
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
    BaoQuanPiWenView *view=[BaoQuanPiWenView awakeFromNib];
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
-(void)alertView:(NSString *)str{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alertV show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
