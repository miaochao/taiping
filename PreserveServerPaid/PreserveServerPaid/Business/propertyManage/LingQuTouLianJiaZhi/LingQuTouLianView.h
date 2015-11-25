//
//  LingQuTouLianView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/10.
//  Copyright © 2015年 wondertek. All rights reserved.
//
//领取投连账户价值
#import <UIKit/UIKit.h>
#import "ChargeView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "ThreeViewController.h"


@interface LingQuTouLianView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *quanArray;
@property (strong, nonatomic) NSMutableArray *chooseArray;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

@property (strong, nonatomic) IBOutlet UIView *quanXuanView;
@property (strong, nonatomic) IBOutlet UIButton *touLianQueRenBtn;





@property (assign, nonatomic) BOOL isXuanZe;
@property (assign, nonatomic) BOOL isChoose;


+ (LingQuTouLianView *)awakeFromNib;

- (IBAction)jiazhiQueDingBtnClick:(id)sender;

- (IBAction)quanxuanBtnClick:(id)sender;


@end



//领取投连账户价值详情页
@interface LingQuTouLianXiangQingView : UIView<UITableViewDataSource,UITableViewDelegate,messageTestViewDelegate,writeNameDelegate>


@property (strong, nonatomic) IBOutlet UIView *smallXiangView;
@property (strong, nonatomic) IBOutlet UIView *wenXinView;


@property (strong, nonatomic) NSMutableArray *detailArray;
@property (strong, nonatomic) NSMutableArray *mArray;
@property (strong, nonatomic) NSMutableArray *smallArray;


@property (strong, nonatomic) NSMutableArray *huodeArray;
@property (strong, nonatomic) UITableView *xiangQingTableView;
@property (strong, nonatomic) ChargeView *chargeV;
@property (strong, nonatomic) UIButton *kongBtn;


@property (strong, nonatomic) IBOutlet UILabel *lingQuXinXiLabel;
//变更按钮
@property (strong, nonatomic) UIView *biangengView;
@property (strong, nonatomic) UIButton *biangengBtn;

@property (strong, nonatomic) IBOutlet UILabel *baodanXiangLabel;
@property (strong, nonatomic) IBOutlet UILabel *xianZhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *mingChengLabel;
@property (assign, nonatomic) BOOL isUp;



+(LingQuTouLianXiangQingView*)awakeFromNib;
- (IBAction)yinCangBtnClick:(id)sender;

//-(instancetype)initWithFrame:(CGRect)frame;



@end

@interface  LingQuTabHeadView: UIView

@property (strong, nonatomic) IBOutlet UILabel *policyCode;

@property (strong, nonatomic) IBOutlet UILabel *xianMingLabel;





+(LingQuTabHeadView*)awakeFromNib;


@end

