//
//  TPLSessionInfo.m
//  TPLAppBQPad
//
//  Created by tpmac on 14-4-9.
//  Copyright (c) 2014年 TPL. All rights reserved.
//

#import "TPLSessionInfo.h"



static TPLSessionInfo *sessionInfo = nil;

@implementation TPLSessionInfo


+ (id)shareInstance{
  
  if (!sessionInfo) {
    sessionInfo = [[TPLSessionInfo alloc] init];
    sessionInfo.menuImageDic = [TPLSessionInfo initMenuImageDic];
    sessionInfo.menuViewDic = [TPLSessionInfo initMenuViewDic];
  }
  
  
  return sessionInfo;
}

+ (NSDictionary *)initMenuImageDic{
    NSMutableDictionary *menuImgeDic = [[NSMutableDictionary alloc]init];
    
    [menuImgeDic setObject:@"module0.png" forKey:@"01"];
    [menuImgeDic setObject:@"module1.png" forKey:@"02"];
    [menuImgeDic setObject:@"module2.png" forKey:@"03"];
    
    
    [menuImgeDic setObject:@"secMenu1.png" forKey:@"0101"];
    [menuImgeDic setObject:@"secMenu3.png" forKey:@"0102"];
    
    [menuImgeDic setObject:@"thirdMenu11.png" forKey:@"010101"];
    [menuImgeDic setObject:@"thirdMenu12.png" forKey:@"010102"];
    [menuImgeDic setObject:@"thirdMenu13.png" forKey:@"010103"];
    [menuImgeDic setObject:@"thirdMenu31.png" forKey:@"010104"];
    [menuImgeDic setObject:@"thirdMenu14.png" forKey:@"010105"];
    [menuImgeDic setObject:@"thirdMenu15.png" forKey:@"010106"];
    [menuImgeDic setObject:@"thirdMenu16.png" forKey:@"010107"];
    
    [menuImgeDic setObject:@"thirdMenu17.png" forKey:@"010201"];
    
    [menuImgeDic setObject:@"accountlevel20.png" forKey:@"0201"];
    [menuImgeDic setObject:@"accountlevel21.png" forKey:@"0202"];
    [menuImgeDic setObject:@"accountlevel22.png" forKey:@"0203"];
    
    [menuImgeDic setObject:@"querylevel20.png" forKey:@"0301"];
    [menuImgeDic setObject:@"querylevel21.png" forKey:@"0302"];
    
    return menuImgeDic;
}

+ (NSDictionary *)initMenuViewDic{
    NSMutableDictionary *menuViewDic = [[NSMutableDictionary alloc]init];
    [menuViewDic setObject:@"0" forKey:@"01"];
    [menuViewDic setObject:@"1" forKey:@"02"];
    [menuViewDic setObject:@"2" forKey:@"03"];
    
    [menuViewDic setObject:@"TPLFamilyChangeView" forKey:@"010101"];
    [menuViewDic setObject:@"TPLCompanyChangeView" forKey:@"010102"];
    [menuViewDic setObject:@"TPLContactChangeView" forKey:@"010103"];
    [menuViewDic setObject:@"TPLPolicyChangeView" forKey:@"010104"];
    [menuViewDic setObject:@"TPLPolicyReportChangeView" forKey:@"010105"];
    [menuViewDic setObject:@"TPLPaySuccChangeView" forKey:@"010106"];
    [menuViewDic setObject:@"TPLInvalidNoticeChangeView" forKey:@"010107"];
    
    [menuViewDic setObject:@"TPLBonusChangeView" forKey:@"010201"];
    
    return menuViewDic;
}

//- (void)dealloc{
//  sessionInfo = nil;
//  _userBOModel = nil;
//  _agentBOModel = nil;
//  [_menuImageDic release];
//  [_menuViewDic release];
//  [_password release];
//  [_firstMenuSelectIndex release];
//    [_userCate release];
//  [super dealloc];
//}
@end
