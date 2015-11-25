//
//  DrawSignView.h
//  YRF
//
//  Created by jun.wang on 14-5-28.
//  Copyright (c) 2014年 王军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyView.h"

@protocol DrawSignViewDelegate <NSObject>

-(void)popView;

@end

typedef void(^SignCallBackBlock) (UIImage*);
typedef void(^CallBackBlock) ();

@interface DrawSignView : UIView


@property (nonatomic,strong) UIView *shangView;
@property (nonatomic,strong)id<DrawSignViewDelegate> delegate;
@property(nonatomic,copy)SignCallBackBlock signCallBackBlock;
@property(nonatomic,copy)CallBackBlock cancelBlock;

@property (nonatomic,strong)NSMutableArray *qianArray;

@end
