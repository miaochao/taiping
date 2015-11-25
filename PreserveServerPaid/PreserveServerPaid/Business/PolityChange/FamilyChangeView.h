//
//  FamilyChangeView.h
//  PreserveServerPaid
//
//  Created by yang on 15/9/29.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageTestView.h"
#import "WriteNameView.h"

@interface FamilyChangeView : UIView<UITextFieldDelegate,messageTestViewDelegate,writeNameDelegate>


@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic,strong)NSString        *address;
@property (nonatomic,strong)NSString        *postcode;
@property (nonatomic,strong)NSString        *phone;

@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UITextField *postcodeTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

+(FamilyChangeView*)awakeFromNib;

-(void)custemView;

-(void)sizeToFit;
@end
