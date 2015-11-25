//
//  myCamera.h
//  bjcaHandwriteLib
//
//  Created by miaofan on 13-11-13.
//
//

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "CustomImagePicker.h"
@interface myCamera : UIViewController< UIImagePickerControllerDelegate ,UIActionSheetDelegate,UINavigationControllerDelegate>
{


}
-(void)setMessage:(NSString *) message flag:(NSString *) keyValue;
-(void)setScale:(CGFloat) value;
@end
