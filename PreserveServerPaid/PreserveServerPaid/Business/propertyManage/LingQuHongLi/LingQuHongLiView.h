//
//  LingQuHongLiView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChargeView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

@interface LingQuHongLiView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UIView *quanXuanView;
//@property (strong, nonatomic) UITableView *hongliTabV;
//@property (strong, nonatomic) NSMutableArray *tabvArray;
@property (strong, nonatomic) NSMutableArray *quanArray;

@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

@property (strong, nonatomic) IBOutlet UIButton *queDingBtn;



+(LingQuHongLiView *)awakeFromNib;
- (IBAction)quanXuanBtnClick:(id)sender;

- (IBAction)queDingBtnClick:(id)sender;

@end


@interface LingQuHongLiViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIButton *danxuanBtn;
@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *jinELabel;


- (instancetype)initWithFrame:(CGRect)frame;


@end



@interface LingQuHongLiXinagQingView : UIView<messageTestViewDelegate,writeNameDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) NSMutableArray *huodeArray;
@property (strong, nonatomic) NSMutableArray *xiangArray;

@property (strong, nonatomic) UITableView *xiangTabv;


@property (strong, nonatomic) IBOutlet UIView *smallXiangView;
@property (strong, nonatomic) IBOutlet UIView *wenXinView;
@property (strong, nonatomic) ChargeView *chargeV;
@property (strong, nonatomic) UIButton *kongBtn;
@property (strong, nonatomic) IBOutlet UILabel *lingQuXinXiLabel;
//变更按钮
@property (strong, nonatomic) IBOutlet UIView *bianGengView;
@property (strong, nonatomic) UIButton *biangengBtn;
@property (assign, nonatomic) BOOL isUp;

+(LingQuHongLiXinagQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)baingengBtnClick:(id)sender;

@end


@interface LingQuHongLiSmallheadView : UIView



@property (strong, nonatomic) IBOutlet UILabel *headLabel;


+(LingQuHongLiSmallheadView *)awakeFromNib;
- (void)sizeToFit;



@end

@interface LingQuHongLiXinagQingViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *xuhaoLabel;

@property (strong, nonatomic) IBOutlet UILabel *xianMIngLabel;

@property (strong, nonatomic) IBOutlet UILabel *benxihejiLabel;

@property (strong, nonatomic) IBOutlet UILabel *baodanHejiLabel;

@property (strong, nonatomic) IBOutlet UITextField *benxiTf;


- (instancetype)initWithFrame:(CGRect)frame;

@end


