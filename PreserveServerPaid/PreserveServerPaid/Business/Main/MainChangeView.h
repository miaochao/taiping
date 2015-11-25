//
//  mainChangeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/21.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QueryView.h"
@interface MainChangeView : UIView

@property (strong,nonatomic)QueryView *bigQueryView;


- (id)initWithFrame:(CGRect)frame;
+(UIView*)awakeFromNib;
@end
