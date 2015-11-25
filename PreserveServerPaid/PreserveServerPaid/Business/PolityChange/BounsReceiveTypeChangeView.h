//
//  BounsReceiveTypeChangeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//红利领取方式变更
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "ChargeView.h"
@interface BounsReceiveTypeChangeView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选按钮对应的view

@property (nonatomic,strong)NSMutableArray  *mArray;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确定按钮
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(BounsReceiveTypeChangeView*)awakeFromNib;

@end


#pragma mark  BounsReceiveTypeChangeCell

@interface BounsReceiveTypeChangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *payTypeL;//支付方式
@property (weak, nonatomic) IBOutlet UILabel *moneyL;//现金红利金额
@property (weak, nonatomic) IBOutlet UILabel *bankNumL;//授权账号
@property (weak, nonatomic) IBOutlet UILabel *bankL;//账号所属银行
@property (weak, nonatomic) IBOutlet UILabel *accountNameL;//账户所有人


-(instancetype)initWithFrame:(CGRect)frame;

@end


#pragma mark  BounsReceiveTypeChangeDetailView

@interface BounsReceiveTypeChangeDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;

@property (nonatomic,strong)NSMutableArray          *mArray;
@property (nonatomic,strong)ChargeView *cView;


@end


#pragma mark  BounsReceiveTypeChangeDetailCell

@interface BounsReceiveTypeChangeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号

@property (nonatomic,strong) ChargeView     *chargeView;

-(instancetype)initWithFrame:(CGRect)frame;

@end