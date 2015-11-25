//
//  RequestURL.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/22.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#ifndef PreserveServerPaid_RequestURL_h
#define PreserveServerPaid_RequestURL_h

//服务器根路径定义
//#define HESSIANURL @"http://172.16.13.159:8080/custServ"
//#define HESSIANURLS @"http://172.16.13.223:8080/custServ"
#define HESSIANURLS @"http://intest.life.cntaiping.com/mobile"
#define HESSIANURL @"http://intest.life.cntaiping.com/mobile"


//接入端版本校验、接入端认证、接入端会话心跳
#define MOBILINTERFACEURL @"/login"
//点击获取验证码
#define SENDMESSAGELOGIN @"/servlet/hessian/com.cntaiping.intserv.custserv.login.LoginServlet"

//点击登录验证
#define LOGIN @"/servlet/hessian/com.cntaiping.intserv.custserv.login.LoginServlet"

//第一次登录签约
#define FIRSTLOGIN @"/servlet/hessian/com.cntaiping.intserv.custserv.agreement.AgreementServlet"


#endif
