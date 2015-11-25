//
//  MainViewController.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/21.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaveView.h"
@interface MainViewController : UIViewController<UIScrollViewDelegate,leaveDelegate>

@property (nonatomic,assign)int                  type;//登陆人类型
@property (nonatomic,strong)NSString            *name;//登陆人名字

@property (weak, nonatomic) IBOutlet UIButton *headBtn;//头像男女
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//用户名字
@property (weak, nonatomic) IBOutlet UIImageView *typeImageV;//用户类型
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;//左边蓝色label

@property (weak, nonatomic) IBOutlet UIView *leftView;


@property (weak, nonatomic) IBOutlet UIView *changeView;//保全变更服务
@property (weak, nonatomic) IBOutlet UIView *propertyView;//资产管理服务
@property (weak, nonatomic) IBOutlet UIView *queryView;//保全查询服务
@property (weak, nonatomic) IBOutlet UIView *progressView;//保全进度服务

@property (strong, nonatomic) UIScrollView *scrollV;//右边的scrollView


+(instancetype)sharedManager;

-(void)custemView;//初始化页面

-(void)popVC;
@end
