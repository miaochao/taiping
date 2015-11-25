//
//  ChargeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/24.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//选择银行界面
#import <UIKit/UIKit.h>

@interface ChargeView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *bankTextField;//银行
@property (weak, nonatomic) IBOutlet UITextField *acountTextField;//收费账号
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;//账户类型
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;//账户人名字
@property (weak, nonatomic) IBOutlet UITextField *organizationTextField;//账户机构
@property (weak, nonatomic) IBOutlet UITextField *typeTextF;//授权方式


@property (weak, nonatomic) IBOutlet UILabel *bankL;//所属银行
@property (weak, nonatomic) IBOutlet UILabel *accountL;//收费账号
@property (weak, nonatomic) IBOutlet UILabel *accountTypeL;//账户类型
@property (weak, nonatomic) IBOutlet UILabel *nameL;//账户所有人
@property (weak, nonatomic) IBOutlet UILabel *organizationL;//账户机构
@property (weak, nonatomic) IBOutlet UILabel *typeL;//授权方式


@property (weak, nonatomic) IBOutlet UIView *bankView;//所属银行的View

@property (strong, nonatomic) IBOutlet UIButton *bankBtn;//所属银行按钮
@property (strong, nonatomic) IBOutlet UIButton *organizationBtn;//所属机构按钮
@property (strong, nonatomic) IBOutlet UIButton *typeBtn;//授权方式按钮



@property (nonatomic,assign)BOOL                    upOrdown;//用来表示银行和机构的选择位置，no表示下面，yes表示上面

@property (nonatomic,assign)int                    type;//根据这个来布局授权方式,,1

-(void)createBtn;
-(void)createLabel;//生存金领取方式变更调用
-(void)recriveSurvivalGold;//领取生存金

-(void)bounsReceiveType;//红利领取方式变更

+(ChargeView*)awakeFromNib;
-(instancetype)initWithFrame:(CGRect)frame;
@end
