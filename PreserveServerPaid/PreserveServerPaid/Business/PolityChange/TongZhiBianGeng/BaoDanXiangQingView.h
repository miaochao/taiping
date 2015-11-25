//
//  BaoDanXiangQingView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/24.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"

@interface BaoDanXiangQingView : UIView<messageTestViewDelegate,writeNameDelegate>

@property (strong, nonatomic) IBOutlet UIView *touMingView;
@property (strong, nonatomic) NSDictionary *detailDic;

@property (strong, nonatomic) IBOutlet UILabel *xinJianLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiZhiLabel;
@property (strong, nonatomic) IBOutlet UILabel *duanXinLabel;
@property (strong, nonatomic) IBOutlet UILabel *youXiangLabel;
@property (strong, nonatomic) IBOutlet UILabel *ziZhuLabel;


@property (strong, nonatomic) IBOutlet UILabel *tongZhiShuLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhiZhiQueRenLabel;
@property (strong, nonatomic) IBOutlet UILabel *gaoZhiLabel;
@property (strong, nonatomic) IBOutlet UILabel *youXiangQueRenLabel;
@property (strong, nonatomic) IBOutlet UILabel *ziZhuQueRenLabel;

@property (strong, nonatomic) IBOutlet UIButton *zhiZhiBtn;
@property (strong, nonatomic) IBOutlet UIButton *youXiangBtn;
@property (strong, nonatomic) IBOutlet UIButton *ziZhuBtn;

@property (strong, nonatomic) IBOutlet UILabel *zhiZhiBtnLabel;

@property (strong, nonatomic) IBOutlet UILabel *youXiangBtnLabel;

@property (strong, nonatomic) IBOutlet UILabel *ziZhiBtnLabel;


@property (strong, nonatomic) IBOutlet UIView *bianGengView;
@property (strong, nonatomic) IBOutlet UIButton *bianGengBtn;

//通知方式字符串
@property (strong, nonatomic)NSString *fangshiStr;
@property (strong, nonatomic)NSString *leixingStr;


//确认变更
- (IBAction)queRenBtnClick:(id)sender;

- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)zhiZhiBtnClick:(id)sender;

- (IBAction)youXiangBtnClick:(id)sender;

- (IBAction)ziZhuBtnClick:(id)sender;
//+(instancetype)sharedManager;

+(BaoDanXiangQingView *)awakeFromNib;

@end
