//
//  MainProgressTableCell.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/23.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProgressTableCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *polityNumber;//保单号码
@property (weak, nonatomic) IBOutlet UILabel *polityID;//保全ID号
@property (weak, nonatomic) IBOutlet UILabel *polityType;//保全项目
@property (weak, nonatomic) IBOutlet UILabel *state;//操作状态
@property (weak, nonatomic) IBOutlet UILabel *polityOneNum;//保全批单号
@property (weak, nonatomic) IBOutlet UILabel *name;//声请人姓名
@property (weak, nonatomic) IBOutlet UILabel *time;//保全申请时间
@property (weak, nonatomic) IBOutlet UILabel *passBy;//保全操作途径

@end
