//
//  CommitmentBookView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/25.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommitmentBookView : UIView

@property (nonatomic,strong)NSString        *cateS;//登录人类型

@property (strong, nonatomic) UITextView *textV;

@property (weak, nonatomic) IBOutlet UIButton *chooseBtn;

@property (weak, nonatomic) IBOutlet UIButton *okBtn;

+(CommitmentBookView*)awakeFromNib;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)custem;
@end
