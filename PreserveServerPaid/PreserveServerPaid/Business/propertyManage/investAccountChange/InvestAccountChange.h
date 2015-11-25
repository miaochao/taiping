//
//  InvestAccountChange.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/12.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//投连投资账户转换
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface InvestAccountChange : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

+(InvestAccountChange*)awakeFromNib;

@end


#pragma mark  InvestAccountChangeCell

@interface InvestAccountChangeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *numberL;//编号
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *nameL;//主险名称
@property (weak, nonatomic) IBOutlet UILabel *stableAccountNameL;//稳健账户
@property (weak, nonatomic) IBOutlet UILabel *upAccountNameL;//动力增长

@property (weak, nonatomic) IBOutlet UILabel *radicalAccountNameL;//激进账户

@property (weak, nonatomic) IBOutlet UILabel *stableAccountNumL;//稳健账户
@property (weak, nonatomic) IBOutlet UILabel *upAccountNumL;//动力增长

@property (weak, nonatomic) IBOutlet UILabel *radicalAccountNumL;//激进账户


-(instancetype)initWithFrame:(CGRect)frame;
@end


#pragma mark InvestAccountChangeDetailView

@interface InvestAccountChangeDetailView : UIView<UITableViewDataSource,UITableViewDelegate,writeNameDelegate,messageTestViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UILabel *upLabel;//高度15
@property (weak, nonatomic) IBOutlet UILabel *polityCode;//保单号

@property (weak, nonatomic) IBOutlet UIButton *stableAccountBtn;//平均稳健账户
@property (weak, nonatomic) IBOutlet UILabel *stableAccountL;//平均稳健账户

@property (weak, nonatomic) IBOutlet UIButton *targetAccountBtn;//目标账户
@property (weak, nonatomic) IBOutlet UILabel *targetAccountL;

@property (weak, nonatomic) IBOutlet UITextField *numberTextF;//单位数



@property (weak, nonatomic) IBOutlet UIView *upView;//投资账户转换View
@property (weak, nonatomic) IBOutlet UIView *downView;//下面的空白View

@property (nonatomic,strong)NSMutableArray  *mArray;
@property (nonatomic,strong)NSDictionary    *dic;//数据传递
@property (nonatomic,strong)NSString        *polityStr;
@end


#pragma mark InvestAccountChangeDetailUpCell

@interface InvestAccountChangeDetailUpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountNameL;//账户名称
@property (weak, nonatomic) IBOutlet UILabel *accountCodeL;//账户代码
@property (weak, nonatomic) IBOutlet UILabel *numberL;//现有基金数
@property (weak, nonatomic) IBOutlet UILabel *sellNumL;//已申请卖出基金单位数
@property (weak, nonatomic) IBOutlet UILabel *overNumL;//可转出基金单位数
@property (weak, nonatomic) IBOutlet UILabel *productName;//险种名称

@property (weak, nonatomic) IBOutlet UILabel *productType;//险种状态


-(instancetype)initWithFrame:(CGRect)frame;

@end


#pragma mark InvestAccountChangeDetailDownCell

@interface InvestAccountChangeDetailDownCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *basicAccountL;//原账户
@property (weak, nonatomic) IBOutlet UILabel *targetAccountL;//目标账户
@property (weak, nonatomic) IBOutlet UILabel *numberL;//单位数


-(instancetype)initWithFrame:(CGRect)frame;

@end

