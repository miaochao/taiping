//
//  BaoQuanPiWenView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/29.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "BaoQuanPiWenView.h"
#import "ThreeViewController.h"
@implementation BaoQuanPiWenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+(UIView*)awakeFromNib
{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"BaoQuanPiWenView" owner:self options:nil];
    
    BaoQuanPiWenView *piView = (BaoQuanPiWenView *)[array lastObject];
    piView.smallPiView.layer.borderWidth = 1;
    piView.smallPiView.layer.borderColor = [[UIColor grayColor] CGColor];
    
    return piView;
}

- (IBAction)piWenBtnClick:(id)sender
{
    ThreeViewController *vc=[ThreeViewController sharedManager];
    UIButton *btn=nil;
    [vc  goBack:btn];
    
    [self removeFromSuperview];
    
}




@end
