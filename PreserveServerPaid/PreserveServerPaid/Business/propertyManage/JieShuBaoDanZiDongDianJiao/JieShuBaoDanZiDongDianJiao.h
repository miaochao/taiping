//
//  JieShuBaoDanZiDongDianJiao.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "ChargeView.h"


@interface JieShuBaoDanZiDongDianJiao : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *diZhiTabV;
@property (strong, nonatomic) NSMutableArray *tabvArray;

@property (strong, nonatomic) NSMutableArray *chooseArray;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

@property (strong, nonatomic) IBOutlet UIView *quanXuanView;
@property (strong, nonatomic) IBOutlet UIButton *querenBtn;




@property (assign, nonatomic) BOOL isXuanZe;

+(JieShuBaoDanZiDongDianJiao *)awakeFromNib;

- (IBAction)quanXuanBtnClick:(id)sender;

- (IBAction)queDingBtnClick:(id)sender;


@end



@interface JieShuBaoDanZiDongDianJiaoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *danxuanBtn;

@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuXianLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuangtaiLabel;


- (instancetype)initWithFrame:(CGRect)frame;

@end


@interface JieShuBaoDanZiDongDianJiaoXiangQingView : UIView<messageTestViewDelegate,writeNameDelegate,UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *smallXiangView;
@property (strong, nonatomic) IBOutlet UIView *wenXinView;
@property (strong, nonatomic) ChargeView *chargeV;
@property (strong, nonatomic) UIButton *kongBtn;
@property (strong, nonatomic) NSMutableArray *huodeArray;
@property (strong, nonatomic) NSMutableArray *detailArray;


@property (strong, nonatomic) IBOutlet UILabel *lingQuXinXiLabel;
//变更按钮

@property (strong, nonatomic) IBOutlet UIView *bianGengView;
@property (strong, nonatomic) UIButton *biangengBtn;
@property (assign, nonatomic) BOOL isUp;




+(JieShuBaoDanZiDongDianJiaoXiangQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)baingengBtnClick:(id)sender;


@end



//详情页Cell
@interface JieShuBaoDanZiDongDianJiaoXiangQingViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *xuhaoLabel;

@property (strong, nonatomic) IBOutlet UILabel *xianmingLabel;

@property (strong, nonatomic) IBOutlet UILabel *zhuangtaiLabel;

@property (strong, nonatomic) IBOutlet UILabel *dangqianFeiLabel;

@property (strong, nonatomic) IBOutlet UILabel *xiaqiFeiLabel;

@property (strong, nonatomic) IBOutlet UILabel *hejiJinLabel;


- (instancetype)initWithFrame:(CGRect)frame;


@end






 
