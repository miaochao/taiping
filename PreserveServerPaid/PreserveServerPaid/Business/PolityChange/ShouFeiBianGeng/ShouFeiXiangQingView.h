//
//  ShouFeiXiangQingView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChargeView.h"
#import "MessageTestView.h"
#import "WriteNameView.h"

@interface ShouFeiXiangQingView : UIView<messageTestViewDelegate,writeNameDelegate>


@property (strong, nonatomic) IBOutlet UIButton *bianGengBtn;
@property (strong, nonatomic) IBOutlet UIView *touMingView;

@property (strong,nonatomic) ChargeView *chargView;

@property (strong, nonatomic) IBOutlet UIView *bianGengView;
//接收前一个页面的数据
@property (strong, nonatomic) NSMutableArray *detailArray;



@property (strong, nonatomic) IBOutlet UIView *smallXiangView;

//+(UIView*)awakeFromNib;
//+(instancetype)sharedManager;

+(ShouFeiXiangQingView *)awakeFromNib;

- (IBAction)bianGengBtnClick:(id)sender;

- (IBAction)yinCangBtnClick:(id)sender;



@end
