//
//  mutiCheck.h
//  xxs_demo
//
//  Created by miaofan on 13-6-20.
//  Copyright (c) 2013年 bjca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mutiCheck : UIViewController
{
        int myOrientation;
        NSMutableArray *myArray;
      int page;
    NSString *myMessage;
    
    NSString *mykeyValue;
      NSString *myId;
     UIColor *color;
    NSString* commitment;
       CGFloat scaleValue;
}
-(void)setMyId:(NSString *) idTmp;
-(void)setHandWriteColor:(UIColor *)col ;
-(void)setMessage:(NSString *) message flag:(NSString *) keyValue;
-(void)setScale:(CGFloat) value;
- (id)initWithCommitment:(NSString*) value;
@end
