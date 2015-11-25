//
//  SmartQueryView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/28.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "SmartQueryView.h"
#import "PreserveServer-Prefix.pch"
#define URL @"/servlet/hessian/com.cntaiping.intserv.custserv.customer.CustomerIdentityServlet"
@implementation SmartQueryView
{
    int             type;//用来记录是那种方式（姓名+身份证、身份证+保单号、姓名+性别+生日+保单号）
    NSString        *gerder;//性别
    NSString        *brithday;//生日
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)init
{
    self = [super init];
    if (self)
    {
        type=1;
        gerder=@"M";
        //        _pickViewTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerClick) userInfo:nil repeats:YES];
        //        [_pickViewTimer fire];
        
//        self.touMingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 832, 768)];
//        self.touMingView.backgroundColor = [UIColor grayColor];
//        self.touMingView.alpha = 0.5;
//        [self addSubview:self.touMingView];
        
//        self.smallQueryView = [[UIView alloc] init];
//        self.smallQueryView.frame = CGRectMake(91, 190, 660, 252);
//        self.smallQueryView.backgroundColor = [UIColor whiteColor];
//        self.smallQueryView.alpha = 1;
//        [self addSubview:self.smallQueryView];
        self.backgroundColor = [UIColor whiteColor];
        
        self.nameOneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.nameOneBtn.frame = CGRectMake(442, 0, 218, 47);
        self.nameOneBtn.backgroundColor = [UIColor whiteColor];
        [self.nameOneBtn addTarget:nil action:@selector(nameOneBtnclick) forControlEvents:UIControlEventTouchUpInside];
        [self.nameOneBtn setImage:[UIImage imageNamed:@"xmxbsrbdh dianji.png"] forState:UIControlStateNormal];
        //[self.nameOneBtn setTitle:@"姓名+身份证" forState:UIControlStateNormal];
        [self.nameOneBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:self.nameOneBtn];
        
        self.bodyTwoBtn = [[UIButton alloc] init];
        self.bodyTwoBtn.frame = CGRectMake(0, 0, 218, 47);
        //self.bodyTwoBtn.alpha = 0.5;
        self.bodyTwoBtn.titleLabel.textColor = [UIColor blackColor];
        [self.bodyTwoBtn setImage:[UIImage imageNamed:@"xmsfz weidianji.png"] forState:UIControlStateNormal];
        self.bodyTwoBtn.backgroundColor = [UIColor lightGrayColor];
        [self.bodyTwoBtn addTarget:self action:@selector(bodyTwoBtnclick) forControlEvents:UIControlEventTouchUpInside];
        //[self.bodyTwoBtn setTitle:@"身份证+保单号" forState:UIControlStateNormal];
        [self.bodyTwoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:self.bodyTwoBtn];
        [self bodyTwoBtnclick];
        
        self.numberThreeBtn = [[UIButton alloc] init];
        self.numberThreeBtn.frame = CGRectMake(221, 0, 218, 47);
        self.numberThreeBtn.titleLabel.textColor = [UIColor blackColor];
        //self.numberThreeBtn.alpha = 0.5;
        self.numberThreeBtn.backgroundColor = [UIColor lightGrayColor];
        [self.numberThreeBtn addTarget:self action:@selector(numberThreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.numberThreeBtn setImage:[UIImage imageNamed:@"sfzbdh weidianji.png"] forState:UIControlStateNormal];
        //[self.numberThreeBtn setTitle:@"姓名+性别+生日+保单号" forState:UIControlStateNormal];
        [self.numberThreeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [self addSubview:self.numberThreeBtn];
        
        //        self.exitBtn = [[UIButton alloc] init];
        //        self.exitBtn.frame = CGRectMake(585, 5, 25, 25);
        //        [self.exitBtn addTarget:self action:@selector(exitQueryBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //        //[self.exitBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //        self.exitBtn.backgroundColor = [UIColor blackColor];
        //        [self.smallQueryView addSubview:self.exitBtn];
        
        self.changTiaoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 46.5, 660, 4)];
        [self.changTiaoImageView setImage:[UIImage imageNamed:@"lanse--cu--changtiao-.png"]];
        [self addSubview:self.changTiaoImageView];
        
        self.keHunameLabel = [[UILabel alloc] init];
        self.keHunameLabel.text = @"姓名:";
        self.keHunameLabel.frame = CGRectMake(19,87 ,62 ,25 );
        [self addSubview:self.keHunameLabel];
        
        self.baoDanHaoLabel = [[UILabel alloc] init];
        self.baoDanHaoLabel.text = @"保单号:";
        self.baoDanHaoLabel.frame = CGRectMake(19,150 ,62 ,25 );
        [self addSubview:self.baoDanHaoLabel];
        
        
        
        self.keHuNameTF = [[UITextField alloc] init];
        self.keHuNameTF.borderStyle=UITextBorderStyleRoundedRect;
        //self.keHuNameTF.layer.cornerRadius=8.0f;
        //self.keHuNameTF.layer.masksToBounds=YES;
        self.keHuNameTF.tag = 9001;
        self.keHuNameTF.delegate = self;
        self.keHuNameTF.placeholder = @" 请输入姓名";
        self.keHuNameTF.layer.borderColor=[[UIColor blackColor]CGColor];
        self.keHuNameTF.layer.borderWidth= 1.0f;
        self.keHuNameTF.frame = CGRectMake(83, 81, 280, 34);
        [self addSubview:self.keHuNameTF];
        
        self.baoDanHaoTF = [[UITextField alloc] init];
        //self.baoDanHaoTF.layer.cornerRadius=8.0f;
        //self.baoDanHaoTF.layer.masksToBounds=YES;
        self.baoDanHaoTF.layer.borderColor=[[UIColor blackColor]CGColor];
        self.baoDanHaoTF.layer.borderWidth= 1.0f;
        self.baoDanHaoTF.tag = 9002;
        self.baoDanHaoTF.delegate = self;
        self.baoDanHaoTF.placeholder = @" 请输入保单号";
        self.baoDanHaoTF.frame = CGRectMake(83, 143, 280, 34);
        [self addSubview:self.baoDanHaoTF];
        
        self.shengRiTouLabel = [[UILabel alloc] initWithFrame:CGRectMake(379, 87, 67, 25)];
        self.shengRiTouLabel.text = @"生日：";
        [self addSubview:self.shengRiTouLabel];
        self.xingBeiTouLabel = [[UILabel alloc] initWithFrame:CGRectMake(379, 147, 67, 25)];
        self.xingBeiTouLabel.text = @"性别：";
        [self addSubview:self.xingBeiTouLabel];
        
        self.xingBieBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.xingBieBtn.frame = CGRectMake(442, 143, 83.5, 37);
        self.xingBieBtn.backgroundColor = [UIColor colorWithRed:143/255.0 green:206/255.0 blue:1.0 alpha:1];
        [self.xingBieBtn addTarget:self action:@selector(xingBieBtnClick) forControlEvents:UIControlEventTouchUpInside];
        //[self.xingBieBtn setImage:[UIImage imageNamed:@"xingbieanniu.png"] forState:UIControlStateNormal];
        [self.xingBieBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.xingBieBtn setTitle:@"男    女" forState:UIControlStateNormal];
        [self addSubview:self.xingBieBtn];
        
        self.xingBieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(484, 142, 40, 37)];
        self.xingBieImageView.image = [UIImage imageNamed:@"xingbieanniu"];
        [self addSubview:self.xingBieImageView];
        
        self.queryBtnView = [[UIView alloc] initWithFrame:CGRectMake(0, 217, 660, 39)];
        self.queryBtnView.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
        [self addSubview:self.queryBtnView];
        
        self.queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.queryBtn.frame = CGRectMake(511, 8, 86, 26);
        [self.queryBtn setBackgroundImage:[UIImage imageNamed:@"chaxun weidianji.png"] forState:UIControlStateNormal];
        [self.queryBtn addTarget:self action:@selector(queryBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.queryBtn setBackgroundColor:[UIColor blueColor]];
        [self.queryBtnView addSubview:self.queryBtn];
        
        //        self.addPickerView = [[UIView alloc] initWithFrame:CGRectMake(442, 119, 185, 125)];
        //        self.addPickerView.backgroundColor = [UIColor whiteColor];
        //        [self.smallQueryView addSubview:self.addPickerView];
        //生日按钮
        _queryDateBtn=[[UIButton alloc] initWithFrame:CGRectMake(422, 82, 205, 34)];
        _queryDateBtn.titleLabel.font = [UIFont systemFontOfSize:23.0];
        [_queryDateBtn addTarget:self action:@selector(queryDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_queryDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _queryDateBtn.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        
        //_queryDatePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(130, 190, 200, 80)];
        //        _queryDatePicker=[[UIDatePicker alloc] init];
        //        //[_queryDatePicker setBackgroundColor:[UIColor blueColor]];
        //        [bigAddPickView addSubview:_queryDatePicker];
        //        _queryDatePicker.datePickerMode = UIDatePickerModeDate;
        //        // datePicker.userInteractionEnabled = YES;
        //        _queryDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        //        NSDate *date=[_queryDatePicker date];
        // _queryDateLabel.text = [NSString stringWithFormat:@"   %@",[date.description substringToIndex:10]];
        
        NSDate *timeDate=[NSDate date];//获取当前时间
        NSDateFormatter *timeFormat = [[NSDateFormatter alloc]init];
        [timeFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *zongShiJianString = [timeFormat stringFromDate:timeDate];
        
        NSString *qianMingTimeString = [zongShiJianString substringToIndex:10];
        
        
        NSString *shengRiNianString = [NSString stringWithFormat:@"%@ | ",[qianMingTimeString substringToIndex:4]];
        NSString *shengRiYueString = [NSString stringWithFormat:@"%@ | ",[qianMingTimeString substringWithRange:NSMakeRange(5, 2)]];
        NSString *shengRiRiString = [NSString stringWithFormat:@"%@ ",[qianMingTimeString substringWithRange:NSMakeRange(8, 2)]];
        _shengRiString = [NSString stringWithFormat:@"%@%@%@",shengRiNianString,shengRiYueString,shengRiRiString];
        [_queryDateBtn setTitle:_shengRiString forState:UIControlStateNormal];
        //_queryDateLabel.text  = _shengRiString;
        
        [self addSubview:_queryDateBtn];
        [self bodyTwoBtnclick];
        
        
    }
    
    return self;
}

//CGRectMake(379, 87, 67, 25)

- (void)nameOneBtnclick
{
    type=1;
    self.keHunameLabel.text = @"姓名:";
    self.baoDanHaoLabel.text = @"保单号:";
    self.keHuNameTF.placeholder = @" 请输入姓名";
    self.baoDanHaoTF.placeholder = @" 请输入保单号";
    self.nameOneBtn.backgroundColor = [UIColor whiteColor];
    self.bodyTwoBtn.backgroundColor = [UIColor lightGrayColor];
    self.numberThreeBtn.backgroundColor = [UIColor lightGrayColor];
    [self.nameOneBtn setImage:[UIImage imageNamed:@"xmxbsrbdh dianji.png"] forState:UIControlStateNormal];
    [self.bodyTwoBtn setImage:[UIImage imageNamed:@"xmsfz weidianji.png"] forState:UIControlStateNormal];
    [self.numberThreeBtn setImage:[UIImage imageNamed:@"sfzbdh weidianji.png"] forState:UIControlStateNormal];
    
    self.keHunameLabel.frame = CGRectMake(19,87 ,62 ,25 );
    self.baoDanHaoLabel.frame = CGRectMake(19,150 ,62 ,25 );
    self.keHuNameTF.frame = CGRectMake(83, 81, 280, 34);
    self.baoDanHaoTF.frame = CGRectMake(83, 143, 280, 34);
    
    self.shengRiTouLabel.frame = CGRectMake(379, 87, 67, 25);
    self.xingBeiTouLabel.frame = CGRectMake(379, 147, 67, 25);
    self.xingBieBtn.frame = CGRectMake(442, 143, 83.5, 37);
    self.queryDateBtn.frame = CGRectMake(422, 82, 205, 34);
    self.xingBieImageView.frame = CGRectMake(484, 142, 40, 37);
    keyView.alpha = 0;
}

- (void)bodyTwoBtnclick
{
    //姓名+身份证
    brithday=nil;
    gerder=nil;
    type=2;
    self.keHunameLabel.text = @"姓名:";
    self.baoDanHaoLabel.text = @"身份证:";
    self.baoDanHaoTF.placeholder = @" 请输入身份证号码";
    self.keHuNameTF.placeholder = @" 请输入姓名";
    self.nameOneBtn.backgroundColor = [UIColor lightGrayColor];
    self.bodyTwoBtn.backgroundColor = [UIColor whiteColor];
    self.numberThreeBtn.backgroundColor = [UIColor lightGrayColor];
    [self.nameOneBtn setImage:[UIImage imageNamed:@"xmxbsrbdh weidianji.png"] forState:UIControlStateNormal];
    [self.bodyTwoBtn setImage:[UIImage imageNamed:@"xmsfz dianji.png"] forState:UIControlStateNormal];
    [self.numberThreeBtn setImage:[UIImage imageNamed:@"sfzbdh weidianji.png"] forState:UIControlStateNormal];
    
    
    self.keHunameLabel.frame = CGRectMake(158,87 ,64 ,25 );
    self.baoDanHaoLabel.frame = CGRectMake(158,146 ,64 ,25 );
    self.keHuNameTF.frame = CGRectMake(221, 81, 280, 34);
    self.baoDanHaoTF.frame = CGRectMake(221, 143, 280, 34);
    
    self.shengRiTouLabel.frame = CGRectMake(0, 0, 0, 0);
    self.xingBeiTouLabel.frame = CGRectMake(0, 0, 0, 0);
    self.xingBieBtn.frame = CGRectMake(0, 0, 0, 0);
    self.queryDateBtn.frame = CGRectMake(0, 0, 0, 0);
    self.xingBieImageView.frame = CGRectMake(0, 0, 0, 0);
    //bigAddPickView.frame = CGRectMake(0, 0, 0, 0);
    //self.queryDatePicker.frame = CGRectMake(0, 0, 0, 0);
    //self.pickerQueDingBtn.frame = CGRectMake(0, 0, 0, 0);
    //self.pickerQuXiaoBtn.frame = CGRectMake(0, 0, 0, 0);
    keyView.alpha = 0;
    
}


- (void)numberThreeBtnClick
{
    brithday=nil;
    gerder=nil;
    type=3;
    self.keHunameLabel.text = @"身份证:";
    self.baoDanHaoLabel.text = @"保单号:";
    self.keHuNameTF.placeholder = @" 请输入身份证号码";
    self.baoDanHaoTF.placeholder = @" 请输入保单号";
    self.nameOneBtn.backgroundColor = [UIColor lightGrayColor];
    self.bodyTwoBtn.backgroundColor = [UIColor lightGrayColor];
    self.numberThreeBtn.backgroundColor = [UIColor whiteColor];
    [self.nameOneBtn setImage:[UIImage imageNamed:@"xmxbsrbdh weidianji.png"] forState:UIControlStateNormal];
    [self.bodyTwoBtn setImage:[UIImage imageNamed:@"xmsfz weidianji.png"] forState:UIControlStateNormal];
    [self.numberThreeBtn setImage:[UIImage imageNamed:@"sfzbdh dianji.png"] forState:UIControlStateNormal];
    
    self.keHunameLabel.frame = CGRectMake(158,87 ,64 ,25 );
    self.baoDanHaoLabel.frame = CGRectMake(158,146 ,64 ,25 );
    self.keHuNameTF.frame = CGRectMake(221, 81, 280, 34);
    self.baoDanHaoTF.frame = CGRectMake(221, 143, 280, 34);
    
    self.shengRiTouLabel.frame = CGRectMake(0, 0, 0, 0);
    self.xingBeiTouLabel.frame = CGRectMake(0, 0, 0, 0);
    self.xingBieBtn.frame = CGRectMake(0, 0, 0, 0);
    self.queryDateBtn.frame = CGRectMake(0, 0, 0, 0);
    self.xingBieImageView.frame = CGRectMake(0, 0, 0, 0);
    //bigAddPickView.frame = CGRectMake(0, 0, 0, 0);
    // self.queryDatePicker.frame = CGRectMake(0, 0, 0, 0);
    //self.pickerQueDingBtn.frame = CGRectMake(0, 0, 0, 0);
    //self.pickerQuXiaoBtn.frame = CGRectMake(0, 0, 0, 0);
    keyView.alpha = 0;
}

-(void)xingBieBtnClick
{
    if (self.isMan == YES)
    {
        
        self.xingBieImageView.frame = CGRectMake(484, 142, 40, 37);
        self.isMan = NO;
        gerder=@"M";
    }
    else
    {
        gerder=@"F";
        self.xingBieImageView.frame = CGRectMake(442, 142, 40, 37);
        //[self.xingBieBtn setImage:@"" forState:UIControlStateNormal];
        self.isMan = YES;
        
    }
    
}

//生日按钮
-(void)queryDateBtnClick:(UIButton *)btn
{
    
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    bigAddPickView.frame = CGRectMake(496, 305, 250, 180);
//    _queryDatePicker.frame = CGRectMake(18, 0, 240, 130);
//    self.shengRiSmallView.frame = CGRectMake(18, 150, 228, 30);
//    self.pickerQuXiaoBtn.frame = CGRectMake(20, 2, 60, 25);
//    
    
    if (!keyView)
    {
        keyView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.origin.x+self.queryDateBtn.frame.origin.x-10, self.frame.origin.y+self.queryDateBtn.frame.origin.y+self.queryDateBtn.frame.size.height, 250, 180)];
        keyView.backgroundColor = [UIColor whiteColor];
        [[self superview] addSubview:keyView];
        
        
        bigAddPickView = [[UIView alloc] init];
    
        //bigAddPickView.frame = CGRectMake(409, 115, 250, 180);
        bigAddPickView.frame = CGRectMake(0, 0, 250, 180);
        bigAddPickView.backgroundColor = [UIColor whiteColor];
        [keyView addSubview:bigAddPickView];
        
        
        _queryDatePicker=[[UIDatePicker alloc] init];
        //[_queryDatePicker setBackgroundColor:[UIColor blueColor]];
        [bigAddPickView addSubview:_queryDatePicker];
        _queryDatePicker.frame = CGRectMake(18, 0, 240, 130);
        
        _queryDatePicker.datePickerMode = UIDatePickerModeDate;
        // datePicker.userInteractionEnabled = YES;
        _queryDatePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        NSDate *date=[_queryDatePicker date];
        // _queryDateLabel.text = [NSString stringWithFormat:@"   %@",[date.description substringToIndex:10]];
        
        NSString *shengRiNianString = [NSString stringWithFormat:@"%@ | ",[date.description substringToIndex:4]];
        NSString *shengRiYueString = [NSString stringWithFormat:@"%@ | ",[date.description substringWithRange:NSMakeRange(5, 2)]];
        NSString *shengRiRiString = [NSString stringWithFormat:@"%@ ",[date.description substringWithRange:NSMakeRange(8, 2)]];
        _shengRiString = [NSString stringWithFormat:@"%@%@%@",shengRiNianString,shengRiYueString,shengRiRiString];
        [_queryDateBtn setTitle:_shengRiString forState:UIControlStateNormal];
        
        self.shengRiSmallView = [[UIView alloc] init];
        self.shengRiSmallView.frame = CGRectMake(18, 150, 228, 30);
        [bigAddPickView addSubview:self.shengRiSmallView];
        self.pickerQuXiaoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shengRiSmallView addSubview:self.pickerQuXiaoBtn];
        self.pickerQueDingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.shengRiSmallView addSubview:self.pickerQueDingBtn];
        
        
        self.pickerQuXiaoBtn.frame = CGRectMake(20, 2, 60, 25);
        //[self.pickerQuXiaoBtn setImage:[UIImage imageNamed:@"quxiao.png"] forState:UIControlStateNormal];
        self.pickerQuXiaoBtn.layer.borderWidth = 1;
        self.pickerQuXiaoBtn.layer.masksToBounds = YES;
        self.pickerQuXiaoBtn.layer.cornerRadius = 3;
        self.pickerQuXiaoBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        self.pickerQuXiaoBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        [self.pickerQuXiaoBtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.pickerQuXiaoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.pickerQuXiaoBtn addTarget:self action:@selector(pickerQuXiaoBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        self.pickerQueDingBtn.frame = CGRectMake(150, 2, 60, 25);
        [self.pickerQueDingBtn addTarget:self action:@selector(pickerQueDingBtnClick) forControlEvents:UIControlEventTouchUpInside];
        self.pickerQueDingBtn.layer.borderWidth = 1;
        self.pickerQueDingBtn.layer.masksToBounds = YES;
        self.pickerQueDingBtn.layer.cornerRadius = 3;
        self.pickerQueDingBtn.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1];
        [self.pickerQueDingBtn setTitle:@"确定" forState:UIControlStateNormal];
        [self.pickerQueDingBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.pickerQueDingBtn.layer.borderColor = [[UIColor grayColor] CGColor];
        //[self.shengRiSmallView addSubview:self.pickerQueDingBtn];
        
    }
    
    keyView.alpha = 1;
    
}

-(void)pickerQuXiaoBtnClick
{
    [self.queryDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    keyView.alpha = 0;
}

-(void)pickerQueDingBtnClick
{
    [self.queryDateBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDate *date=[_queryDatePicker date];
    // _queryDateLabel.text = [NSString stringWithFormat:@"   %@",[date.description substringToIndex:10]];
    NSString *shengRiNianString = [NSString stringWithFormat:@"%@ | ",[date.description substringToIndex:4]];
    NSString *shengRiYueString = [NSString stringWithFormat:@"%@ | ",[date.description substringWithRange:NSMakeRange(5, 2)]];
    NSString *shengRiRiString = [NSString stringWithFormat:@"%@ ",[date.description substringWithRange:NSMakeRange(8, 2)]];
    _shengRiString = [NSString stringWithFormat:@"%@%@%@",shengRiNianString,shengRiYueString,shengRiRiString];
    [_queryDateBtn setTitle:_shengRiString forState:UIControlStateNormal];
    
    
    //    [self.pickerQuXiaoBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //    [self.pickerQueDingBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    //    //self.queryDateBtn.enabled=YES;
    //[self.queryDatePicker removeFromSuperview];
    //[bigAddPickView removeFromSuperview];
    keyView.alpha = 0;
    brithday=_shengRiString;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.smallQueryView.frame = CGRectMake(91, 50, 660, 252);
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
    self.smallQueryView.frame = CGRectMake(91, 190, 660, 252);
}
-(id<TPLListBOModel>)request{
    id<TPLRemoteServiceProtocol>remoteService=[[TPLRemoteServiceImpl getInstance] requestUrlWithStr:[NSString stringWithFormat:@"%@%@",HESSIANURL,URL]];
    [(CWDistantHessianObject *)remoteService setReqHeadDict:[TPLRequestHeaderUtil otherRequestHeader]];
    [(CWDistantHessianObject *)remoteService resHeadDict];
    
    id<TPLListBOModel> listBOModel=nil;
    @try {
        if (type==1) {
            //姓名+性别+生日+保单号
            listBOModel=[remoteService queryCustomerInfoWithPolicyCode:self.baoDanHaoTF.text certiCode:nil customerName:self.keHuNameTF.text brithday:brithday  gerder:gerder  queryType:@"2"  ];
        }else if(type==2){
            //姓名+身份证
            listBOModel=[remoteService queryCustomerInfoWithPolicyCode:self.baoDanHaoTF.text certiCode:nil customerName:self.keHuNameTF.text brithday:nil gerder:nil queryType:@"3"   ];
        }
        else {
            //身份证+保单号
            listBOModel=[remoteService queryCustomerInfoWithPolicyCode:self.baoDanHaoTF.text certiCode:nil customerName:self.keHuNameTF.text brithday:nil gerder:nil queryType:@"1"   ];
        }
        
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    //        NSLog(@">>>>>>>>>>>>>%@",listBOModel111);
    //把客户的信息存起来
    TPLSessionInfo  *info=[TPLSessionInfo shareInstance];
    info.custmerDic=[listBOModel.objList objectAtIndex:0];
    return listBOModel;
    
    
}

//查询按钮
- (void)queryBtnClick
{
    [self.queryBtn setBackgroundImage:[UIImage imageNamed:@"chaxun dianji.png"] forState:UIControlStateNormal];
    
    
//    [[[[self superview] superview] viewWithTag:-200] removeFromSuperview];
//    [[[[self superview] superview] viewWithTag:-100] removeFromSuperview];
    
    
    id<TPLListBOModel>listBOModel=[self request];
    if ([[listBOModel.errorBean errorCode] isEqualToString:@"1"]) {
        //表示请求出错
        UIAlertView *alertV= [[UIAlertView alloc] initWithTitle:@"提示信息" message:[listBOModel.errorBean errorInfo] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }else{
        //表示请求成功
        [self.delegate smartQueryChangeCustomer];
        
    }
    [[self superview] removeFromSuperview];
    
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveClearViewNotification" object:self];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"RemoveTouClearViewNotification" object:self];
//    
//    MainViewController *vc=[MainViewController sharedManager];
//    ThreeViewController *vcc=[ThreeViewController sharedManager];
//    [vc.navigationController pushViewController:vcc animated:YES];
    
    
    
}

//- (void)timerClick
//{
//
//    NSDate *date=[_queryDatePicker date];
//    NSString *shengRiNianString = [NSString stringWithFormat:@"%@ | ",[date.description substringToIndex:4]];
//    NSString *shengRiYueString = [NSString stringWithFormat:@"%@ | ",[date.description substringWithRange:NSMakeRange(5, 2)]];
//    NSString *shengRiRiString = [NSString stringWithFormat:@"%@ ",[date.description substringWithRange:NSMakeRange(8, 2)]];
//    _shengRiString = [NSString stringWithFormat:@"%@%@%@",shengRiNianString,shengRiYueString,shengRiRiString];
//    [_queryDateBtn setTitle:_shengRiString forState:UIControlStateNormal];
//   
//
//}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


@end
