//
//  CoverClearView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/23.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "CoverClearView.h"

@implementation CoverClearView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
 [[NSNotificationCenter defaultCenter] addObserver:self
 selector:@selector(aWindowBecameMain:)
 name:NSWindowDidBecomeMainNotification object:nil];
 
*/

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(CoverViewClick) name:@"RemoveClearViewNotification" object:nil];
        
       // self.backgroundColor = [UIColor redColor];
        
    }

    return self;
    
}


- (void)CoverViewClick
{

    [self removeFromSuperview];

}



@end
