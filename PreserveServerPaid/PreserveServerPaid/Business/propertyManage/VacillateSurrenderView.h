//
//  VacillateSurrenderView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/8.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

//犹豫期退保

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

@interface VacillateSurrenderView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;

+(VacillateSurrenderView*)awakeFromNib;
-(void)custemView;
-(void)sizeToFit;
@end


#pragma mark  VacillateSurrenderViewCell

@interface VacillateSurrenderViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *numberL;

@property (weak, nonatomic) IBOutlet UILabel *polityNumberL;//保单号
@property (weak, nonatomic) IBOutlet UILabel *polityTimeL;//保单生效日
@property (weak, nonatomic) IBOutlet UILabel *polityNameL;//第一主险名称
@property (weak, nonatomic) IBOutlet UILabel *polityTypeL;//保单状态
@property (weak, nonatomic) IBOutlet UILabel *surrenderL;//是否可退保
@property (weak, nonatomic) IBOutlet UILabel *notRedundReason;//不可退保原因
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIImageView *imageV;




-(instancetype)initWithFrame:(CGRect)frame;
@end





#pragma mark VacillateSurrenderDateilView

@interface VacillateSurrenderDateilView : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,writeNameDelegate,messageTestViewDelegate>
@property (nonatomic,strong)NSDictionary    *dic;//用来传递数据
@property (nonatomic,strong)NSMutableArray  *mArray;

@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的view
@property (weak, nonatomic) IBOutlet UIView *rightDownView;//右下角的view
@property (strong, nonatomic) IBOutlet UITextField *textFOne;//保单体检费
@property (strong, nonatomic) IBOutlet UITextField *textFTwo;//保单工本费
@property (strong, nonatomic) IBOutlet UILabel *number;//退保应退金额
@property (strong, nonatomic) IBOutlet UILabel *numberAmount;//退保应退金额合计

@property (weak, nonatomic) IBOutlet UILabel *polityCode;//保单号
@property (weak, nonatomic) IBOutlet UILabel *polityCodeDown;//下面的保单号
@property (weak, nonatomic) IBOutlet UILabel *bankAccount;//原缴费账号
@property (weak, nonatomic) IBOutlet UILabel *accoOwnerName;//原账户所有人
@property (weak, nonatomic) IBOutlet UILabel *bankCode;//原账号所属银行
@property (weak, nonatomic) IBOutlet UILabel *accountType;//原账户类型


+(VacillateSurrenderDateilView *)awakeFromNib;
@end



#pragma mark VacillateSurrenderDateilView

@interface VacillateSurrenderDateilCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *numberL;//序号
@property (weak, nonatomic) IBOutlet UILabel *codeL;//代码
@property (weak, nonatomic) IBOutlet UILabel *nameL;//名称
@property (weak, nonatomic) IBOutlet UILabel *typeL;//状态

-(instancetype)initWithFrame:(CGRect)frame;
@end