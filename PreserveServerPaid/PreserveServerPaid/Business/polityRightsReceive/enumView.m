//
//  enumView.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/24.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "enumView.h"
#import "SurvivalAccountCell.h"
@implementation enumView
{
    NSMutableArray      *array;
    int                 btnTag;
    UITableView         *tableV;
}
-(instancetype)initWithFrame:(CGRect)frame mArray:(NSMutableArray *)mArray title:(NSString *)str{
    self=[super initWithFrame:frame];
    if (self) {
        array=mArray;
        [self creataView:str];
    }
    return self;
}
-(void)creataView:(NSString *)str{
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 18)];
    [self addSubview:label];
    label.text=str;
    label.textColor=[UIColor whiteColor];
    label.backgroundColor=[UIColor blueColor];
    label.textAlignment=UITextAlignmentCenter;
    
    tableV=[[UITableView alloc] initWithFrame:CGRectMake(0, 18, self.frame.size.width, self.frame.size.height-18)];
    [self addSubview:tableV];
    tableV.delegate=self;
    tableV.dataSource=self;
    tableV.rowHeight=18;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    enumTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        
        cell=[[enumTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.label.text=[array objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    [self.delegate enumViewDelegateString:[array objectAtIndex:indexPath.row]];
    [self removeFromSuperview];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end



@implementation enumTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.label=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 18)];
        NSLog(@"%@",self.frame);
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.textColor=[UIColor blackColor];
//        self.label.backgroundColor=[UIColor greenColor];
        [self addSubview:self.label];
    }
    return self;
}
-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.label=[[UILabel alloc] initWithFrame:self.frame];
        NSLog(@"%f",self.frame.origin.y);
        self.label.textAlignment=NSTextAlignmentCenter;
        self.label.font=[UIFont systemFontOfSize:12];
        self.label.textColor=[UIColor blackColor];
        //        self.label.backgroundColor=[UIColor greenColor];
        [self addSubview:self.label];
    }
    return self;
}
@end
