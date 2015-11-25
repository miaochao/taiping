//
//  FenHongZhangHuView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PreserveServer-Prefix.pch"


@interface FenHongZhangHuView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) NSMutableArray *tabArray;

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;//责任状态
@property (weak, nonatomic) IBOutlet UIImageView *timeImageV;//时间升序降序



+(FenHongZhangHuView *)awakeFromNib;

@end



@interface FenHongZhangHuViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *polityNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *insureLabel;
@property (weak, nonatomic) IBOutlet UILabel *insuredLabel;
@property (weak, nonatomic) IBOutlet UILabel *polityNameLabel;

-(instancetype)initWithFrame:(CGRect)frame;

@end


@interface FenHongZhangHuXiangQingView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic)NSMutableArray *xiangTabVarray;

@property (strong, nonatomic) IBOutlet UIView *smallXiangView;
//前一页传来的数据
@property (strong, nonatomic) NSString *huodeString;

//@property id<TPLDrawAccountBOModel>resultDic ;

+(FenHongZhangHuXiangQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;



@end


@interface FenHongZhangHuXiangQingViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *xianZhongLabel;

@property (strong, nonatomic) IBOutlet UILabel *xuanZeLabel;

@property (strong, nonatomic) IBOutlet UILabel *fangshiLabel;

@property (strong, nonatomic) IBOutlet UILabel *riqiLabel;

@property (strong, nonatomic) IBOutlet UILabel *baoeLabel;

@property (strong, nonatomic) IBOutlet UILabel *hongLiLabel;





-(instancetype)initWithFrame:(CGRect)frame;

@end

