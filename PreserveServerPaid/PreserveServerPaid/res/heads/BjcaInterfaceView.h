//
//  BjcaInterfaceView.h
//  bjcaHandwriteLib
//
//  Created by miaofan on 14-1-21.
//
//

#import <UIKit/UIKit.h>
#import "showSign.h"
@interface BjcaInterfaceView : UIViewController
{
  
 
}
typedef struct signImageInformation
{
    CGRect Signrect;
    CGSize SignImageSize;
    
}signImageinfo;
typedef struct signerInformation
{
    // NSString *cid;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *IdNumber;
    __unsafe_unretained NSString *RuleType;
    __unsafe_unretained NSString *Tid;
    __unsafe_unretained NSString *kw;
    __unsafe_unretained NSString *kwPost;
    __unsafe_unretained NSString *kwOffset;
    __unsafe_unretained NSString *Left;
    __unsafe_unretained NSString *Top;
    __unsafe_unretained NSString *Right;
    __unsafe_unretained NSString *Bottom;
    __unsafe_unretained NSString *Pageno;
    bool geo;
    signImageinfo imgeInfo;
}signinfo;
typedef struct Cachet
{
    __unsafe_unretained NSString *Tid;
    __unsafe_unretained NSString *Left;
    __unsafe_unretained NSString *Top;
    __unsafe_unretained NSString *Right;
    __unsafe_unretained NSString *Bottom;
    __unsafe_unretained NSString *Pageno;
    __unsafe_unretained NSString *name;
    __unsafe_unretained NSString *IdNumber;
    __unsafe_unretained NSString *IsTSS;
    
}CachetObj;
typedef struct cameraImageInformation
{
    
    CGSize cameraImageSize;
    
}cameraImageInfo;

typedef struct CameraInformation
{
    // NSString *cid;
    __unsafe_unretained NSString *property;
    CGFloat  quality;
    cameraImageInfo imageSize;
    bool checkface;
    __unsafe_unretained NSString *faceMessage;
    
}cameraInfo;
typedef NS_ENUM(NSInteger, EncType) {
    EncType_RSA,
    EncType_SM2
    
};

typedef struct formInformation
{
    // NSString *cid;
    __unsafe_unretained NSString *WONo;
    __unsafe_unretained NSString *FlowId;
    __unsafe_unretained NSString *Channel;
    __unsafe_unretained NSString *IsSync;
    __unsafe_unretained NSString *IsUnit;
    EncType serverEncType;
    
}formInfo;
typedef struct recordInformation
{
    bool showUi;
    float DurTime;
    
}recordInfo;
typedef NS_ENUM(NSInteger, BioType) {
    photo_signer_card_front,
    photo_signer_card_back
    
};

typedef struct CameraInformationEvidence
{
    int index;
    int evidenceId;
    BioType type;
    BOOL attach;
    BOOL geo;
}cameraInfoEvidence,recordInfoEvidence;
typedef struct PdfCrdRule
{
    int DocCrdTid;
    int DocStyleTid;
    
}PdfRule;
typedef struct signerMutiInformation
{
    CGSize SignImageSize;
}signMutiInfo;
-(BOOL)showInputDialog:(int) context_id callBack:(NSString *)message signerInfo:(signinfo)info;
-(BOOL)showtakePicture:(int) context_id callBack:(NSString *)message cameraInfo:(cameraInfo)info;
//-(void)showMassInputDialog:(int) context_id callBack:(NSString *)message;
-(void)showMassInputDialog:(int) context_id callBack:(NSString *)message muti:(signMutiInfo)dataInfo;
-(NSString *)getUploadDataGram;
-(bool)setTemplate:(NSString * )template_type mydata :(NSData *)data PdfRule:(PdfRule)RuleData;

-(BOOL)setFormInfo:(formInfo)info;
-(BOOL)startMediaRecording:(int) context_id callBack:(NSString *)message recordInfo:(recordInfo)info;
-(BOOL)addChachetObj:(CachetObj)info;
-(void)reset;
//-(BOOL)setSignInfo:(signinfo)info;
-(BOOL)showtakePictureEvidence:(int) context_id callBack:(NSString *)message cameraInfo:(cameraInfo)info evidence:(cameraInfoEvidence)evidenceInfo;
-(BOOL)startMediaRecordingEvidence:(int) context_id callBack:(NSString *)message recordInfo:(recordInfo)info evidence:(recordInfoEvidence)evidenceInfo;

@end
