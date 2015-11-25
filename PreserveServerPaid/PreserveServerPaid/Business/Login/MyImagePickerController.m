//
//  MyImagePickerController.m
//  PreserveServerPaid
//
//  Created by yang on 15/9/10.
//  Copyright (c) 2015年 wondertek. All rights reserved.
//

#import "MyImagePickerController.h"

@interface MyImagePickerController ()

@end

@implementation MyImagePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    if([[[UIDevice
//          currentDevice] systemVersion] floatValue]>=8.0) {
//        
//        self.modalPresentationStyle=UIModalPresentationOverCurrentContext;
//        
//    }
   

    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(0, 369, 1024, 30)];
//    lable.center = self.view.center;
    NSLog(@"宽%f,,,,高%f",self.view.frame.size.width,self.view.frame.size.height);
    lable.text = @"请将所需材料放置在拍照区域内!";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor blackColor];
    lable.backgroundColor=[UIColor clearColor];
    [self.view addSubview:lable];
    
    UIImageView *camera=[[UIImageView alloc] initWithFrame:CGRectMake((1024-600)/2, (768-420)/2, 600, 420)];
    camera.image=[UIImage imageNamed:@"camera"];
    [self.view addSubview:camera];
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    start.backgroundColor = [UIColor whiteColor];
    //[start setImage:[UIImage imageNamed:@"photo_ios"] forState:UIControlStateNormal];
    [start setTitle:@"拍照" forState:UIControlStateNormal];
    //    start.titleLabel.textColor = [UIColor blackColor];
    [start setFrame:CGRectMake(964,354 , 60, 60)];
    start.layer.cornerRadius = 30;
    start.layer.masksToBounds = 30;
    start.userInteractionEnabled = YES;
    [start addTarget:self action:@selector(takePictures:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];
}




//拍照按钮
- (void)takePictures:(id)sender{
    NSLog(@"%s,%d",__FUNCTION__,__LINE__);
    [self takePicture];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
