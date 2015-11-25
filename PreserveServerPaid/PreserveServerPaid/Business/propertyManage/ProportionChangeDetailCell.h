//
//  ProportionChangeDetailCell.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/30.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProportionChangeDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *accountNumber;
@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *money;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@property (weak, nonatomic) IBOutlet UITextField *numberTF;

@end
