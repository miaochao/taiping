//
//  MessageTestView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/21.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "MessageTestView.h"

#define MESSAGETESTURL @"/servlet/hessian/com.cntaiping.intserv.custserv.sms.SmsServlet"

@implementation MessageTestView


- (id)init
{
    self = [super init];
    if (self)
    {
        
        self.messageTouMingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 768)];
        self.messageTouMingView.alpha = 0.5;
        self.messageTouMingView.backgroundColor = [UIColor grayColor];
        [self addSubview:self.messageTouMingView];
        
        self.smallMessageView = [[UIView alloc] initWithFrame:CGRectMake(300, 275, 437, 200)];
        self.smallMessageView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.smallMessageView];
        
//        self.yiChuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.yiChuBtn.frame = CGRectMake(403, 1, 30, 30);
//        [self.yiChuBtn setImage:[UIImage imageNamed:@"guanbi.png"] forState:UIControlStateNormal];
//        [self.yiChuBtn addTarget:self action:@selector(yiChuBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [self.smallMessageView addSubview:self.yiChuBtn];
        
        
        self.yanZhengMaLabel = [[UILabel alloc] initWithFrame:CGRectMake(160, 30, 118, 23)];
        self.yanZhengMaLabel.text = @"验证码校验";
       // self.yanZhengMaLabel.backgroundColor = [UIColor colorWithRed:0 green:108/255.0 blue:183/255.0 alpha:1];
        [self.smallMessageView addSubview:self.yanZhengMaLabel];
        
        self.yanZhengMaTF = [[UITextField alloc] initWithFrame:CGRectMake(45, 66, 228, 35)];
        self.yanZhengMaTF.placeholder = @"请输入验证码";
        self.yanZhengMaTF.layer.borderColor=[[UIColor blackColor]CGColor];
        self.yanZhengMaTF.layer.borderWidth= 1.0f;
        [self.smallMessageView addSubview:self.yanZhengMaTF];
        
        self.restTimeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.restTimeBtn.frame = CGRectMake(280, 66, 120, 35);
        //self.restTimeBtn.backgroundColor = [UIColor colorWithRed:0 green:108/255.0 blue:183/255.0 alpha:1];
        self.restTimeBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
        [self.restTimeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.restTimeBtn addTarget:self action:@selector(restTimeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.smallMessageView addSubview:self.restTimeBtn];
        
        self.yiChuBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.yiChuBtn.frame = CGRectMake(100, 138, 66, 30);
        [self.yiChuBtn setTitle:@"取消" forState:UIControlStateNormal];
        self.yiChuBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
        [self.yiChuBtn addTarget:self action:@selector(yiChuBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.smallMessageView addSubview:self.yiChuBtn];
        
        self.queRenBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //self.queRenBtn.frame = CGRectMake(187, 138, 66, 30);
        self.queRenBtn.frame = CGRectMake(280, 138, 66, 30);
        //self.queRenBtn.backgroundColor = [UIColor colorWithRed:0 green:108/255.0 blue:183/255.0 alpha:1];
        self.queRenBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:255/255.0 alpha:1];
        [self.queRenBtn setTitle:@"确认" forState:UIControlStateNormal];
        [self.queRenBtn addTarget:self action:@selector(queRenBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.smallMessageView addSubview:self.queRenBtn];

        
    }

    return self;
}


- (void)restTimeBtnClick
{
    
    
    
    self.yanZhengMaTF.text=@"000000";//假的验证码
    if (self.restTimeBtn.enabled) {
        //能点击获取验证码
        if (!_messageTimer) {
            _messagetimeOver=60;
            //self.restTimeBtn.enabled=NO;
            //[self.textBtn setBackgroundColor:[UIColor redColor]];
            _messageTimer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
            [_messageTimer fire];
        }
    }
}

-(void)timerClick
{
    
    [self.restTimeBtn setTitle:[NSString stringWithFormat:@"剩余%d秒",_messagetimeOver] forState:UIControlStateNormal];
    _messagetimeOver--;
    
    if (_messagetimeOver <0) {
        self.restTimeBtn.enabled=YES;
        [self.restTimeBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        
        [_messageTimer invalidate];
        _messageTimer=nil;
    }
    

}

- (void)requestNumber
{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURLS,MESSAGETESTURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLErrorBOModel> errorBOModel=nil;
        @try {
            
            NSDictionary *dic = [[TPLSessionInfo shareInstance] custmerDic];
            NSLog(@"输出  %@",dic);
           
            
            //errorBOModel=[remoteService sendChangeSmsCodeWithUserName:<#(NSString *)#> andCustomerId:[dic objectForKey:@"customerId"]; andMenuName:<#(NSString *)#>];
            
        }
        @catch (NSException *exception)
        {
            
        }
        @finally
        {
        }
        //  NSLog(@">>>>>>>>>>>>>lqtlzmc%@",listBOModel);
//        for (int i=0; i<listBOModel.objList.count; i++)
//        {
//            [self.tabvArray addObject:[listBOModel.objList objectAtIndex:i]];
//            //            NSDictionary *dic=[listBOModel.objList objectAtIndex:i];
//            //            NSLog(@"%@",dic);
//        }
//        NSLog(@"hlxxxxxxxxxz%@",listBOModel.objList);
//        NSLog(@" 9999%@ ",self.tabvArray);
        dispatch_async(dispatch_get_main_queue(), ^
                       {
                         
         
                       });
        
    });
    
}



- (void)yiChuBtnClick
{
    if (self.end>10) {
        [[self superview] removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (void)queRenBtnClick
{
    if (self.yanZhengMaTF.text.length<1) {
        [self alertViewString:@"验证码不能为空"];
        return;
    }
    [self.delegate massageTest];
    //[self removeFromSuperview];
    [self removeFromSuperview];
    
}

-(void)alertViewString:(NSString *)string{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertV show];
}


@end
