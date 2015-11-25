//
//  LeaveView.h
//  PreserveServerPaid
//
//  Created by yang on 15/10/8.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

//点击头像退出登陆

#import <UIKit/UIKit.h>

@protocol leaveDelegate <NSObject>

-(void)pushVC;

@end
@interface LeaveView : UIView


@property (nonatomic,strong)id<leaveDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIButton *leaveBtn;
@property (weak, nonatomic) IBOutlet UILabel *leaveL;

@property (weak, nonatomic) IBOutlet UIView *backV;

@property (weak, nonatomic) IBOutlet UIView *centerView;

+(LeaveView*)awakeFromNib;
-(void)custemView:(NSInteger)num;
@end
