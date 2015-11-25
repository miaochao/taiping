//
//  BaoDanNianDuBaoGaoView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

@interface BaoDanNianDuBaoGaoView : UIView<UITableViewDataSource, UITableViewDelegate>

//typedef NS_ENUM(NSInteger, Page)
//{
//    //以下是枚举成员
//    BaoDanNianDuBaoGaoBianGeng = 0,
//    ZhuanZhangChengGongTongZhiShuBianGeng = 1,
// 
//};

@property (strong, nonatomic) UITableView *baoDanNianTabV;
@property (strong, nonatomic) NSMutableArray *tabvArray;
@property (assign, nonatomic) int pageTag;


+(BaoDanNianDuBaoGaoView *)awakeFromNib;

@end



@interface BaoDanNianDuViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *baorenLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuangtaiLabel;


//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithFrame:(CGRect)frame;

@end



@interface BaoDanNianDuXiangQingView : UIView<messageTestViewDelegate,writeNameDelegate>


@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

@property (strong, nonatomic) IBOutlet UILabel *gongyongLabel;

@property (strong, nonatomic) IBOutlet UIButton *zhiZhiBtn;
@property (strong, nonatomic) IBOutlet UIButton *youXiangBtn;
@property (strong, nonatomic) IBOutlet UIButton *duanXinBtn;



//前一页传来的数据
@property id<TPLSendWayBOModel>huoDeDic;
//信件发送方式
@property (strong, nonatomic) NSString *noticeWayString;
//信件类型
@property (strong, nonatomic) NSString *noticeTypeString;



@property (strong, nonatomic) IBOutlet UIView *smallXiangQingView;
@property (strong, nonatomic) IBOutlet UIView *addBtnView;//添加背景的View

@property (strong, nonatomic) IBOutlet UILabel *duanXinYesLabel;//是否短信
@property (strong, nonatomic) IBOutlet UIButton *ziZhuBtn;//自主查询按钮
@property (assign, nonatomic) int xiangQingTag;//区分哪个界面
@property (strong, nonatomic) IBOutlet UIView *bianGengView;//放置变更按钮的view



+(BaoDanNianDuXiangQingView *)awakeFromNib;
- (IBAction)queRenBtnClick:(id)sender;
- (IBAction)yinCangBtnClick:(id)sender;
- (IBAction)zhiZhiBtnClick:(id)sender;
- (IBAction)youXiangBtnClick:(id)sender;
- (IBAction)ziZhuBtnClick:(id)sender;

- (IBAction)duanXinBtnClick:(id)sender;





@end
