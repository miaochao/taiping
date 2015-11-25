//
//  MainXSZYView.m
//  PreserveServerPaid
//
//  Created by yang on 15/10/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MainXSZYView.h"
#import "QueryView.h"

@implementation MainXSZYView
{
    QueryView   *queryView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

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

@end


#pragma mark  MainXSZYPropertyView

@implementation MainXSZYPropertyView
{
    QueryView   *queryView;
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

@end


#pragma mark  MainXSZYQueryView

@implementation MainXSZYQueryView
{
    QueryView   *queryView;
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

@end