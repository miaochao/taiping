//
//  HistoryChangeQueryView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/14.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//
//历史变更记录查询
#import <UIKit/UIKit.h>

@interface HistoryChangeQueryView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray      *mArray;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;//责任状态
@property (weak, nonatomic) IBOutlet UIImageView *timeImageV;//时间升序降序

+(UIView*)awakeFromNib;
@end



@interface HistoryChangeQueryDetailView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *baseView;//右边的底层view


@property (weak, nonatomic) IBOutlet UILabel *beginTimeL;//开始时间
@property (weak, nonatomic) IBOutlet UILabel *endTimeL;//结束时间




@property (nonatomic,strong)NSMutableArray          *mArray;

@end



@interface HistoryChangeQueryDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btn;//查看
@property (weak, nonatomic) IBOutlet UILabel *changeId;//保全ID
@property (weak, nonatomic) IBOutlet UILabel *serviceName;// 保全项目
@property (weak, nonatomic) IBOutlet UILabel *changeStatus;//保全操作状态
@property (weak, nonatomic) IBOutlet UILabel *noticeCode;// 保全批单号
@property (weak, nonatomic) IBOutlet UILabel *handlerName;//申请人姓名
@property (weak, nonatomic) IBOutlet UILabel *proposeTime;//保全申请时间
@property (weak, nonatomic) IBOutlet UILabel *validateDate;//保全生效时间
@property (weak, nonatomic) IBOutlet UILabel *channelDesc;//保全操作途径

-(instancetype)initWithFrame:(CGRect)frame;

@end

@interface HistoryCheckView : UIView

@property (strong,nonatomic)NSString          *str;
@property (strong, nonatomic) IBOutlet UIView *smallCheckView;
@property (weak, nonatomic) IBOutlet UILabel *approval;//批文



- (IBAction)checkCloseBtnClick:(id)sender;



@end

