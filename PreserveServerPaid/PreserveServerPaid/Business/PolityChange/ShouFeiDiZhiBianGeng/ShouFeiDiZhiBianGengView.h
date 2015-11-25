//
//  ShouFeiDiZhiBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/13.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

@interface ShouFeiDiZhiBianGengView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UITableView *diZhiTabV;
@property (strong, nonatomic) NSMutableArray *tabvArray;


+(ShouFeiDiZhiBianGengView *)awakeFromNib;

@end


@interface ShouFeiDiZhiBianGengViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UILabel *danhaoLabel;
@property (strong, nonatomic) IBOutlet UILabel *baorenLabel;
@property (strong, nonatomic) IBOutlet UILabel *zhuangtaiLabel;


//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithFrame:(CGRect)frame;

@end

@interface  ShouFeiDiZhiXiangQingView: UIView<messageTestViewDelegate,writeNameDelegate>


@property (strong, nonatomic) IBOutlet UIView *bianGengView;

@property (strong, nonatomic) IBOutlet UILabel *xiangQingLabel;

@property (strong, nonatomic) IBOutlet UITextField *diZhiTf;
@property (strong, nonatomic) IBOutlet UITextField *youBianTf;

@property (nonatomic,strong)NSString        *address;
@property (nonatomic,strong)NSString        *postcode;
@property (nonatomic,strong)NSString        *polityCode;

+(ShouFeiDiZhiXiangQingView *)awakeFromNib;

- (IBAction)yinCangBtnClick:(id)sender;

- (IBAction)baingengBtnClick:(id)sender;


@end


