//
//  LoanPayOffView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//贷款清偿
#import <UIKit/UIKit.h>
#import "PreserveServer-Prefix.pch"
#import "BaoQuanPiWenView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
@interface LoanPayOffView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,messageTestViewDelegate,writeNameDelegate>

@property (nonatomic,strong)NSMutableArray   *mArray;

@property (weak, nonatomic) IBOutlet UILabel *label;//提示信息

//@property (weak, nonatomic) IBOutlet UIButton *payOffBtn;//立即还款
@property (strong, nonatomic)  UIButton *payOffBtn;//立即还款

-(void)sizeToFit;
@end



@interface LoanPayOffCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberL;//数字
@property (weak, nonatomic) IBOutlet UILabel *polityNumberL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *loanExtensionDate;//贷款到期日
@property (weak, nonatomic) IBOutlet UILabel *interestCapital;//贷款本金
@property (weak, nonatomic) IBOutlet UILabel *interestBalance;//贷款利息
@property (weak, nonatomic) IBOutlet UILabel *productTotalAmount;//贷款本息合计


@property (weak, nonatomic) IBOutlet UITextField *textF;

-(instancetype)initWithFrame:(CGRect)frame;
@end