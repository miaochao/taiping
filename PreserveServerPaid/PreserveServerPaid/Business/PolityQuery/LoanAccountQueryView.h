//
//  LoanAccountQueryView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//贷款账户查询
#import <UIKit/UIKit.h>

@interface LoanAccountQueryView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UIButton *beginBtn;//开始时间

@property (weak, nonatomic) IBOutlet UIButton *endBtn;//结束时间

@property (strong, nonatomic) IBOutlet UITextField *textF;

@property (weak, nonatomic) IBOutlet UIImageView *timeImageV;//时间升序降序

+(LoanAccountQueryView*)awakeFromNib;

@end


#pragma mark  LoanAccountQueryCell

@interface LoanAccountQueryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *policyCode;//保单号
@property (weak, nonatomic) IBOutlet UILabel *loanTime;//生效日期
@property (weak, nonatomic) IBOutlet UILabel *capitalAmount;//贷款
@property (weak, nonatomic) IBOutlet UILabel *repayAmount;//还款
@property (weak, nonatomic) IBOutlet UILabel *balanceAccount;//结息
@property (weak, nonatomic) IBOutlet UILabel *loanAmount;//本息
@property (weak, nonatomic) IBOutlet UILabel *interestRate;//贷款利率
@property (weak, nonatomic) IBOutlet UILabel *settledTime;//约定到期时间
@property (weak, nonatomic) IBOutlet UILabel *channelDesc;//操作途径

-(instancetype)initWithFrame:(CGRect)frame;

@end
