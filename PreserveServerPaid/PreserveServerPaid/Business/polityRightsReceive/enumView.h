//
//  enumView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/24.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol enumViewDelegate <NSObject>

-(void)enumViewDelegateString:(NSString *)str;

@end

@interface enumView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)NSString    *chooseStr;
@property (nonatomic,strong)NSString    *title;
@property (nonatomic,assign)id<enumViewDelegate> delegate;
-(instancetype)initWithFrame:(CGRect)frame mArray:(NSMutableArray *)mArray title:(NSString *)str;

@end



@interface enumTableViewCell : UITableViewCell

@property (nonatomic,strong)UILabel     *label;

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
-(id)initWithFrame:(CGRect)frame;

@end