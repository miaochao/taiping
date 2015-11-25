//
//  TouLianWanNengJieSuanChaXunView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/15.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//投连/万能结算账户查询

#import <UIKit/UIKit.h>
#import "PreserveServer-Prefix.pch"

@interface TouLianWanNengJieSuanChaXunView : UIView<UITableViewDataSource,UITableViewDelegate>

//@property (strong, nonatomic) TouLianWanNengChaXunXiangQingView *touLianXiangView;
@property (strong, nonatomic) NSMutableArray *tabArray;

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;//责任状态
@property (weak, nonatomic) IBOutlet UIImageView *timeImageV;//时间升序降序


+(TouLianWanNengJieSuanChaXunView *)awakeFromNib;

@end


@interface TouLianWanNengJieSuanChaXunViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *polityNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *insureLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuredLabel;
@property (weak, nonatomic) IBOutlet UILabel *polityNameLabel;

-(instancetype)initWithFrame:(CGRect)frame;


@end


//万能结算
@interface TouLianWanNengChaXunXiangQingView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *xiangTabVarray;

@property (strong, nonatomic) IBOutlet UIView *smallXiangView;

@property id<TPLPolicyBOModel>huoDeDic;


+(TouLianWanNengChaXunXiangQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;


@end


@interface TouLianWanNengChaXunXiangQingViewCell : UITableViewCell
//
//xianZhongLabel
//xuanZeLabel.te
//fangshiLabel.t
//riqiLabel.text
//baoeLabel.text
//hongLiLabel.te

@property (strong, nonatomic) IBOutlet UILabel *xianZhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *jiaZhiLabel;
@property (strong, nonatomic) IBOutlet UILabel *jieSuanRi;
@property (strong, nonatomic) IBOutlet UILabel *gongGaoRi;
@property (strong, nonatomic) IBOutlet UILabel *riLiLv;


-(instancetype)initWithFrame:(CGRect)frame;

@end


//投连结算
@interface  TouLianWanNengChaXunTwoXiangQingView: UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *smallTwoView;
@property (strong, nonatomic) NSMutableArray *detailArray;
@property id<TPLPolicyBOModel>huoDeDic;



+(TouLianWanNengChaXunTwoXiangQingView *)awakeFromNib;


- (IBAction)yinCanBtnClick:(id)sender;





@end


@interface  TouLianWanNengChaXunTwoXiangQingViewCell: UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *xianZhongLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhanghuLabel;
@property (strong, nonatomic) IBOutlet UILabel *danWeiShuLabel;
@property (strong, nonatomic) IBOutlet UILabel *pingGuRi;
@property (strong, nonatomic) IBOutlet UILabel *maiChuLabel;
@property (strong, nonatomic) IBOutlet UILabel *maiRuLabel;



-(instancetype)initWithFrame:(CGRect)frame;

@end




