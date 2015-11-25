//
//  LeaveView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/8.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "LeaveView.h"
#import "LoginViewController.h"
@implementation LeaveView

+(LeaveView*)awakeFromNib{
    return [[[NSBundle mainBundle] loadNibNamed:@"LeaveView" owner:nil options:nil] lastObject];
}
-(void)custemView:(NSInteger)num{
    if(num==1){
        self.backV.frame=CGRectMake(192, 0, 832, 704);
        self.centerView.frame=CGRectMake(411, 211, 393, 172);
    }else{
        self.backV.frame=CGRectMake(80, 0, 964, 704);
        self.centerView.frame=CGRectMake(411, 211, 393, 172);
        self.leaveBtn.frame=CGRectMake(65, 26, self.leaveBtn.frame.size.width, self.leaveBtn.frame.size.height);
        self.leaveL.frame=self.leaveBtn.frame;
    }
}

- (IBAction)btnClick:(UIButton *)sender {
    if (sender.tag==10) {
        [self.delegate pushVC];
        [self removeFromSuperview];
    }else{
        [self removeFromSuperview];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
