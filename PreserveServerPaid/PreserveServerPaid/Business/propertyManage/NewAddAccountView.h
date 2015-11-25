//
//  NewAddAccountView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/9.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

//新增盈账户

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

@interface NewAddAccountView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray          *mArray;

+(NewAddAccountView*)awakeFromNib;
-(void)custemView;
@end



#pragma mark NewAddAccountCell
@interface NewAddAccountCell : UITableViewCell

@property (nonatomic,strong)UILabel         *numberL;
@property (nonatomic ,strong)UILabel       *accountL;
@property (nonatomic,strong)UILabel        *nameL;

//-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@end



#pragma mark  NewAddAccountDetailView
@interface NewAddAccountDetailView : UIView<writeNameDelegate,messageTestViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *addNewAccountBtn;
@property (weak, nonatomic) IBOutlet UIButton *addNewAccountBtn1;

@property (nonatomic,strong)NSString        *polityCode;//用来传保单号

@property (weak, nonatomic) IBOutlet UIView *rightView;//右边底层view
@property (weak, nonatomic) IBOutlet UIView *addNewAccountView;//新增万能账户信息

@property (weak, nonatomic) IBOutlet UITextField *textF;//首期保费

@property (weak, nonatomic) IBOutlet UIButton *certainBtn;//确定变更


+(NewAddAccountDetailView*)awakeFromNib;
-(void)custemView;

@end


#pragma mark NewAddAccountDetailViewCell

@interface NewAddAccountDetailViewCell : UITableViewCell

-(instancetype)initWithFrame:(CGRect)frame;

@end