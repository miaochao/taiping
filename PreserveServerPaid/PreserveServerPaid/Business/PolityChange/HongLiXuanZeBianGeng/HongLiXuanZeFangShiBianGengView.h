//
//  HongLiXuanZeFangShiBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "ThreeViewController.h"
#import "PreserveServer-Prefix.pch"

@interface HongLiXuanZeFangShiBianGengView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) NSMutableArray *tabvArray;
@property (strong, nonatomic) UITableView *diZhiTabV;


+(HongLiXuanZeFangShiBianGengView *)awakeFromNib;

@end


@interface HongLiXuanZeFangShiBianGengViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *baorenLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuangtaiLabel;

-(instancetype)initWithFrame:(CGRect)frame;

@end


@interface HongLiXuanZeFangShiXiangQingView : UIView<messageTestViewDelegate,writeNameDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *bianGengView;
@property (strong, nonatomic) IBOutlet UILabel *xiangQingLabel;


@property (strong, nonatomic) IBOutlet UIView *smallHongLiView;
@property (strong, nonatomic) UIView *smallFangShiView;


//变更需要传的参数
@property (strong, nonatomic) NSMutableDictionary *chuanDiDic;

//前一页传来的数据
@property id<TPLBonusWayBOModel>huoDeDic;
//取出huoDeDic 中的数组
@property (strong, nonatomic) NSArray *huoDeArray;


+(HongLiXuanZeFangShiXiangQingView *)awakeFromNib;
- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)baingengBtnClick:(id)sender;

- (IBAction)fangshIBtnClick:(id)sender;



@end


@interface  HongLiXuanZeFangShiXiangQingViewCell: UITableViewCell


@property (strong, nonatomic) IBOutlet UIButton *fangshiBtn;
@property (strong, nonatomic) IBOutlet UILabel *xianzhongLabel;

@property (strong, nonatomic) IBOutlet UILabel *fenHongLabel;
@property (strong, nonatomic) IBOutlet UILabel *fangshiLabel;




-(instancetype)initWithFrame:(CGRect)frame;


@end



