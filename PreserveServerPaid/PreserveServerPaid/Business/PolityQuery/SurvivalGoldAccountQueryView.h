//
//  SurvivalGoldAccountQueryView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//生存金账户信息
#import <UIKit/UIKit.h>

@interface SurvivalGoldAccountQueryView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;//责任状态
@property (weak, nonatomic) IBOutlet UIImageView *timeImageV;//时间升序降序

+(UIView*)awakeFromNib;
-(void)custemView;
-(void)sizeToFit;
@end
