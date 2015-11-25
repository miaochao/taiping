//
//  ShouFeiBianGengVIew.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
@interface ShouFeiBianGengVIew : UIView<UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) IBOutlet UITableView *shouFeiTableView;
@property (strong, nonatomic) NSMutableArray *shouFeiArrray;
@property (strong, nonatomic) IBOutlet UIView *quanxuanView;

@property (strong,nonatomic) NSMutableArray *chooseArray;

@property (strong, nonatomic) IBOutlet UIButton *allChooseBtn;


@property (assign, nonatomic) BOOL isChoose;

+(ShouFeiBianGengVIew *)awakeFromNib;
- (IBAction)quanxuanBtnClick:(id)sender;


- (IBAction)quedingBtnClick:(id)sender;


@end
