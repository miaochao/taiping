//
//  ReceiveSurvivalGoldView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/13.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//领取生存金
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface ReceiveSurvivalGoldView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

@property (weak, nonatomic) IBOutlet UIView *allChooseView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;

+(ReceiveSurvivalGoldView*)awakeFromNib;


@end

#pragma mark  ReceiveSurvivalGoldCell

@interface ReceiveSurvivalGoldCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *polciyCode;//保单号
@property (weak, nonatomic) IBOutlet UILabel *survivalInterest;//可领取生存金
@property (weak, nonatomic) IBOutlet UILabel *endInterest;//可领取满期金
@property (weak, nonatomic) IBOutlet UILabel *annuityInterest;//可领取年金
@property (weak, nonatomic) IBOutlet UILabel *terminalBonus;//可领取红利
@property (weak, nonatomic) IBOutlet UILabel *payingFee;//本次可领取金额


-(instancetype)initWithFrame:(CGRect)frame;

@end

#pragma mark  ReceiveSurvivalGoldDetailView

@interface ReceiveSurvivalGoldDetailView : UIView<writeNameDelegate,messageTestViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的view



@end


