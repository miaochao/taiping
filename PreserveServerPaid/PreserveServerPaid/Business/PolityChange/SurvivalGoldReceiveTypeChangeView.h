//
//  SurvivalGoldReceiveTypeChangeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/12.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//生存金领取方式变更
#import <UIKit/UIKit.h>
#import "ChargeView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface SurvivalGoldReceiveTypeChangeView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选按钮对应的view

@property (nonatomic,strong)NSMutableArray  *mArray;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确定按钮
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(SurvivalGoldReceiveTypeChangeView*)awakeFromNib;
@end


#pragma mark  SurvivalGoldReceiveTypeChangeCell

@interface SurvivalGoldReceiveTypeChangeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *typeL;//授权方式
@property (weak, nonatomic) IBOutlet UILabel *numberL;//授权账号
@property (weak, nonatomic) IBOutlet UILabel *bankL;//银行
@property (weak, nonatomic) IBOutlet UILabel *nameL;//账户所有人



-(instancetype)initWithFrame:(CGRect)frame;

@end

#pragma mark  SurvivalGoldReceiveTypeChangeDetailView

@interface SurvivalGoldReceiveTypeChangeDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray  *mArray;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (nonatomic ,strong) ChargeView *chargeV;

@end


#pragma mark  SurvivalGoldReceiveTypeChangeDetailCell

@interface SurvivalGoldReceiveTypeChangeDetailCell : UITableViewCell

@property (nonatomic,strong)ChargeView      *chargeV;

-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end