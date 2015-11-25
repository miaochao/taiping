//
//  OmnipotentInsuranceSomeReceiveView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/13.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//万能险部分领取
#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
@interface OmnipotentInsuranceSomeReceiveView : UIView<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIView *allChooseView;
@property (weak, nonatomic) IBOutlet UIButton *okBtn;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;

+(OmnipotentInsuranceSomeReceiveView*)awakeFromNib;


@end

#pragma mark  OmnipotentInsuranceSomeReceiveDetailView

@interface OmnipotentInsuranceSomeReceiveDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)NSMutableArray      *array;
@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UIView *rightView;//右边的收费账号信息

@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的view

@property (weak, nonatomic) IBOutlet UIView *redDownView;//下面的红色提示

@end


#pragma mark OmnipotentInsuranceSomeReceiveDetailCell

@interface OmnipotentInsuranceSomeReceiveDetailCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

@property (weak, nonatomic) IBOutlet UILabel *polityNumL;//保单号

-(instancetype)initWithFrame:(CGRect)frame;

@end



#pragma mark OmnipotentInsuranceSomeReceiveDetailCellInCell

@interface OmnipotentInsuranceSomeReceiveDetailCellInCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productName;//险种名称
@property (weak, nonatomic) IBOutlet UILabel *accountName;//账户名称
@property (weak, nonatomic) IBOutlet UILabel *accunUnits;//现有账户余额
@property (weak, nonatomic) IBOutlet UITextField *textF;


-(instancetype)initWithFrame:(CGRect)frame;

@end
