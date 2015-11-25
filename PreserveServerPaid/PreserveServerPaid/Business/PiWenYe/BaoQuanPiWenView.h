//
//  BaoQuanPiWenView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/29.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaoQuanPiWenView : UIView


@property (strong, nonatomic) IBOutlet UIView *smallPiView;


+(UIView*)awakeFromNib;

- (IBAction)piWenBtnClick:(id)sender;


@end
