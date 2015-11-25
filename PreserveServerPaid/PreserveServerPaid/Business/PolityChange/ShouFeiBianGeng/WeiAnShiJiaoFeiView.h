//
//  WeiAnShiJiaoFeiView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"

@interface WeiAnShiJiaoFeiView : UIView<messageTestViewDelegate,writeNameDelegate,UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) BOOL isChoose;
@property (assign, nonatomic) BOOL isXuanZe;


@property (strong, nonatomic) IBOutlet UIView *quanXuanView;

@property (strong, nonatomic) NSMutableArray *detailArray;
@property (strong, nonatomic) NSMutableArray *chooseArray;
@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;



+(WeiAnShiJiaoFeiView *)awakeFromNib;

- (IBAction)quanXuanBtnClick:(id)sender;

- (IBAction)quedingBtnClick:(id)sender;



@end
