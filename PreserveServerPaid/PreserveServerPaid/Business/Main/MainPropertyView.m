//
//  MainPropertyView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/22.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MainPropertyView.h"
#import "QueryView.h"
@implementation MainPropertyView{
    QueryView   *queryView;
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MainPropertyView" owner:self options:nil];
    return [array lastObject];
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    queryView = [[QueryView alloc] init];
    queryView.number=sender.tag;
    queryView.frame= CGRectMake(192, 64, 832, 704);
    queryView.backgroundColor = [UIColor clearColor];
    [[[self superview] superview] addSubview:queryView];
    
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
