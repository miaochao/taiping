//
//  WriteNameView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/22.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopSignUtil.h"

@protocol writeNameDelegate <NSObject>

-(void)writeNameEnd;

@end
@interface WriteNameView : UIView<DrawSignViewDelegate>

//日期标签，确认按钮
@property (strong, nonatomic) IBOutlet UILabel *qianMingRiQiLabel;
@property (strong, nonatomic) IBOutlet UIView *titalView;
@property (strong, nonatomic) IBOutlet UILabel *qianmingTime;
//@property (strong, nonatomic) IBOutlet UIButton *queRenBtn;
//提交签名等待
@property (strong, nonatomic) UIView *shangChuanView;

//透明按钮
@property (strong, nonatomic) IBOutlet UIButton *bigTouMingBtn;
@property (strong, nonatomic) IBOutlet UIButton *guanbiBtn;

@property (nonatomic,assign)int        end;//退还保单结余款项

- (IBAction)guanbiBtnClick:(id)sender;
- (IBAction)touMingBtnClick:(id)sender;

@property (nonatomic,assign)id<writeNameDelegate>delegate;

@end
