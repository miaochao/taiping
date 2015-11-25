//
//  ViewController.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/2.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "ViewController.h"
#import "LoginViewController.h"

@interface ViewController ()
@property (nonatomic,strong)  NSTimer   *timer;
@property (nonatomic,assign)    int     a;
@property (nonatomic,strong)  UILabel   *dateLabel;
@property (nonatomic,strong)  UIDatePicker *datePicker;
@end

@implementation ViewController
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [_timer invalidate];
    _timer=nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor=[UIColor grayColor];
    UINavigationController *nav=[[UINavigationController alloc] initWithRootViewController:self];
    UIWindow *window=[[UIApplication sharedApplication].delegate window];
    window.rootViewController=nav;
    nav.navigationBarHidden=YES;
    
    //启动页
    UIImageView *imageV=[[UIImageView alloc] initWithFrame:self.view.frame];
    imageV.image=[UIImage imageNamed:@"beijing-2.png"];
    [self.view addSubview:imageV];
    
//    _timer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timer) userInfo:nil repeats:YES];
//    [_timer fire];
    
    
//    _dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 200, 50)];
//    [self.view addSubview:_dateLabel];
    
//    _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(100, 100, 300, 10)];
//    [self.view addSubview:_datePicker];
//    _datePicker.datePickerMode = UIDatePickerModeDate;
//    _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
//    NSDate *date=[_datePicker date];
//
//    _dateLabel.text=[date.description substringToIndex:10];
    
    LoginViewController *vc=[LoginViewController sharedManager];
//    LoginViewController *vc=[[LoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
-(void)timer{
    NSDate *date=[_datePicker date];
    _dateLabel.text=[date.description substringToIndex:10];
//    _a++;
//    if (_a==3) {
//        LoginViewController *vc=[[LoginViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
//    NSLog(@"1111");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
