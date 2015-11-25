//
//  WriteNameView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/22.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "WriteNameView.h"
#import "DrawSignView.h"


@implementation WriteNameView


-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];

    if (self)
    {
        //self.bigTouMingBtn.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:0.8];
        
        self = [[[NSBundle mainBundle] loadNibNamed:@"WriteNameView" owner:nil options:nil] lastObject];
//        NSDate *timeDate=[NSDate date];//获取当前时间
//        NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
//        [timeFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//        NSString *zongShiJianString = [timeFormat stringFromDate:timeDate];
//        NSString *qianMingTimeString = [zongShiJianString substringToIndex:10];
//        self.qianMingRiQiLabel.text = [NSString stringWithFormat:@"%@",qianMingTimeString];
        
        [self getQianMIngView];
        
    }

    return self;
    
}


- (void)getQianMIngView
{
    
//    [PopSignUtil getSignWithVC:self withOk:^(UIImage *image) {
//        NSLog(@"image");
//        [PopSignUtil closePop];
//        //[sender setBackgroundImage:image forState:UIControlStateNormal];
//        //[sender setTitle:@"" forState:UIControlStateNormal];
//    } withCancel:^{
//        // NSLog(@"");
//        [PopSignUtil closePop];
//    }];
    DrawSignView *drawView = [[DrawSignView alloc] initWithFrame:CGRectMake(115, 165, 874, 536)];
    drawView.backgroundColor = [UIColor whiteColor];
    drawView.delegate=self;
    [self addSubview:drawView];
    
}
-(void)popView{
    [self.delegate writeNameEnd];
}
- (IBAction)queRenBtnClick:(id)sender
{
    _shangChuanView = [[UIView alloc] init];
    _shangChuanView.frame = CGRectMake(0, 64, 1024, 704);
    _shangChuanView.backgroundColor = [UIColor whiteColor];
    _shangChuanView.alpha = 0.5;
    [self addSubview:_shangChuanView];
    
    UIActivityIndicatorView *activiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activiView.frame = CGRectMake(_shangChuanView.frame.size.width/2, _shangChuanView.frame.size.height/2-30, 80, 80);
    [activiView startAnimating];
    
    [_shangChuanView addSubview:activiView];
    
    //    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320, 220, 50, 50)];
    //    imgView.image = [UIImage imageNamed:@"jiazai"];
    //    [_shangView addSubview:imgView];
    
    
    [self performSelector:@selector(removeView:) withObject:_shangChuanView afterDelay:2];
    
    NSLog(@"989898989898989");
    
}

- (IBAction)guanbiBtnClick:(id)sender
{
    if (self.end>1) {
        [[self superview] removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)touMingBtnClick:(id)sender
{
   
}

-(void)removeView:(UIView *)view
{
    [self.delegate writeNameEnd];
    [view removeFromSuperview];
    [self removeFromSuperview];
}



@end
