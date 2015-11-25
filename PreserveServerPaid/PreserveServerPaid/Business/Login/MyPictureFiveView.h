//
//  MyPictureFiveView.h
//  PreserveServerPaid
//
//  Created by wondertek  on 15/10/10.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyImagePickerController.h"

@protocol CameraFiveDelegate <NSObject>

-(void)camaraFiveDelegateWay;

@end

@interface MyPictureFiveView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property (nonatomic,strong)  id<CameraFiveDelegate>delegate;
@property (strong, nonatomic) IBOutlet UIView *smallMyPictureView;
@property (strong, nonatomic) MyImagePickerController *ImagePickerVC;
@property (strong, nonatomic) UIView *shangView;

//四个拍照按钮
@property (strong, nonatomic) IBOutlet UIButton *paiZhaoOneBtn;
@property (strong, nonatomic) IBOutlet UIButton *paiZhaoTwoBtn;
@property (strong, nonatomic) IBOutlet UIButton *paiZhaoThreeBtn;
@property (strong, nonatomic) IBOutlet UIButton *paiZhaoFoureBtn;
@property (strong, nonatomic) IBOutlet UIButton *paiZhaoFiveBtn;


@property (strong, nonatomic) IBOutlet UIButton *oneDelBtn;
@property (strong, nonatomic) IBOutlet UIButton *twoDelBtn;
@property (strong, nonatomic) IBOutlet UIButton *threeDelBtn;
@property (strong, nonatomic) IBOutlet UIButton *fourDelBtn;
@property (strong, nonatomic) IBOutlet UIButton *fiveDelBtn;


//@property (strong, nonatomic) IBOutlet UIImageView *btnImage;



//上传下一步按钮
@property (strong, nonatomic) IBOutlet UIButton *shangChuanBtn;
@property (strong, nonatomic) IBOutlet UIButton *nextStepBtn;
@property (strong, nonatomic) NSMutableArray *zhaoPianArray;

- (IBAction)paiZhaoBtnClick:(id)sender;
- (IBAction)delBtnClick:(id)sender;

- (IBAction)shangChuanBtnClick:(id)sender;
- (IBAction)nextStepBtnClick:(id)sender;

+(UIView*)awakeFromNib;




@end
