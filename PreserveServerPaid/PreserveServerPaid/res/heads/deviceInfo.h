//
//  deviceInfo.h
//  bjcaHandwriteLib
//
//  Created by miaofan on 14-1-21.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface deviceInfo : NSObject
{
}
-(NSString *)getDeviceName;
-(CGRect )getDeviceScreen;
-(CGRect )getXssScreen:(NSString *)name;
@end
