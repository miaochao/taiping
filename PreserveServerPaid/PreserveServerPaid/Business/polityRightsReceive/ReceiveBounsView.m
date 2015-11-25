//
//  ReceiveBounsView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/24.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "ReceiveBounsView.h"

@implementation ReceiveBounsView

+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"ReceiveBounsView" owner:self options:nil];
    
    
    return [array lastObject];
}
-(void)sizeToFit{
    [super sizeToFit];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
