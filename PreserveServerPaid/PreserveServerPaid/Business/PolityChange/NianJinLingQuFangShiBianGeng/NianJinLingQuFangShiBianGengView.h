//
//  NianJinLingQuFangShiBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

//年金领取方式变更
@interface NianJinLingQuFangShiBianGengView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *quanArray;
@property (strong, nonatomic) NSMutableArray *chooseArray;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

@property (strong, nonatomic) IBOutlet UIView *quanxuanView;

@property (strong, nonatomic) IBOutlet UIButton *quddingBtn;


@property (assign, nonatomic) BOOL isXuanZe;
@property (assign, nonatomic) BOOL isChoose;


+ (NianJinLingQuFangShiBianGengView *)awakeFromNib;

- (IBAction)jiazhiQueDingBtnClick:(id)sender;

- (IBAction)quanxuanBtnClick:(id)sender;


@end


@interface NianJinLingQuFangShiBianGengViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *xuanZeBtn;
@property (strong, nonatomic) IBOutlet UILabel *baodanhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuXianLabel;

-(instancetype)initWithFrame:(CGRect)frame;


@end


//详情页面
@interface NianJinLingQuFangShiBianGengXiangQingView : UIView<UITableViewDataSource,UITableViewDelegate,messageTestViewDelegate,writeNameDelegate>

//三个数组控制单选全选
@property (strong, nonatomic) NSMutableArray *detailArray;
@property (strong, nonatomic) NSMutableArray *smallArray1;
@property (strong, nonatomic) NSMutableArray *smallArray2;
@property (strong, nonatomic) NSMutableArray *smallArray3;

@property (strong, nonatomic) NSMutableArray *chooseArray;
@property (strong, nonatomic) NSMutableArray *huodeArray;
@property (strong, nonatomic) NSMutableArray *quanbuArray;
@property (strong, nonatomic) NSMutableArray *mArray;



@property (strong, nonatomic) IBOutlet UIView *xiangQingView;
@property (strong, nonatomic) IBOutlet UIView *queDingView;

@property (assign, nonatomic) BOOL isChoose;


+(NianJinLingQuFangShiBianGengXiangQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)queDingBianGengBtnClick:(id)sender;


@end


//详情页内部
@interface NianJinLingQuSmallXiangQingView : UIView

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;



+(NianJinLingQuSmallXiangQingView *)awakeFromNib;


@end


//内部的表
@interface NianJinLingQuSmallXiangQingViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *danxuanBtn;

@property (strong, nonatomic) IBOutlet UILabel *xianZhongLabel;

@property (strong, nonatomic) IBOutlet UILabel *mingChengLabel;

@property (strong, nonatomic) IBOutlet UILabel *baoELabel;

@property (strong, nonatomic) IBOutlet UILabel *qiXianLabel;
@property (strong, nonatomic) IBOutlet UILabel *lingQuNianLingLabel;

@property (strong, nonatomic) IBOutlet UIButton *lingQuNIanXianBtn;

@property (strong, nonatomic) IBOutlet UIButton *lingQuFangShiBtn;


-(instancetype)initWithFrame:(CGRect)frame;


@end


@interface TableFootView : UIView

@property (strong, nonatomic) IBOutlet UIButton *quanXuanBtn;


+(TableFootView *)awakeFromNib;


@end




