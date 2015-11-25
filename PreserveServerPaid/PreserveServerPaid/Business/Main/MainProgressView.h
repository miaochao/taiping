//
//  MainProgressView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/22.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainProgressView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UITextField     *numberTF;//保单号

@property (weak, nonatomic) IBOutlet UIButton *dateBtn1;
@property (weak, nonatomic) IBOutlet UIButton *dateBtn2;

@property (nonatomic,strong)NSMutableArray      *mArray;

+(UIView*)awakeFromNib;
-(void)customUI;
@end
