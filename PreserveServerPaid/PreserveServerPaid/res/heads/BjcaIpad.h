#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include "bca_def.h"

@class KeyStore;
@class CRYPT;
@interface BJCA : NSObject{
    KeyStore *keystore;
    CRYPT *crypt;
}

- (id)init;
- (id)initWithProviderType:(unsigned long)providerType forParameter:(unsigned char *)providerParameter;
- (BOOL)isUserPinInitialized;
- (BOOL)logInWithPin:(NSString *)pin;
- (BOOL)resetPin:(NSString *)oldPin to:(NSString *)newPin;
- (NSData *)sign:(NSString *)name withAlgorithm:(NSUInteger)algorithm data:(NSData *)data;
- (BOOL)verifyWithAlgorithm:(NSUInteger)algorithm data:(NSData *)data certificate:(NSData *)certificate signature:(NSData *)signature;
- (NSDictionary*)getValidity:(NSData*)certificate;
//SymmEncrypt and AsymmEncrypt
- (NSInteger)createSymmKeyObj: (unsigned long *)symmKeyObj algorithm: (NSInteger)algorithmType way:(NSInteger) encOrDec mode:(NSInteger)cryptoMode key:(NSData *)key initVector:(NSData*)iv;
- (NSData *)symmEncrypt:(NSInteger)symmKeyObj data:(NSData*)plaindata;
- (NSData *)symmDecrypt:(NSInteger)symmKeyObj secdata:(NSData*)encdata;
- (NSInteger)destroySymmKeyObj:(NSInteger)symmKeyObj;
- (NSData *)pkcs1EncryptWithCertificate:(NSData *)certificate data:(NSData *)data;
- (NSData *)pkcs1Decrypt:(NSString *)name data:(NSData *)data;
//ecb mode enc and dec
- (NSData *)symmetricEncrypt:(NSUInteger)algorithm key:(NSData *)key data:(NSData *)data;
- (NSData *)symmetricDecrypt:(NSUInteger)algorithm key:(NSData *)key data:(NSData *)data;
- (NSData *)base64Encode:(NSData *)data;
- (NSData *)base64Decode:(NSData *)data;
//cert
- (NSData *)generateRandomDataWithLength:(NSUInteger)length;//base64
- (BOOL)generateKeyPairWithlength:(NSUInteger)length forName:(NSString *)name;
- (NSData *)generateCertRequest;
- (NSData *)generatePkcs10:(NSString *)name;
- (BOOL)setCertificate:(NSData *)certificate forName:(NSString *)name;
- (BOOL)verifyCertificate:(NSData *)certificate;
- (NSData *)getCertificate:(NSString *)name;
- (NSDictionary *)getSubjectName:(NSData *)certificate;
- (BOOL)clearStoreAndSetUserPin:(NSString *)newuserpin;
- (id)getCertificateInfomation:(NSData *)certificate informationType:(NSUInteger)type;

- (NSString *)getPicture64;
- (UIImage *)getPicture:(NSString *)webSignature;
- (NSString *)getInformation:(NSString *)webSignature type:(NSInteger)type;
- (NSString *)getSignDataBase64:(NSString *)ordata picture:(NSString *)picture name:(NSString *)name;
- (NSString *)webSign:(NSString *)data;
- (NSString *)commonSign:(NSString *)name;
- (BOOL)convertPicture:(NSString *)path;


-(id)genMd5:(unsigned char *)pin withLen:(unsigned long)pinLen toKey:(unsigned char*)md;
-(id)genMd51:(unsigned char *)pin withLen:(unsigned long)pinLen toKey:(unsigned char*)md;
@property(nonatomic,retain) KeyStore *keystore;
@property(nonatomic,retain) CRYPT *crypt;

@end
