//
//  ShortTimeAppointmentEndView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//短期险预约终止
#import <UIKit/UIKit.h>
#import "enumView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface ShortTimeAppointmentEndView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UIButton *allChooseBtn;//全选按钮
@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选的view
@property (weak, nonatomic) IBOutlet UIButton *okBtn;//确定按钮

-(void)sizeToFit;
@end



#pragma mark  ShortTimeAppointmentEndCell

@interface ShortTimeAppointmentEndCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *insuranceNameL;//保险名字
@property (weak, nonatomic) IBOutlet UILabel *timeL;

-(instancetype)initWithFrame:(CGRect)frame;
@end



#pragma mark  ShortTimeAppointmentEndDetailView

@interface ShortTimeAppointmentEndDetailView : UIView<UIScrollViewDelegate,writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)NSMutableArray      *array;//用来传数据的
@property (weak, nonatomic) IBOutlet UIView *rightView;//右边的详情

@property (nonatomic,strong)NSMutableArray      *mArray;

@end



#pragma mark  ShortTimeAppointmentEndDetailTableView

@interface ShortTimeAppointmentEndDetailTableView : UIView <UITableViewDataSource,UITableViewDelegate>



@property (strong, nonatomic) IBOutlet UIButton *detailAllChooseBtn;



@property (weak, nonatomic) IBOutlet UILabel *polityCode;
@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选View
@property (weak, nonatomic) IBOutlet UILabel *downLabel;

-(instancetype)initWithFrame:(CGRect)frame;
@end


#pragma mark ShortTimeAppointmentEndDetailTableViewCell

@interface ShortTimeAppointmentEndDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;//选择按钮
@property (weak, nonatomic) IBOutlet UILabel *insuranceNumL;//险种序号
@property (weak, nonatomic) IBOutlet UILabel *insuranceNameL;//险种名称
@property (weak, nonatomic) IBOutlet UILabel *insuranceTypeL;//险种状态
@property (weak, nonatomic) IBOutlet UILabel *nextTimeL;//下期缴费日
@property (weak, nonatomic) IBOutlet UILabel *beginTimeL;//预约终止前日期
@property (weak, nonatomic) IBOutlet UILabel *endTimeL;//预约终止后日期


-(instancetype)initWithFrame:(CGRect)frame;
@end


