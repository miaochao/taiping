//
//  ProportionChangeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/28.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//投连账户投资比例变更
#import <UIKit/UIKit.h>
#import "enumView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"
@interface ProportionChangeView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

+(ProportionChangeView*)awakeFromNib;
-(void)custemView;
- (void)sizeToFit;
@end


@interface ProportionChangeViewCell : UITableViewCell

@property (nonatomic,strong)UILabel     *num;//数字
@property (nonatomic,strong)UILabel     *numberL;//保单号
@property (nonatomic,strong)UILabel     *nameL;//第一主险

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end


@interface ProportionChangeDetailView : UIView<UITableViewDataSource,UITableViewDelegate,enumViewDelegate,messageTestViewDelegate,writeNameDelegate,UITextFieldDelegate>
@property (nonatomic,strong)NSMutableArray  *mArray;
@property (nonatomic,strong)NSDictionary    *dic;//用于数据传递

@property (strong, nonatomic) IBOutlet UIView *smallDetailView;

@property (weak, nonatomic) IBOutlet UITextField *addNewAccountTF;//新增账户

@property (weak, nonatomic) IBOutlet UIView *allChooseView;//全选按钮view


@property (weak, nonatomic) IBOutlet UIView *delegateView;//删除按钮view
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIView *downView;
@property (weak, nonatomic) IBOutlet UILabel *internalId;//险种序号
@property (weak, nonatomic) IBOutlet UILabel *productName;//险种名称
@property (weak, nonatomic) IBOutlet UILabel *polityCode;//保单号


+(ProportionChangeDetailView*)awakeFromNib;
-(void)custemView;

@end


@interface ProportionChangeDetailViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *accountNumber;
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;



-(instancetype)initWithFrame:(CGRect)frame;
@end