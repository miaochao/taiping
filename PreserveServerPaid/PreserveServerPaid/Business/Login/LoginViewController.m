//
//  LoginViewController.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/2.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "LoginViewController.h"
#import "MainViewController.h"
#import "CommitmentBookView.h"
#import "PreserveServer-Prefix.pch"

@interface LoginViewController ()
{
    NSString            *cateS;//登录人的类型，比如内勤、代理人
}
@property (nonatomic,strong)NSTimer     *timer;//验证码定时器
@property (nonatomic,assign)int         timeOver;//验证码时间
@property (nonatomic,assign)int         type;//表示登陆人的类型,1表示代理人 2表示内勤 3表示续收专员
@property (nonatomic,assign)BOOL        manOrWoman;
@end

@implementation LoginViewController
+(instancetype)sharedManager{
    static MainViewController *sharedAccountManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedAccountManagerInstance = [[self alloc] init];
    });
    return sharedAccountManagerInstance;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    cateS=@"999";
    _type=2;
    // Do any additional setup after loading the view from its nib.
    [self createTextField];
    [self.backView setBackgroundColor:[UIColor colorWithRed:252/255.0 green:253/255.0 blue:255/255.0 alpha:1]];
    self.nameLabel.textColor=[UIColor colorWithRed:0/255.0 green:97/255.0 blue:177/255.0 alpha:1];
    
    self.textBtn.layer.cornerRadius=8.0;//圆角
    self.loginBtn.layer.cornerRadius=8.0;
    [self.textBtn setBackgroundColor:[UIColor colorWithRed:219/255.0 green:219/255.0 blue:219/255.0 alpha:1]];
    
    //    //添加键盘的通知
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardChangeFram:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.nameTF.delegate=self;
    self.pawTF.delegate=self;
    self.textTF.delegate=self;
    self.imageV.center=self.backView.center;
    //    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    //    btn.frame=CGRectMake(0, 0, 100, 100);
    //    btn.center=self.view.center;
    //    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    //    btn.backgroundColor=[UIColor greenColor];
    //    [btn addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:btn];
    
}

//布局textField
-(void)createTextField{
    self.nameTF=[[UITextField alloc] initWithFrame:CGRectMake(141, 32, 340, 50)];
    self.nameTF.borderStyle=UITextBorderStyleRoundedRect;
    [self.backView addSubview:self.nameTF];
    self.nameTF.placeholder=@"请输入用户名";
    self.nameTF.font=[UIFont fontWithName:@"Arial" size:19.0f];
    self.nameTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;//文字上下居中
    //设置左边的图片
    UIImageView *image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yonghuming.png"]];
    self.nameTF.leftView=image;
    self.nameTF.leftViewMode = UITextFieldViewModeAlways;
    //self.nameTF.text=@"wangzz20";
    self.nameTF.text=@"huangyz";
    
    self.pawTF=[[UITextField alloc] initWithFrame:CGRectMake(141, 98, 340, 50)];
    [self.backView addSubview:self.pawTF];
    self.pawTF.borderStyle=UITextBorderStyleRoundedRect;
    self.pawTF.placeholder=@"请输入密码";
    self.pawTF.secureTextEntry=YES;
    self.pawTF.font=[UIFont fontWithName:@"Arial" size:19.0f];
    self.pawTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIImageView *image1=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mima.png"]];
    self.pawTF.leftView=image1;
    self.pawTF.leftViewMode = UITextFieldViewModeAlways;
    self.pawTF.text=@"Tp123456";
    
    self.textTF=[[UITextField alloc] initWithFrame:CGRectMake(141, 163, 185, 50)];
    [self.backView addSubview:self.textTF];
    self.textTF.keyboardType=UIKeyboardTypeNumberPad;
    self.textTF.borderStyle=UITextBorderStyleRoundedRect;
    self.textTF.placeholder=@"请输入验证码";
    self.textTF.font=[UIFont fontWithName:@"Arial" size:19.0f];
    self.textTF.contentVerticalAlignment=UIControlContentVerticalAlignmentCenter;
    UIImageView *image2=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yanzhengma.png"]];
    self.textTF.leftView=image2;
    self.textTF.leftViewMode = UITextFieldViewModeAlways;
    
    
}

//UITextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.backView.frame=CGRectMake(257, 100, 510, 301);
    self.imageV.center=self.backView.center;
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.backView.frame=CGRectMake(257, 233, 510, 301);
    self.imageV.center=self.backView.center;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
//点击获取验证码
- (IBAction)messcodePress:(id)sender {
    if (self.nameTF.text.length<1) {
        [self alertViewString:@"用户名不能为空"];
        return;
    }
    if (self.pawTF.text.length<1) {
        [self alertViewString:@"密码不能为空"];
        return;
    }
    self.textTF.text=@"000000";//假的验证码
    
    if (![self authService]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.textBtn setUserInteractionEnabled:YES];
            [self.textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
            return;
        });
    }else{
        id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,SENDMESSAGELOGIN]];
        [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
        [(CWDistantHessianObject *)remoteService resHeadDict];
        
       // NSLog(@" 99mc%@",[TPLRequestHeaderUtil otherRequestHeader]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            id<TPLErrorBOModel> errorBO=nil;
            @try {
                errorBO=[remoteService sendMessageByLoginWithUserName:self.nameTF.text andUserCate:[NSString stringWithFormat:@"%d",_type] ];
            }
            @catch (NSException *exception) {
                
            }
            @finally {
                
            }
            NSLog(@">>>>>>>>>>>>>%@",errorBO);
            NSDictionary *respDict=[(CWDistantHessianObject *)remoteService resHeadDict];
            
            NSLog(@">>>>%@",respDict);
            
            NSString *errorcode=[respDict valueForKey:@"errorcode"];
            NSString *errormsg=[respDict valueForKey:@"errormsg"];
            NSLog(@"%@-%@",errorcode,errormsg);
            if ([errorcode isEqualToString:@"90001"]) {
                //-1表示成功
                if (errorBO==nil||![errorBO.errorCode isEqualToString:@"-1"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *errStr = errorBO ? errorBO.errorInfo : @"验证码获取失败，请您重新点击获取！";
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示信息" message:errStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        [_textBtn setUserInteractionEnabled:YES];
                        [_textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        return;
                    });
                }else{
                    if (self.textBtn.enabled) {
                        //能点击获取验证码
                        if (!_timer) {
                            _timeOver=60;
                            //self.textBtn.enabled=NO;
                            //[self.textBtn setBackgroundColor:[UIColor redColor]];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                _timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerBegin) userInfo:nil repeats:YES];
                                [_timer fire];
                            });
                        }
                    }
                }
            }else{
                [self dealErrorCode:errorcode];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [_textBtn setUserInteractionEnabled:YES];
                    [_textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                    return;
                });
            }
                
                
        });

    }   
    
}
//请求移动平台接入端
- (BOOL)authService{
    NSString *userIdStr=nil;
    if (_type==2) {//代理人
        userIdStr=[[NSString alloc] initWithFormat:@"%@@agent",self.nameTF.text];
    }else {
        userIdStr=self.nameTF.text;
    }
    BOOL authStatus=NO;
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]  objectForKey:@"UUID"]);
    NSString* identifierNumber = [[UIDevice currentDevice].identifierForVendor UUIDString] ;
    NSLog(@"手机序列号: %@",identifierNumber);
    //接入端客户认证
    id<TPLRemoteServiceProtocol> remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL, MOBILINTERFACEURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil loginRequestHeaderWithUserName:userIdStr andUserPwd:self.pawTF.text]];
    NSLog(@"mmc%@",[TPLRequestHeaderUtil loginRequestHeaderWithUserName:userIdStr andUserPwd:self.pawTF.text]);
    NSLog(@"%@",userIdStr);
    id<ISUserExt> userExt=nil;
    @try {
        NSLog(@"%@",self.pawTF.text);
        userExt=[remoteService loginWithUserName:userIdStr andPassword:self.pawTF.text];
    }
    @catch (NSException *exception) {
        //
        NSLog(@"%@:Hessian调用出错！- %@",@"loginWithUserName",exception);
        NSLog(@"11111%@,22222%@,33333%@",exception.name,exception.reason,exception.userInfo);
        //        return authStatus;
    }
    
    NSLog(@">>>>>%@",userExt);
    
    NSDictionary *respDict=[(CWDistantHessianObject *)remoteService resHeadDict];
    NSLog(@"<<<<<<<<<%@",respDict);
    
    NSString *errorcode=[respDict valueForKey:@"errorcode"];
    NSString *errormsg=[respDict valueForKey:@"errormsg"];
    NSLog(@"%@-%@",errorcode,errormsg);
    if ([errorcode isEqualToString:@"90001"]) {
        //
        authStatus=YES;
        NSString *inservToken=[respDict valueForKey:@"INTSERV_TOKEN"];
        NSLog(@"INTSERV_TOKEN>>>>>>>%@",inservToken);
        if (userExt) {
            userExt.inservToken=inservToken;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                                 message:@"未获取到您的用户信息，请确认是否已开通保全易服务权限！"
                                                                delegate:nil
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
                [alert show];
            });
            authStatus=NO;
            return authStatus;
        }
    }else{
        
        [self dealErrorCode:errorcode];
        
        authStatus=NO;
        return authStatus;
    }
    
    if (userExt) {
        //接入端认证成功
        NSLog(@"%@",userExt.realName);
        
        [TPLSessionInfo shareInstance].isUserExt = userExt;
        NSLog(@"userExt>>>>>>>%@",userExt);
        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            //启动心跳请求
//            CWHessianConnection *connection=[[CWHessianConnection alloc] initWithHessianVersion:CWHessianVersion1_00];
//            NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HESSIANURL,MOBILINTERFACEURL]];
//            CWDistantHessianObject<TPLRemoteServiceProtocol> *heartRemoteService=(CWDistantHessianObject<TPLRemoteServiceProtocol> *)[[connection proxyWithURL:url protocol:@protocol(TPLRemoteServiceProtocol)] retain];
//            [connection release];
//            heartCount=0;
//            [(CWDistantHessianObject *)heartRemoteService setReqHeadDict:[TPLRequestHeaderUtil sessionRequestHeader]];
//            //注意设置心跳请求的间隔时间
//            [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(heartUpdateWithRemoteService:) userInfo:heartRemoteService repeats:YES];
//            //心跳请求定义结束
//        });
    }
    return authStatus;
}

- (void)dealErrorCode:(NSString *)errorcode{
    NSString *infoStr=nil;
    
    if ([errorcode isEqualToString:@"88888"]){
        infoStr=@"后台业务接口无应答";
    }else if ([errorcode isEqualToString:@"10001"]){
        infoStr=@"不允许该设备登录";
    }else if ([errorcode isEqualToString:@"20001"]){
        infoStr=@"当前版本不是最新，请升级APP";
    }else if ([errorcode isEqualToString:@"20002"]){
        infoStr=@"版本信息不合法";
    }else if ([errorcode isEqualToString:@"30001"]){
        infoStr=@"客户管理平台对用户验证请求无响应";
    }else if ([errorcode isEqualToString:@"30002"]){
        infoStr=@"对不起，您没有跨站访问权限";
    }else if ([errorcode isEqualToString:@"30003"]){
        infoStr=@"对不起，用户名或密码缺失。请重新登录";
    }else if ([errorcode isEqualToString:@"30004"]){
        infoStr=@"对不起，您的账号已经失效，该账户被锁定,请找管理员解锁";
    }else if ([errorcode isEqualToString:@"30005"]){
        infoStr=@"对不起，您的密码输错次数超过系统允许的出错次数，账号被锁定";
    }else if ([errorcode isEqualToString:@"30006"]){
        infoStr=@"对不起，您需要修改初始密码";
    }else if ([errorcode isEqualToString:@"30007"]){
        infoStr=@"对不起，您需要修改密码";
    }else if ([errorcode isEqualToString:@"30009"]){
        infoStr=@"对不起，用户名或密码错误。请重新登录";
    }else if ([errorcode isEqualToString:@"30010"]){
        infoStr=@"对不起，您没有登录或登录信息丢失。请重新登录";
    }else if ([errorcode isEqualToString:@"30011"]){
        infoStr=@"对不起，您没有访问权限";
    }else if ([errorcode isEqualToString:@"30012"]){
        infoStr=@"对不起，权限验证异常";
    }else if ([errorcode isEqualToString:@"30008"]){
        infoStr=@"对不起，密码已重置。请登录奔驰系统修改密码后登陆";
    }else if ([errorcode isEqualToString:@"30013"]){
        infoStr=@"您的密码还有3天到期，请尽早修改密码";
    }else if ([errorcode isEqualToString:@"30021"]){
        infoStr=@"没有此用户";
    }else if ([errorcode isEqualToString:@"30022"]){
        infoStr=@"原密码输入错误";
    }else if ([errorcode isEqualToString:@"30023"]){
        infoStr=@"新密码不能与原密码一样";
    }else if ([errorcode isEqualToString:@"30024"]){
        infoStr=@"密码修改失败";
    }else if ([errorcode isEqualToString:@"30025"]){
        infoStr=@"密码长度错误";
    }else if ([errorcode isEqualToString:@"30026"]){
        infoStr=@"密码必须包含大写字母，小写字母，数字，特殊字符四项中的三项";
    }else if ([errorcode isEqualToString:@"40001"]){
        infoStr=@"该用户已在别处登陆，请重新登录";
    }else if ([errorcode isEqualToString:@"40002"]){
        infoStr=@"连接超时，请重新登录";
        
    }else if ([errorcode isEqualToString:@"99999"]){
        infoStr=@"接入端网路异常";
    }else{
        infoStr=@"网络异常，请稍后再试！";
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                         message:infoStr
                                                        delegate:nil
                                               cancelButtonTitle:@"确定"
                                               otherButtonTitles:nil];
        [alert show];
    });
    
}

-(void)timerBegin{
    [self.textBtn setTitle:[NSString stringWithFormat:@"剩余%d秒",_timeOver] forState:UIControlStateNormal];
    NSLog(@"%@",[NSString stringWithFormat:@"剩余%d秒",_timeOver]);
    _timeOver--;
    if (_timeOver<0) {
        self.textBtn.enabled=YES;
        [self.textBtn setTitle:@"重新获取验证码" forState:UIControlStateNormal];
        NSLog(@"2");
        [_timer invalidate];
        _timer=nil;
    }
    
}
//左边类型的转变
- (IBAction)chiangeType:(UIButton *)sender {
    _timeOver=60;
    if (_timer) {
        [_timer invalidate];
        _timer=nil;
        [self.textBtn setEnabled:YES];
        [self.textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    self.textTF.text=@"";
    if (sender.tag==1000) {
        //代理人
        _type=2;
        [sender setImage:[UIImage imageNamed:@"dlr-dianji.png"] forState:UIControlStateNormal];
        [self.nqBtn setImage:[UIImage imageNamed:@"nq-.png"] forState:UIControlStateNormal];
        [self.xszyBtn setImage:[UIImage imageNamed:@"xszy.png"] forState:UIControlStateNormal];
        return;
    }
    if (sender.tag==2000) {
        //内勤
        _type=1;
        [sender setImage:[UIImage imageNamed:@"nq-dianji.png"] forState:UIControlStateNormal];
        [self.xszyBtn setImage:[UIImage imageNamed:@"xszy.png"] forState:UIControlStateNormal];
        [self.dlrBtn setImage:[UIImage imageNamed:@"dlr.png"] forState:UIControlStateNormal];
        return;
    }
    if (sender.tag==3000) {
        //续收专员
        _type=4;
        [self.xszyBtn setImage:[UIImage imageNamed:@"xszy-dianjii.png"] forState:UIControlStateNormal];
        [self.nqBtn setImage:[UIImage imageNamed:@"nq-.png"] forState:UIControlStateNormal];
        [self.dlrBtn setImage:[UIImage imageNamed:@"dlr.png"] forState:UIControlStateNormal];
    }
}
#pragma mark 登陆
- (IBAction)loginBtnClick:(id)sender {
    [self.view resignFirstResponder];
    if (_timer) {
        [_timer invalidate];
        _timer=nil;
    }
    self.textBtn.enabled=YES;
    [self.textBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    
    if (self.textTF.text.length<1) {
        [self alertViewString:@"验证码不能为空"];
        return;
    }
    //接入端认证
    if(![self authLoginService]){
        return;
    }

    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,LOGIN]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id<TPLUserBOModel> userBOModer=nil;
        @try {
            userBOModer=[remoteService checkUserSmsCodeWithUserName:self.nameTF.text andSmsCode:self.textTF.text andUserCate:[NSString stringWithFormat:@"%d",_type]];
        }
        @catch (NSException *exception) {
            NSLog(@"%@",exception);
        }
        @finally {
            
        }
        NSLog(@"%@",userBOModer);
        NSDictionary *dicRes = [(CWDistantHessianObject *)remoteService resHeadDict];
        if (![[dicRes objectForKey:@"errorcode"] isEqualToString:@"90001"]) {
            [self dealErrorCode:[dicRes objectForKey:@"errorcode"]];
            return;
        }
        if(!userBOModer){
            return;
        }
//        if([userBOModer.changeReturn.returnFlag isEqualToString:@"1"]){
//            //1表示失败
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
//                                                               message:@"登陆失败！"
//                                                              delegate:nil
//                                                     cancelButtonTitle:@"确定"
//                                                     otherButtonTitles:nil];
//                [alert show];
//            });
//            return;
//        }
        [TPLSessionInfo shareInstance].userBOModel=userBOModer;
        NSLog(@">>>>>>>%@",userBOModer.userName);
        NSLog(@"111111111111 >>>>>%@",userBOModer);
        if([userBOModer.isSign isEqualToString:@"N"]){
            //未签名
            //承诺书
            CommitmentBookView *view=[CommitmentBookView awakeFromNib];
            view.frame=CGRectMake(211, 32, 600, 700);
            view.cateS=cateS;
            [view custem];
            [self.view addSubview:view];
            return;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^
                           {
                               [self gotoNextVC];
                               self.textTF.text=@"";
                           });
            
           
            }
    }); 
    
}
- (BOOL)authLoginService{
    NSString *userIdStr=nil;
    if (_type==2) {//代理人
        userIdStr=[[NSString alloc] initWithFormat:@"%@@agent",self.nameTF.text];
    }else{
        userIdStr=self.nameTF.text;
    }
    BOOL authStatus=NO;
    //接入端客户认证
    id<TPLRemoteServiceProtocol> remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,MOBILINTERFACEURL]];
    
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil loginRequestHeaderWithUserName:userIdStr andUserPwd:self.pawTF.text]];
    
    id<ISUserExt> userExt=nil;
    @try {
        userExt=[remoteService loginWithUserName:userIdStr andPassword:self.pawTF.text];
    }
    @catch (NSException *exception) {
        //
        NSLog(@"%@:Hessian调用出错！- %@",@"loginWithUserName",exception);
        //        return authStatus;
    }
    NSDictionary *respDict=[(CWDistantHessianObject *)remoteService resHeadDict];
    NSString *errorcode=[respDict valueForKey:@"errorcode"];
    NSString *errormsg=[respDict valueForKey:@"errormsg"];
    NSLog(@"%@-%@",errorcode,errormsg);
    if ([errorcode isEqualToString:@"90001"]) {
        //
        NSString *inservToken=[respDict valueForKey:@"INTSERV_TOKEN"];
        if (userExt&&inservToken) {
            //接入端认证成功
            authStatus=YES;
            return authStatus;
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil
                                                                 message:@"未获取到您的用户信息，请确认是否已开通保全易服务权限！"
                                                                delegate:nil
                                                       cancelButtonTitle:@"确定"
                                                       otherButtonTitles:nil];
                [alert show];
            });
            authStatus=NO;
            return authStatus;
        }
    }else{
        
        [self dealErrorCode:errorcode];
        authStatus=NO;
        return authStatus;
    }
    return authStatus;
}

-(void)gotoNextVC{
    self.textTF.text=@"";
    MainViewController *mainVC=[MainViewController sharedManager];
    mainVC.name=self.nameTF.text;
    if(_type==2){
        //代理人
        mainVC.type=1;
    }else if (_type==1){
        //内勤
        mainVC.type=2;
    }else{
        //续收专员
        mainVC.type=3;
    }
    [mainVC custemView];
    NSLog(@"%@",self.nameTF.text);
    [self.navigationController pushViewController:mainVC animated:YES];
    NSLog(@"登陆");
}
//alertView提示（用户名、密码、验证码输入与否）
-(void)alertViewString:(NSString *)string{
    UIAlertView *alertV=[[UIAlertView alloc] initWithTitle:@"提示" message:string delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    [alertV show];
}
-(void)btn{
    //相机
    self.myimagePC=[[MyImagePickerController alloc] init];
    self.myimagePC.delegate=self;
    self.myimagePC.sourceType=UIImagePickerControllerSourceTypeCamera;
    self.myimagePC.showsCameraControls=NO;
    [self presentViewController:self.myimagePC animated:YES completion:^{
        
    }];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    NSLog(@"11111");
    float width=image.size.width;
    float height=image.size.height;
    CGRect rect1 = CGRectMake((1024-600)/2*width/1024, (768-420)/2*height/768, 600*width/1024, 420*height/768);//创建矩形框
    //对图片进行截取
    // UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([[[self captureManager] stillImage] CGImage], rect1)];
    //    UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1)];
    NSLog(@"高%f,,,宽%f",image.size.height,image.size.width);
    UIImage * image2 =[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1) scale:image.scale orientation:UIImageOrientationDown];
    UIImageWriteToSavedPhotosAlbum(image2, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
//-(void)keyboardChangeFram:(NSNotification*)notification{
//    CGRect keyRect=[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    NSLog(@"%f,",keyRect.origin.y);
////    if (keyRect.origin.y<700) {
////        self.backView.frame=CGRectMake(257, 76, 510, 301);
////    }else{
////        self.backView.frame=CGRectMake(257, 233, 510, 301);
////    }
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
