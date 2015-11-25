//
//  ReturnPolitySettleView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//退还保单结余款项
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface ReturnPolitySettleView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UIView *allChooseView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(ReturnPolitySettleView*)awakeFromNib;
@end

#pragma mark ReturnPolitySettleDetailView

@interface ReturnPolitySettleDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray      *array;//用于传递数据
@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIView *baseView;//右边底部view

@property (weak, nonatomic) IBOutlet UIView *redView;//右边红色字体view


@end




#pragma mark  ReturnPolitySettleDetailCell

@interface ReturnPolitySettleDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *balanceFrem;//保单账号余额
@property (weak, nonatomic) IBOutlet UILabel *bankAccount;//原缴费账号
@property (weak, nonatomic) IBOutlet UILabel *bankName;//原缴费账号所属银行名称
@property (weak, nonatomic) IBOutlet UILabel *accoOwnerName;//账号所有人
@property (weak, nonatomic) IBOutlet UILabel *accountName;//账号类型名称

-(instancetype)initWithFrame:(CGRect)frame;
@end




#pragma mark  ReturnPolitySettlePiWenView

@interface ReturnPolitySettlePiWenView : UIView<messageTestViewDelegate,writeNameDelegate>
@property (strong, nonatomic) IBOutlet UIView *rightView;
@property (strong, nonatomic) IBOutlet UILabel *rightLabel;



+(ReturnPolitySettlePiWenView*)awakeFromNib;
@end