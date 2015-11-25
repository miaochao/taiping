//
//  OmnipotentAdditionalInvestView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/13.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//万能追加投资
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface OmnipotentAdditionalInvestView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIView *allChooseView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(OmnipotentAdditionalInvestView*)awakeFromNib;

@end


#pragma mark  OmnipotentAdditionalInvestCell

@interface OmnipotentAdditionalInvestCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;
@property (weak, nonatomic) IBOutlet UILabel *polityNumL;
@property (weak, nonatomic) IBOutlet UILabel *nameL;

-(instancetype)initWithFrame:(CGRect)frame;

@end


#pragma mark  OmnipotentAdditionalInvestDetailView

@interface OmnipotentAdditionalInvestDetailView :UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSMutableArray      *mArray;
@property (nonatomic,strong)NSMutableArray      *array;//界面传值

@property (weak, nonatomic) IBOutlet UIView *rightView;//右边的收费账号信息

@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的view

@property (weak, nonatomic) IBOutlet UIView *redDownView;//下面的红色提示




@end

#pragma mark OmnipotentAdditionalInvestDetailCell

@interface OmnipotentAdditionalInvestDetailCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号

-(instancetype)initWithFrame:(CGRect)frame;

@end



#pragma mark OmnipotentAdditionalInvestDetailCellInCell

@interface OmnipotentAdditionalInvestDetailCellInCell : UITableViewCell

@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UILabel *productName;//险种名称
@property (weak, nonatomic) IBOutlet UILabel *accountValue;//当前账户价值

-(instancetype)initWithFrame:(CGRect)frame;

@end
