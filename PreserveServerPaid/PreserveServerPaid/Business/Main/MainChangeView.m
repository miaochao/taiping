//
//  mainChangeView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/21.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MainChangeView.h"

@implementation MainChangeView

- (id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    if (self)
    {
        self=[[[NSBundle mainBundle]loadNibNamed:@"MainChangeView" owner:nil options:nil]lastObject];
    }
    return self;
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MainChangeView" owner:self options:nil];
    return [array lastObject];
}
- (IBAction)buttonClick:(UIButton *)sender{

    self.bigQueryView = [[QueryView alloc] init];
    self.bigQueryView.number=sender.tag;
    self.bigQueryView.frame= CGRectMake(192, 64, 832, 704);
    
    self.bigQueryView.backgroundColor = [UIColor clearColor];
    [[[self superview] superview] addSubview:self.bigQueryView];
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 64, 192, 704)];
    view.tag=10000;
    view.backgroundColor=[UIColor clearColor];
    [[[self superview] superview] addSubview:view];
    
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
