//
//  InvestEndHolidayView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//投连结束保险费假期
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "ChargeView.h"
@interface InvestEndHolidayView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选按钮对应的view

@property (nonatomic,strong)NSMutableArray  *mArray;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确定按钮
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(InvestEndHolidayView*)awakeFromNib;


@end



#pragma mark   InvestEndHolidayCell

@interface InvestEndHolidayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *polityNameL;//第一主险
@property (weak, nonatomic) IBOutlet UILabel *timeL;//进入假期时间


-(instancetype)initWithFrame:(CGRect)frame;

@end



#pragma mark InvestEndHolidayDetailView

@interface InvestEndHolidayDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray      *array;//用于传递数据
@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIView *rightView;//右边的收费账号信息

@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的view

@property (weak, nonatomic) IBOutlet UIView *redDownView;//下面的红色提示

@property (nonatomic , strong) ChargeView *chargV;


@end


#pragma mark InvestEndHolidayDetailCell

@interface InvestEndHolidayDetailCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号

-(instancetype)initWithFrame:(CGRect)frame;

@end



#pragma mark InvestEndHolidayDetailCellInCell

@interface InvestEndHolidayDetailCellInCell : UITableViewCell

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UILabel *numberL;//序号
@property (weak, nonatomic) IBOutlet UILabel *nameL;//名称
@property (weak, nonatomic) IBOutlet UILabel *timeL;//进入假期时间
@property (weak, nonatomic) IBOutlet UILabel *allL;//合计



-(instancetype)initWithFrame:(CGRect)frame;

@end
