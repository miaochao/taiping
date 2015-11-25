//
//  config.h
//  camera1
//
//  Created by fan miao on 12-11-14.
//  Copyright 2012年 bjca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject_BjcaDefined.h"

@interface config : NSObject

- (NSString *)getItemValue :(NSString *) item;
- (NSDictionary * )getxml :(NSString *) item;

-(NSMutableDictionary *)getConfigNSDictionary :(NSString *) myid;
-(NSString *)getConfigValue :(NSString *) myid   value:(NSString *)key ;
-(int)setConfigValue :(NSString *) key value:(NSMutableDictionary *)myvalue;
-(NSMutableDictionary *)getPackageDic :(NSString *) key  value:(id)myvalue NSDic:(NSMutableDictionary *)dic;
-(NSMutableDictionary *)getAllPackageDic :(NSString *) myid   NSDicTmp:(NSMutableDictionary *)dicTmp NSDic:(NSMutableDictionary *)dic;
-(NSMutableDictionary *)getMyidPackageDic :(NSString *) myid ;
-(void)clearConfig;
-(BOOL )setTableValue :(NSString *) data   value:(NSString *)tid;
-(NSString *)getTableValue :(NSString *) key;
-(void)clearTable;
-(void)setConfigTid ;
-(BOOL )setConfigMyValue :(NSString *) key   value:(NSString *)value;
-(NSString *)getMyValue :(NSString *) key;

-(BOOL )setSignValue :(NSString *) key value:(NSMutableArray *)myValue;
-(NSMutableArray * )getSignValue :(NSString *) key;
-(BOOL )setInfoMyValue :(NSString *) key  value:(id )value;
-(id)getMyInfo :(NSString *) key;

@end
