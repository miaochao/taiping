//
//  NSObject_BjcaDefined.h
//  bjcaHandwriteLib
//
//  Created by miaofan on 14-1-22.
//
//

#import <Foundation/Foundation.h>

#define imageDB @"image"
#define imageMutiDB @"imageMuti"
#define imageCameraDB @"imageCamera"
#define imageRecordDB @"imageRecord"


#define SignPointArryDB @"SignPointArry"
#define SignImageDB @"SignImage"

#define removeViewNotice @"removeView"
#define viewType @"viewType"
#define ViewSign @"ViewSign"
#define ViewMuti @"ViewMuti"
#define ViewCamera @"ViewCamera"
#define Viewrecord @"Viewrecord"

#define signImageWidth @"signImageWidth"
#define signImageHeight @"signImageHeight"
#define signTrail @"signTrail"
#define signColor @"signColor"


#define JsVersion @"Version"
#define JsEncKey @"EncKey"
#define JsCertSN @"CertSN"
#define JsTermSrc @"TermSrc"
#define JsEncData @"EncData"
#define JsFormInfo @"FormInfo"
#define JsWONo @"WONo"
#define JsWOHash @"WOHash"
#define JsIsSync @"IsSync"
#define JsIsUnit @"IsUnit"
#define JsEncAlg @"EncAlg"
#define JsFlowID @"FlowID"
#define JsUSignArray @"USignArray"
#define JsCid @"Cid"
#define JsSignRule @"SignRule"
#define JsRuleType @"RuleType"
#define JsTid @"Tid"
#define JsKWRule @"KWRule"
#define JsXYZRule @"XYZRule"
#define JsSigner @"Signer"
#define JsPoints @"Points"
#define JsImage @"Image"
#define JsIsTSS @"IsTSS"
#define JsImageSize @"ImageSize"

#define JsDataArray @"DataArray"
#define JsCachetArray @"CachetArray"
#define JsName @"Name"







#define JsBJCAROOT @"BJCAROOT"
#define JsPlainData @"PlainData"
#define JsP10Data @"P10Data"
#define JsHash @"Hash"
#define JsValue @"Value"
#define JsValueType @"ValueType"
#define JsP10SignVal @"P10SignVal"
#define JsHashalg @"Hashalg"
#define JsDn @"Dn"
#define JsTemplname @"Templname"
#define JsChannel @"Channel"
#define JsCertOID @"CertOID"
#define JsIDType @"IDType"
#define JsIDNumber @"IDNumber"
#define JsRawHash @"RawHash"
#define JsBioFeature @"BioFeature"
#define JsScript @"Script"
#define JsFormat @"Format"
#define JsWidth @"Width"
#define JsColor @"Color"
#define JsCount @"Count"
#define JsRefWidth @"RefWidth"
#define JsRefHeight @"RefHeight"
#define JsData @"Data"
#define JsDevice @"Device"
#define JsDeviceName @"DeviceName"
#define JsSampleRate @"SampleRate"
#define JsPressMax @"PressMax"
#define JsWidth @"Width"
#define JsHeight @"Height"
#define JsDeviceVer @"DeviceVer"
#define JsDeviceID @"DeviceID"
#define JsCertInfo @"CertInfo"
#define JsCertSN @"CertSN"
#define JsCert @"Cert"

struct BjcaPoint {
    float x;
    float y;
    double time;
};
typedef struct BjcaPoint BjcaPoint;

@interface NSObject ()

@end
