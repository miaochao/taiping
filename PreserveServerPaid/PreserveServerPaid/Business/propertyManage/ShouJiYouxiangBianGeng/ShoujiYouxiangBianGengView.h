//
//  ShoujiYouxiangBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"

@interface ShoujiYouxiangBianGengView : UIView<messageTestViewDelegate,writeNameDelegate>

@property (strong, nonatomic) IBOutlet UIView *smallBianView;

@property (strong, nonatomic) IBOutlet UITextField *shouJiTf;

@property (strong, nonatomic) IBOutlet UITextField *youxiangTf;
@property (nonatomic,strong)NSString        *address;
@property (nonatomic,strong)NSString        *postcode;



+(ShoujiYouxiangBianGengView *)awakeFromNib;

- (IBAction)biangengBtnClick:(id)sender;



@end
