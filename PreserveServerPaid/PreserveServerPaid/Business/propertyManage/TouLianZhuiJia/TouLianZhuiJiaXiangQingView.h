//
//  TouLianZhuiJiaXiangQingView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/28.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"

#import "ChargeView.h"
@interface TouLianZhuiJiaXiangQingView : UIView<UITableViewDataSource,UITableViewDelegate,messageTestViewDelegate,writeNameDelegate>


@property (strong, nonatomic) IBOutlet UITableView *touLianxiangTableView;

@property (strong, nonatomic) IBOutlet UIButton *bianGengBtn;

@property (strong, nonatomic) IBOutlet UIView *bianGengBtnView;
@property (strong, nonatomic) NSMutableArray *detailArray;
@property (strong, nonatomic) NSMutableArray *mArray;

//前一个页面获取到的数组
@property (strong, nonatomic) NSMutableArray *huodeArray;
@property (strong, nonatomic) NSDictionary * detailDic;
//获取到的数据下一级字典数组
@property(strong, nonatomic) NSDictionary *smallDic;
@property(strong, nonatomic) NSMutableArray *smallArray;
@property (strong, nonatomic) NSMutableArray *rowArray;

//@property(strong, nonatomic) NSDictionary *rowDic;

//区头Label
@property (strong, nonatomic) UILabel *qutouLabel;

@property (strong, nonatomic) ChargeView *chargV;

@property (strong, nonatomic) IBOutlet UIView *smallTouLianView;
@property (strong, nonatomic) IBOutlet UILabel *xinXiLabel;
@property (strong, nonatomic) IBOutlet UIView *tiShiLabel;
@property (strong, nonatomic) IBOutlet UIView *tiShiView;
@property (strong, nonatomic) UIButton *kongBtn;
@property (assign, nonatomic) BOOL isUp;




//+(instancetype)sharedManager;
//+(UIView*)awakeFromNib;
+(TouLianZhuiJiaXiangQingView *)awakeFromNib;
- (void)sizeToFit;
//- (IBAction)yinCangBtnClick:(id)sender;
- (IBAction)bianGengBtnClick:(id)sender;

- (IBAction)kongBtnClick:(id)sender;

- (IBAction)toumingBtnClick:(id)sender;



@end
