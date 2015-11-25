//
//  MyPictureView.m
//  PreserveServerPaid
//
//  Created by wondertek  on 15/9/25.
//  Copyright © 2015年 wondertek. All rights reserved.
//

#import "MyPictureView.h"
#import "ThreeViewController.h"
#import "BjcaInterfaceView.h"

@implementation MyPictureView

{
    ThreeViewController     *threeVC;
    int                     tag;
    int                     paiZhaoShu;
    
    BjcaInterfaceView       *mypackage;//CA控件
}
+(UIView*)awakeFromNib{
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:@"MyPictureView" owner:self options:nil];
    
    
    
    MyPictureView *view = [array lastObject];
    //view.smallMyPictureView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    view.smallMyPictureView.layer.borderWidth = 1;
    view.smallMyPictureView.layer.borderColor = [[UIColor colorWithRed:96/255.0 green:183/255.0 blue:245/255.0 alpha:1] CGColor];
    
    view.zhaoPianArray = [[NSMutableArray alloc] init];
    for (int a = 0; a<4; a++)
    {
        
        NSData *data = [NSData dataWithBytes: &a+1 length: sizeof(a+1)];
        [view.zhaoPianArray addObject:data];
        
    }
    NSLog(@"  数组%@ ",view.zhaoPianArray);
    view.oneDelBtn.layer.cornerRadius = 12.5;
    view.oneDelBtn.layer.masksToBounds = 12.5;
    view.twoDelBtn.layer.cornerRadius = 12.5;
    view.twoDelBtn.layer.masksToBounds = 12.5;
    view.threeDelBtn.layer.cornerRadius = 12.5;
    view.threeDelBtn.layer.masksToBounds = 12.5;
    view.fourDelBtn.layer.cornerRadius = 12.5;
    view.fourDelBtn.layer.masksToBounds = 12.5;
    [view.paiZhaoOneBtn setImage:[UIImage imageNamed:@"kehuxianchangzhaopian.png"] forState:UIControlStateNormal];
    [view.paiZhaoTwoBtn setImage:[UIImage imageNamed:@"baoxianhetongneirongshenqingbiangengshu.png"] forState:UIControlStateNormal];
    [view.paiZhaoThreeBtn setImage:[UIImage imageNamed:@"shengfenzhengzhengmian.png"] forState:UIControlStateNormal];
    [view.paiZhaoFoureBtn setImage:[UIImage imageNamed:@"shengfenzhengfanmian.png"] forState:UIControlStateNormal];
    
    //kehuxianchangzhaopian.png
    //baoxianhetongneirongshenqingbiangengshu.png
    //shengfenzhengzhengmian.png
    //shengfenzhengfanmian.png
    
    [view.oneDelBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [view.twoDelBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [view.threeDelBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    [view.fourDelBtn setImage:[UIImage imageNamed:@"shanchu"] forState:UIControlStateNormal];
    
//    self.shareBtn.imageView.frame = self.shareBtn.bounds;
//    self.shareBtn.hidden = NO;
//    view.paiZhaoOneBtn.imageView.frame = view.paiZhaoOneBtn.bounds;
//    view.paiZhaoOneBtn.hidden = NO;
    
    view.oneDelBtn.hidden = YES;
    view.twoDelBtn.hidden = YES;
    view.threeDelBtn.hidden = YES;
    view.fourDelBtn.hidden = YES;
    view.nextStepBtn.userInteractionEnabled = NO;
    
    
    return view;
}
-(void)sizeToFit{
    [super sizeToFit];
    mypackage=[[BjcaInterfaceView alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getimage:) name:@"myPicture" object:nil];
}

- (IBAction)paiZhaoBtnClick:(UIButton *)sender
{
    [mypackage reset];
    paiZhaoShu++;
    tag=(int)sender.tag;
    threeVC = [ThreeViewController sharedManager];
//    _ImagePickerVC = [[MyImagePickerController alloc] init];
//    _ImagePickerVC.sourceType=UIImagePickerControllerSourceTypeCamera;
//    _ImagePickerVC.delegate=self;
//    _ImagePickerVC.showsCameraControls=NO;
//    [threeVC presentViewController:_ImagePickerVC animated:YES completion:^
//    {
//    }];
    
    //CA拍照
    cameraInfo info;
    
    info= [self SetCameraData:1 info:&info];
    NSString *strContextid=@"51";
    int CLS;
    @try
    {
        CLS=[strContextid intValue];
    }
    @catch (NSException *exception) {
        return  ;
    }
    
    //ysy add
    
    //[myview showtakePicture:50 callBack:@"myPicture"];
    int max=1;
    bool res= FALSE;
    if(max==1)
    {
        res=[mypackage showtakePicture:CLS callBack:@"myPicture" cameraInfo:info];
    }
    //    else
    //    {
    //        cameraInfoEvidence info1;
    //        info1= [self SetCameraDataEvident:1 info:&info1];
    //        info1.geo=TRUE;
    //        res=[mypackage showtakePictureEvidence:CLS callBack:@"myPicture" cameraInfo:info evidence:info1];
    //    }
    
    if(res==TRUE)
    {
        [threeVC.view addSubview:mypackage.view];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"照相机参数配置错误" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
        
        return;
    }

}
- (cameraInfo )SetCameraData:(int)index info:(cameraInfo *)infodata{
    NSLog(@"SetSignData");
    
    cameraInfo info=*infodata;
    info.property=@"shenfenzheng";
    NSString * strFace=@"false";
    if ([strFace isEqualToString:@"true"])
    {
        info.checkface=TRUE;
    }
    else
    {
        info.checkface=false;
        
    }
    
    info.faceMessage=@"没拍到脸";
    
    //info.checkface=false;
    //=@"找不到脸";
    info.quality=75;
    info.imageSize.cameraImageSize.width=124;
    info.imageSize.cameraImageSize.height=79;
    /*
     info.IdNumber=[self getTestSignItemValue:@"IdNumber" index:index];
     //info.cid=@"20";
     info.RuleType=[self getTestSignItemValue:@"RuleType" index:index];
     info.Tid=[self getTestSignItemValue:@"Tid" index:index];
     info.kw=@"23232";
     info.kwPost=@"2";
     info.kwOffset=@"100";
     info.Left=@"11.01";
     info.Top=@"11.02" ;
     info.Right=@"40.00";
     info.Bottom=@"40.00";
     info.Pageno=@"1";
     info.imgeInfo.SignImageSize.height=[[self getTestSignItemValue:@"SignImageSizeHeight" index:index] floatValue];
     info.imgeInfo.SignImageSize.width=[[self getTestSignItemValue:@"SignImageSizeWidth" index:index] floatValue];*/
    return info;
}
#pragma mark 拍照之后、签名之后调用
- (void)getimage:(NSNotification *)noti{
   // NSLog(@"getimage");
   	NSDictionary *info = [noti userInfo];
    UIImage *image=[info objectForKey:@"myimage"];
    
    NSLog(@" 898998宽%f  高%f  ",image.size.width,image.size.height);
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
//     image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1) resizingMode:UIImageResizingModeStretch];
    
    //    //压缩图片大小
    UIGraphicsBeginImageContext(CGSizeMake(190, 170));
    // new size
    [image drawInRect:CGRectMake(0,0,190, 170)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    
    
    //替换data
    [self.zhaoPianArray replaceObjectAtIndex:tag-9101 withObject:newImage];
    NSLog(@" 898998000宽%f  高%f  ",newImage.size.width,newImage.size.height);
    
   // 190  .170
    UIButton *btn=(UIButton *)[self viewWithTag:tag];
    //btn.frame = CGRectMake(0, 0, 190, 150);
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor whiteColor]];
    btn.userInteractionEnabled = NO;
    
    [btn setImage:newImage forState:UIControlStateNormal];
    //btn.imageView.center = CGPointMake(btn.frame.origin.x+btn.frame.size.width/2, btn.frame.origin.y+btn.frame.size.height/2);
    //btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //btn.backgroundColor = [UIColor redColor];
   
    //要显示在这个按钮
    //[btn setBackgroundImage:newImage forState:UIControlStateNormal];
    UIButton *delBtn = (UIButton *)[self viewWithTag:tag+100];
    delBtn.hidden = NO;
 
    NSData *data=UIImagePNGRepresentation(image);
    NSLog(@"大小%lu",(unsigned long)data.length);
    
    //kehuxianchangzhaopian.png
    //baoxianhetongneirongshenqingbiangengshu.png
    //shengfenzhengzhengmian.png
    //shengfenzhengfanmian.png
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //存入相册
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    NSLog(@"11111");
    float width=image.size.width;
    float height=image.size.height;
    CGRect rect1 = CGRectMake((1024-600)/2*width/1024, (768-420)/2*height/768, 600*width/1024, 420*height/768);//创建矩形框
    //对图片进行截取
    // UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([[[self captureManager] stillImage] CGImage], rect1)];
    //    UIImage * image2 = [UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1)];
    NSLog(@"高%f,,,宽%f",image.size.height,image.size.width);
    UIImage * image2=nil;
    if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationLandscapeLeft) {
        image2 =[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1) scale:image.scale orientation:UIImageOrientationUp];
    }else{
        image2 =[UIImage imageWithCGImage:CGImageCreateWithImageInRect([image CGImage], rect1) scale:image.scale orientation:UIImageOrientationDown];
    }
    
    UIImageWriteToSavedPhotosAlbum(image2, nil, nil, nil);
    
//    //压缩图片大小
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/4 , image.size.height/4));
    // new size
    [image2 drawInRect:CGRectMake(0,0,image.size.width/3 , image.size.height/4)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // End the context
    UIGraphicsEndImageContext();
    //UIImageWriteToSavedPhotosAlbum(newImage, nil, nil, nil);
    
//    NSData *data=UIImageJPEGRepresentation(image2, 0.5);
//    UIImage *ima=[UIImage imageWithData:data];
//    UIImageWriteToSavedPhotosAlbum(ima, nil, nil, nil);
//    NSLog(@"%lu",(unsigned long)data.bytes);
    [threeVC dismissViewControllerAnimated:YES completion:^
     {
        
         
     }];
    
    
    UIButton *paiZhaoBtn = (UIButton *)[self viewWithTag:tag];
    [paiZhaoBtn setTitle:@"" forState:UIControlStateNormal];
    [paiZhaoBtn setBackgroundColor:[UIColor whiteColor]];
    paiZhaoBtn.userInteractionEnabled = NO;
    [paiZhaoBtn setImage:newImage forState:UIControlStateNormal];
    //[paiZhaoBtn setImage:image2 forState:UIControlStateNormal];
    //要显示在这个按钮
    
    UIButton *delBtn = (UIButton *)[self viewWithTag:tag+100];
    delBtn.hidden = NO;
   // [paiZhaoBtn addSubview:delBtn];
}

- (IBAction)delBtnClick:(UIButton *)sender
{
    
    paiZhaoShu--;
    if (sender.tag == 9201)
    {
        [self.paiZhaoOneBtn setImage:[UIImage imageNamed:@"kehuxianchangzhaopian.png"] forState:UIControlStateNormal];
        [self.paiZhaoOneBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
        self.paiZhaoOneBtn.userInteractionEnabled = YES;
        sender.hidden = YES;
        
        NSData *data = [NSData data];
       // data = [NSData dataWithBytes: 1 length: sizeof(1)];
        [self.zhaoPianArray replaceObjectAtIndex:0 withObject:data];
        
    }
    else if (sender.tag == 9202)
    {
         [self.paiZhaoTwoBtn setImage:[UIImage imageNamed:@"baoxianhetongneirongshenqingbiangengshu.png"] forState:UIControlStateNormal];
         [self.paiZhaoTwoBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
         self.paiZhaoTwoBtn.userInteractionEnabled = YES;
        
         NSData *data = [NSData data];
        // data = [NSData dataWithBytes: 2 length: sizeof(2)];
         [self.zhaoPianArray replaceObjectAtIndex:1 withObject:data];
        
    }
    else if (sender.tag == 9203)
    {
         [self.paiZhaoThreeBtn setImage:[UIImage imageNamed:@"shengfenzhengzhengmian.png"] forState:UIControlStateNormal];
         [self.paiZhaoThreeBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
         self.paiZhaoThreeBtn.userInteractionEnabled = YES;
        
        
        NSData *data = [NSData data];
       // data = [NSData dataWithBytes: 3 length: sizeof(3)];
        [self.zhaoPianArray replaceObjectAtIndex:2 withObject:data];
    }
    else
    {
        [self.paiZhaoFoureBtn setImage:[UIImage imageNamed:@"shengfenzhengfanmian.png"] forState:UIControlStateNormal];
         [self.paiZhaoFoureBtn setBackgroundColor:[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1]];
         self.paiZhaoFoureBtn.userInteractionEnabled = YES;
        
        NSData *data = [NSData data];
       // data = [NSData dataWithBytes: 4 length: sizeof(4)];
        [self.zhaoPianArray replaceObjectAtIndex:3 withObject:data];
    }
    sender.hidden = YES;
}

- (IBAction)shangChuanBtnClick:(id)sender
{
    NSLog(@"  数 aa %@",self.zhaoPianArray);
    
    
    if (paiZhaoShu ==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请拍照后再上传图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    if (paiZhaoShu <4)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"拍够四张照片方可上传" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    
    _shangView = [[UIView alloc] init];
    _shangView.frame = CGRectMake(0, 64, 1024, 704);
    _shangView.backgroundColor = [UIColor whiteColor];
    _shangView.alpha = 0.5;
    [self addSubview:_shangView];
    
    UIActivityIndicatorView *activiView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activiView.frame = CGRectMake(_shangView.frame.size.width/2-50, _shangView.frame.size.height/2-80, 50, 50);
    [activiView startAnimating];
    
    [_shangView addSubview:activiView];
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(320, 220, 50, 50)];
//    imgView.image = [UIImage imageNamed:@"jiazai"];
//    [_shangView addSubview:imgView];
   

    [self performSelector:@selector(removeView:) withObject:_shangView afterDelay:2];
    
    self.nextStepBtn.backgroundColor = [UIColor colorWithRed:0 green:151/255.0 blue:1 alpha:1];
    self.nextStepBtn.userInteractionEnabled = YES;

    
}
-(void)removeView:(UIView *)view
{
    if (paiZhaoShu ==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"请拍照后再上传图片" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [alertView show];
        
        return;
    }
    
    [view removeFromSuperview];
}



- (IBAction)nextStepBtnClick:(id)sender
{
    
    [self removeFromSuperview];
    
    //代理方法
    [self.delegate camaraFourDelegateWay];
}
-(void)dealloc{
//    [super dealloc];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:nil];
    
}


@end
