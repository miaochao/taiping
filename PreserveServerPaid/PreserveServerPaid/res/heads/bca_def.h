

//
//  bca_def.h
//  NEW
//
//  Created by mf_bupt on 10-7-12.
//  Copyright 2010 ms. All rights reserved.
//


#define RV_OK                            0
#define BCA_ALGO_MD2                     1
#define BCA_ALGO_MD5                     2
#define BCA_ALGO_SHA1_160                3
#define BCA_ALGO_DES                     100
#define BCA_ALGO_3DES_2KEY               101
#define BCA_ALGO_3DES_3KEY               102
#define BCA_ALGO_AES                     103
#define BCA_ALGO_RC2                     104
#define BCA_ALGO_RC4                     105
#define BCA_ALGO_RSA                     200


#define BCA_MODE_ECB                     1
#define BCA_MODE_CBC                     2
#define BCA_MODE_CFB                     3
#define BCA_MODE_OFB                     4

#define RV_LOGINERR                      11
#define RV_PINTYPEErr                    12
#define RV_PINLENTHERR                   13
#define RV_KeyInfoTypeErr                57
#define RV_PinErr                        14
#define RV_INVALIDATEPIN                 26
#define KEY_NUM                          10
#define RV_KEYEXIST                      100
#define RV_KEYNUMERR                     9
#define RV_PINNOTINITERR                 15
#define RV_FILENOTFOUND                  55
#define RV_WRITEERR                      56
#define MAX_LENGTH                       2048*6
#define HASH_LENGTH                      20
#define MAXPINLEN                        16
///////////////////////////////////////////////////////////////
#define MSECX_VERSION                        @"Soft-1.0"
#define BCA_GET_CERT_VERSION                 1  //1证书版本
#define BCA_GET_CERT_SERIAL                  2  //2证书序列号
#define BCA_GET_CERT_SIGNALG                 3  //3证书签名算法
#define BCA_GET_CERT_ISSUER_COUNTRY          4  //4证书发放者国家名
#define BCA_GET_CERT_ISSUER_ORGAN            5  //5证书发放者组织名
#define BCA_GET_CERT_ISSUER_PART			 6  //6证书发放者部门名
#define BCA_GET_CERT_ISSUER_STATE			 7  //7证书发放者省州名
#define BCA_GET_CERT_ISSUER_NAME             8  //8证书发放者通用名
#define BCA_GET_CERT_ISSUER_CITY			 9  //9证书发放者城市名
#define BCA_GET_CERT_ISSUER_EMAIL            10 //10证书发放者EMAIL地址
#define BCA_GET_CERT_START_TIME				 11 //11证书有效期起始
#define BCA_GET_CERT_END_TIME				 12 //12证书有效期截止
#define BCA_GET_CERT_SUBJECT_COUNTRY         13  //13用户国家名
#define BCA_GET_CERT_SUBJECT_ORGAN           14  //14用户组织名
#define BCA_GET_CERT_SUBJECT_PART			 15  //15用户部门名
#define BCA_GET_CERT_SUBJECT_STATE			 16  //16用户省州名
#define BCA_GET_CERT_SUBJECT_NAME            17  //17用户通用名
#define BCA_GET_CERT_SUBJECT_CITY			 18  //18用户城市名
#define BCA_GET_CERT_SUBJECT_EMAIL           19 //19用户EMAIL地址 
#define BCA_GET_CERT_DER_PUBLIC_KEY          20 //20用户DER公钥值
#define BCA_GET_CERT_OPTION					 21 //21用户证书自定义级别

#define BCA_GET_CERT_VALID_TIME              22
#define BCA_GET_CERT_SUBJECT_ALTNAME         23
#define BCA_GET_CERT_SUBJECT                 24
#define BCA_GET_CERT_ISSUER                  25
////////////////////////////////////////////////////////////////////

#define BCA_NAMETYPE_UTF8_STRING		     1 
#define BCA_NAMETYPE_NUMERIC_STRING          2
#define BCA_NAMETYPE_PRINTABLE_STRING	     3
#define BCA_NAMETYPE_T61_STRING              4
#define BCA_NAMETYPE_VIDEOTEX_STRING         6
#define BCA_NAMETYPE_IA5_STRING              7
#define BCA_NAMETYPE_GRAPHIC_STRING          8
#define BCA_NAMETYPE_VISIBLE_STRING		     9
#define BCA_NAMETYPE_GENERAL_STRING          10
#define BCA_NAMETYPE_UNIVERSAL_STRING	     11
#define BCA_NAMETYPE_BMP_STRING		         12

///////////////////////////////////////////////////////
#define RV_AlgoTypeErr                      7
#define RV_MemoryErr                        100
#define RV_MODULUSLENERR                    16
#define RV_GenRsaKeyErr                     303
#define RV_RsaModulusLenErr                 304
#define RV_RsaEncErr                        306
#define RV_RsaDecErr                        307
#define RV_KeyNotFountErr                   309
#define RV_CertNotFountErr                  310
#define RV_ImportCertErr		     		315
#define RV_ImportRSAErr		    			316
#define RV_CertVerifyErr					317
#define RV_SignErr							319
#define RV_EncErr							321
#define RV_DecErr							322
#define RV_VerifyErr						323
#define RV_HashErr							324
#define RV_DATALENErr                       325
#define RV_IndataLenErr                     326

#define RV_CERTErr                          398
#define RV_PRIKEYErr                        399
#define RV_DecryptPadErr                    400
#define RV_CertEncodeErr                    500
#define RV_CertSerialNumberErr				505
#define RV_CertIssuerNameErr				506
#define RV_CertSubjectNameErr               507
#define RV_UnknownErr                       508
