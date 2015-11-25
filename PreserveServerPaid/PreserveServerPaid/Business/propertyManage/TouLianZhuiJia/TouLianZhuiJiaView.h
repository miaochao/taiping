//
//  TouLianZhuiJiaView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/28.
//  Copyright © 2015年 wondertek. All rights reserved.
//
//投连追加投资页面
#import <UIKit/UIKit.h>

@interface TouLianZhuiJiaView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *touLianTableView;

//三个头标签
@property (strong, nonatomic) IBOutlet UILabel *xuanZeBtn;
@property (strong, nonatomic) IBOutlet UILabel *baoDanBtn;
@property (strong, nonatomic) IBOutlet UILabel *zhuXianBtn;
@property (strong, nonatomic) IBOutlet UIButton *touLianQueRenBtn;
@property (strong, nonatomic) IBOutlet UIView *quanXuanView;
@property (strong, nonatomic) IBOutlet UIButton *quanXuanBtn;

//控制cell的全选
@property (strong, nonatomic) NSMutableArray *quanArray;
@property (strong, nonatomic) NSMutableArray *chooseArray;

@property (assign, nonatomic) BOOL isChoose;


+(TouLianZhuiJiaView *)awakeFromNib;

- (IBAction)quanXuanBtnClick:(id)sender;
- (IBAction)queDingBtnClick:(id)sender;



@end
