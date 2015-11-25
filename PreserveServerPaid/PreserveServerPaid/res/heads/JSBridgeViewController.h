//
//  JSBridgeViewController.h
//  JSBridge
//
//  Created by Dante Torres on 10-09-03.
//  Copyright Dante Torres 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSBridgeWebView.h"
//#import "ImageViewerController.h"

@interface JSBridgeViewController : UIViewController <JSBridgeWebViewDelegate ,UIImagePickerControllerDelegate ,UIActionSheetDelegate,UINavigationControllerDelegate> {

	JSBridgeWebView* webView;
	UIButton *cameraButton;
    UIImageView *backView;
    UIButton *cameraImage;
    UIImage *cameraSource ;
	//ImageViewerController* imageViewerController;
}

-(void) loadMaskPage;
-(void)setConfigPdfData:(NSString *) data;
-(void)setConfigHtmlData:(NSData *) data urlAddress:(NSString* )url;
-(void)setUrlAddress:(NSString *) url;
@end

