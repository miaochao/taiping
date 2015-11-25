//
//  QueryView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/18.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QueryView : UIView<UITextFieldDelegate>
{

    UIView *bigAddPickView;
    
}

@property (assign, nonatomic) BOOL isMan;
@property (assign, nonatomic) BOOL isTouch;

//@property (strong, nonatomic) NSTimer *pickViewTimer;
@property (strong, nonatomic) IBOutlet UIView *smallQueryView;
@property (strong, nonatomic) UIButton *touMingBtn;

//@property (strong, nonatomic) UIView *addPickerView;
@property (strong, nonatomic) UIImageView *changTiaoImageView;


//这三个是保单查询按钮
@property (strong, nonatomic) IBOutlet UIButton *nameOneBtn;
@property (strong, nonatomic) IBOutlet UIButton *bodyTwoBtn;
@property (strong, nonatomic) IBOutlet UIButton *numberThreeBtn;

//退出查询按钮
@property (strong, nonatomic) IBOutlet UIButton *exitBtn;
//提示标签
@property (strong, nonatomic) IBOutlet UILabel *keHunameLabel;
@property (strong, nonatomic) IBOutlet UILabel *baoDanHaoLabel;

//搜索输入框
@property (strong, nonatomic) IBOutlet UITextField *keHuNameTF;
@property (strong, nonatomic) IBOutlet UITextField *baoDanHaoTF;

//生日性别标签
@property (strong, nonatomic) IBOutlet UILabel *shengRiTouLabel;
@property (strong, nonatomic) IBOutlet UILabel *xingBeiTouLabel;


//查询按钮
@property (strong, nonatomic) IBOutlet UIButton *queryBtn;
@property (strong, nonatomic) IBOutlet UIView *queryBtnView;

//日期
@property (strong, nonatomic) UIButton *queryDateBtn;
@property (strong, nonatomic) UIDatePicker *queryDatePicker;
@property (strong, nonatomic) UIButton *pickerQuXiaoBtn;
@property (strong, nonatomic) UIButton *pickerQueDingBtn;
@property (strong, nonatomic) UIView *shengRiSmallView;

//性别
@property (strong, nonatomic) IBOutlet UIImageView *xingBieImageView;
@property (strong, nonatomic) IBOutlet UIButton *xingBieBtn;
@property (strong, nonatomic) NSString *shengRiString;



@property (nonatomic,assign)int             number;//根据它进入页面

//+ (id)sharedManager;


@end
