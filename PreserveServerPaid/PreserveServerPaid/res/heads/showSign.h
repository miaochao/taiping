//
//  showSign.h
//  bjcaHandwriteLib
//
//  Created by fan miao on 12-12-25.
//  Copyright 2012年 bjca. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showSign : UIViewController

@property (retain) UIImage *viewImage;
-(void)setMessage:(NSString *) message flag:(NSString *) value;
-(void)setHandWriteColor:(UIColor *)col;
-(void)setScale:(CGFloat) value;
-(void)setcontextId:(int ) context_id;
@end

@interface mutiPict : UIViewController

-(id) showAdvice:(NSString*) orgText;
-(void)setMessage:(NSString *) message;
@end
@interface InterAction : NSObject
-(NSString *)enclosure:(NSString *)mydataUpload mtImage :(UIImage * )myMultipic customerImage :(UIImage * )mycustomer salesImage :(UIImage * )mySalesImage template:(NSString * )templateID;
-(NSString *)enclosureFortemplateID:(NSString *)mydataUpload picData :(NSMutableDictionary * )picDict ;
//-(NSString *)enclosureForLocation:(NSString *)mydataUpload  personInfo:(NSString *)infomation;
-(NSString *)enclosureForLocation:(NSString *)mydataUpload personInfo:(NSString *)infomation errorinfo:(NSMutableString *)error;
-(NSString *)enclosureForData:(NSString *)mydataUpload personInfo:(NSString *)infomation pdfData:(NSString *)jsData errorinfo:(NSMutableString *)error;
-(NSString *)enclosureForTB:(NSString *)mydataUpload personInfo:(NSString *)infomation pdfData:(NSString *)HtmlData errorinfo:(NSMutableString *)error;
-(NSString *)getPointStr:(NSString *)signId;
- (NSMutableDictionary *)getScript:(NSString *)Cid;
- (NSMutableDictionary *)getCertOID:(NSString *)Cid;
@end

@interface saveMyImage : NSObject
-(NSMutableDictionary *)getMySignImage;
-(void)clearSignImage;

@end