//
//  MainPropertyView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/22.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPropertyView : UIView
@property (weak, nonatomic) IBOutlet UIButton *addNewAccountBtn;//新增盈账户
@property (weak, nonatomic) IBOutlet UILabel *addNewAccountL;//新增盈账户


+(UIView*)awakeFromNib;
@end
