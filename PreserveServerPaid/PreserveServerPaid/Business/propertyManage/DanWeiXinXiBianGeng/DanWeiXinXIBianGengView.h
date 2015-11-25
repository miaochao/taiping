//
//  DanWeiXinXIBianGengView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/12.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteNameView.h"
#import "BaoQuanPiWenView.h"
#import "MessageTestView.h"

@interface DanWeiXinXIBianGengView : UIView<messageTestViewDelegate,writeNameDelegate>

@property (strong, nonatomic) IBOutlet UIView *smallDanWeiView;

@property (strong, nonatomic) UITextField *dizhiTf;
@property (strong, nonatomic) UITextField *youbianTf;
@property (strong, nonatomic) UITextField *dianhuaTf;


@property (nonatomic,strong)NSString        *address;
@property (nonatomic,strong)NSString        *postcode;
@property (nonatomic,strong)NSString        *phone;

+(DanWeiXinXIBianGengView *)awakeFromNib;
- (IBAction)queDingDanWeiBtnClick:(id)sender;


@end
