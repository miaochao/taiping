//
//  MessageTestView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/21.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreserveServer-Prefix.pch"


@protocol messageTestViewDelegate <NSObject>

-(void)massageTest;

@end

@interface MessageTestView : UIView

// 与短信验证相关的五个控件
@property (strong, nonatomic) UIView *smallMessageView;
@property (strong, nonatomic) UIView *messageTouMingView;
@property (strong, nonatomic) UILabel *yanZhengMaLabel;
@property (strong, nonatomic) UITextField *yanZhengMaTF;
@property (strong, nonatomic) UIButton *restTimeBtn;
@property (strong, nonatomic) UIButton *queRenBtn;

@property (strong, nonatomic) UIButton *yiChuBtn;

//开启定时器

@property (strong, nonatomic)NSTimer *messageTimer;
@property (nonatomic,assign)int   messagetimeOver;//验证码时间

@property (nonatomic,assign)int        end;//退还保单结余款项
@property (nonatomic,assign)id<messageTestViewDelegate>delegate;


@end
