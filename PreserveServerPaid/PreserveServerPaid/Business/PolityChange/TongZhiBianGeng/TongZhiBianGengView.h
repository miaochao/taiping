//
//  TongZhiBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/23.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TongZhiBianGengView : UIView


@property (strong, nonatomic) IBOutlet UITableView *baoDanTabelView;


@property (strong, nonatomic) NSMutableArray *tabArray;
@property (strong, nonatomic) NSDictionary *tabDic;


+(TongZhiBianGengView *)awakeFromNib;



@end

