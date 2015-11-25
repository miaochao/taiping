//
//  LoginViewController.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/2.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyImagePickerController.h"

@interface LoginViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *dlrBtn;//代理人
@property (weak, nonatomic) IBOutlet UIButton *nqBtn;//内勤
@property (weak, nonatomic) IBOutlet UIButton *xszyBtn;//续收专员


@property (strong, nonatomic) IBOutlet UIImageView *imageV;//登录 框



@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong)UITextField     *nameTF;//名字
@property (nonatomic,strong)UITextField     *pawTF;//密码
@property (nonatomic,strong)UITextField     *textTF;//验证码
@property (weak, nonatomic) IBOutlet UIButton *textBtn;//获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登陆

@property(nonatomic,retain)MyImagePickerController *myimagePC;

-(void)gotoNextVC;
+(instancetype)sharedManager;
@end
