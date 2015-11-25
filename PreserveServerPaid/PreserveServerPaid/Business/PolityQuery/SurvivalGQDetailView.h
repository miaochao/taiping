//
//  SurvivalGQDetailView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SurvivalGQDetailView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSString    *pilityCode;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UIView *rightView;//右边的view


+(UIView*)awakeFromNib;
-(void)custem;
@end


#pragma mark SurvivalGQDetailCell

@interface SurvivalGQDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *productNameL;//险种名称
@property (weak, nonatomic) IBOutlet UILabel *liabNameL;//生存金类型
@property (weak, nonatomic) IBOutlet UILabel *authNameL;//授权给付方式
@property (weak, nonatomic) IBOutlet UILabel *feeAmountL;//生存金金额

@property (weak, nonatomic) IBOutlet UILabel *distributeDateL;//分配日期
@property (weak, nonatomic) IBOutlet UILabel *isDrawL;//是否已领取
@property (weak, nonatomic) IBOutlet UILabel *drawDateL;//领取日期




-(instancetype)initWithFrame:(CGRect)frame;
@end