//
//  TPLCheckUtil.m
//  TPLAppBQPad
//
//  Created by tpmac on 14-4-18.
//  Copyright (c) 2014年 TPL. All rights reserved.
//

#import "TPLCheckUtil.h"

@implementation TPLCheckUtil

+ (BOOL)checkNum:(NSString *)str mixLength:(int)mixLength maxLength:(int)maxLength{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = [NSString stringWithFormat:@"^\\d{%d,%d}$",mixLength,maxLength];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
}

+ (BOOL)checkStrLength:(NSString *)str mixLength:(int)mixLength maxLength:(int)maxLength{
    BOOL isMatch = NO;
    
    if (str==nil) {
        return isMatch;
    }
    
    if (str.length >= mixLength && str.length <= maxLength) {
        isMatch = YES;
    }
    
    return isMatch;
}

+ (BOOL)checkPhone:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = [NSString stringWithFormat:@"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}
+ (BOOL)checkMobil:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = [NSString stringWithFormat:@"^((0\\d{2})-(\\d{7}))|((0\\d{3})-(\\d{7}))|((0\\d{2})-(\\d{8}))|((0\\d{3})-(\\d{8}))|((0\\d{2})-(\\d{7})-(\\d+))|((0\\d{3})-(\\d{7})-(\\d+))|((0\\d{2})-(\\d{8})-(\\d+))|((0\\d{3})-(\\d{8})-(\\d+))$"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}

+ (BOOL)checkCompanyMobil:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = [NSString stringWithFormat:@"^((0\\d{2})(\\d{8}))|((0\\d{3})(\\d{7}))|((0\\d{2})(\\d{8})(\\d+))|((0\\d{3})(\\d{7})(\\d+))$"];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
}

+ (BOOL)checkEmail:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = @"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}
+ (BOOL)checkCardNum:(NSString *)str{
    
    BOOL isMatch = NO;
    
    if (str==nil) {
        return isMatch;
    }
    
    if(str.length!=15&&str.length!=18)
    {
        return isMatch;
        
    }
    
    NSDictionary *dic = [TPLCheckUtil cardNumAreaDic];
    if (![dic valueForKey:[str substringToIndex:2]]) {
        return isMatch;
    }
    
    NSArray *strJiaoYan = [NSArray arrayWithObjects:@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5",
                           @"4", @"3", @"2", nil];
    
    NSArray *arr = [NSArray arrayWithObjects:@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2", nil];
    
    if (str.length == 15) {
        NSString *ereg = @"";
        
        if (([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0
            || (([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%100 == 0
                && ([[str substringWithRange:NSMakeRange(6, 2)]intValue]+1900)%4 == 0)) {
                ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}";// 测试出生日期的合法性
        }else{
                ereg = @"[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}";// 测试出生日期的合法性
        }
        
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg];
        isMatch = [pred evaluateWithObject:str];
        if (isMatch == NO) {
            return isMatch;
            
        }
        isMatch = NO;
        str = [NSString stringWithFormat:@"%@19%@",[str substringToIndex:6],[str substringWithRange:NSMakeRange(6, 9)]];
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++) {
            intTemp = intTemp + ([[str substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        str = [NSString stringWithFormat:@"%@%@",str,[strJiaoYan objectAtIndex:intTemp]];
    }
    if (str.length == 18) {
        NSString *ereg1 = @"";
        if (([[str substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0
            || (([[str substringWithRange:NSMakeRange(6, 4)]intValue])%100 == 0
                && ([[str substringWithRange:NSMakeRange(6, 4)]intValue])%4 == 0)) {
                ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]";// 闰年出生日期的合法性正则表达式
            } else {
                ereg1 = @"[1-9][0-9]{5}(19|20)[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]";// 平年出生日期的合法性正则表达式
            }
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",ereg1];
        isMatch = [pred evaluateWithObject:str];//610423198210293718
        if (isMatch == NO) {
            return isMatch;
            
        }
        isMatch = NO;
        
        int intTemp = 0;
        
        for (int i = 0; i<17; i++) {
            intTemp = intTemp + ([[str substringWithRange:NSMakeRange(i, 1)]intValue] * [[arr objectAtIndex:i]intValue]);
        }
        
        intTemp = intTemp % 11;
        
        NSString *last = [strJiaoYan objectAtIndex:intTemp];// 判断校验位
        
        if (![last compare:[str substringWithRange:NSMakeRange(17, 1)] options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            return isMatch;
        }

    }
    isMatch = YES;
    return isMatch;
}

+ (NSDictionary *)cardNumAreaDic{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"海外" forKey:@"91"];
    return dic;
    
}
+ (BOOL)checkCustomerName:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = @"^[a-zA-Z0-9[\u4e00-\u9fa5]]{2,25}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}
+ (BOOL)checkCustomerBirthday:(NSString *)str{
    if (str==nil) {
        return NO;
    }
    
    NSString * regex = @"^((\\d{2}(([02468][048])|([13579][26]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])))))|(\\d{2}(([02468][1235679])|([13579][01345789]))[\\-\\/\\s]?((((0?[13578])|(1[02]))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(3[01])))|(((0?[469])|(11))[\\-\\/\\s]?((0?[1-9])|([1-2][0-9])|(30)))|(0?2[\\-\\/\\s]?((0?[1-9])|(1[0-9])|(2[0-8]))))))";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
    
}

+ (BOOL)isStrSame:(NSString *)str1 str2:(NSString *)str2{
    if (!str1) {
        str1 = @"";
    }
    if (!str2) {
        str2 = @"";
    }
    if ([str1 isEqualToString:str2]) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkStartDate:(NSString *)startDate endDate:(NSString *)endDate{
    BOOL isMatch = NO;
    
    if (startDate && endDate && ![startDate isEqual:@""] && ![endDate isEqual:@""]) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *startD = [dateFormatter dateFromString:startDate];
        NSDate *endD = [dateFormatter dateFromString:endDate];
        [dateFormatter release];
        
        if ([startD compare:endD] == NSOrderedAscending || [startD compare:endD] == NSOrderedSame) {
            isMatch = YES;
        }else{
            isMatch = NO;
        }
    }
    
    return isMatch;
}
/*
+ (BOOL)checkQueryInfoWithPolicyCode:(NSString *)policyCode andPersonId:(NSString *)personId andPersonName:(NSString *)personName andPersonSex:(NSString *)personSex andPersonBirthday:(NSString *)personBirthday{
    //
    NSString *result = @"";
    int queryType=[TPLQueryInfo shareInstance].tagType;//0:证件＋保单号 1:信息＋保单号
    if (queryType == 0) {
        NSString *cardNo = personId;
        NSString *policyNo = policyCode;
        
        if (!cardNo || [cardNo isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入身份证号，请补充填写！\n",result];
        }else if ([TPLCheckUtil checkCardNum:cardNo] == NO){
            result = [NSString stringWithFormat:@"%@您输入的身份证格式错误，请核对后重新输入！\n",result];
        }
        
        if (!policyNo || [policyNo isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入保单号码，请补充填写！",result];
        }
    }else if(queryType==1){
        NSString *name = personName;
        NSString *sex = personSex;
        NSString *birth = personBirthday;
        NSString *policyNo = policyCode;
        
        if (!name || [name isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入客户姓名，请补充填写！\n",result];
        }
        if (!sex || [sex isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入客户性别，请补充填写！\n",result];
        }
        if (!birth || [birth isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入客户生日，请补充填写！\n",result];
        }
        if (!policyNo || [policyNo isEqualToString:@""]) {
            result = [NSString stringWithFormat:@"%@您未输入保单号码，请补充填写！",result];
        }
    }
    
    if ([result isEqualToString:@""]||result.length==0) {
        return YES;
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            CusAlertView *alert=[[CusAlertView alloc] initWithTitle:@"" message:result delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        });
        return NO;
    }
}

+ (BOOL)checkQueryRespDataWithRemoteService:(CWDistantHessianObject *)remoteService andListBO:(id<TPLListBOModel>)listBO{
    //过滤无效的返回值
    if (listBO!=nil&&listBO.errorBean!=nil&&listBO.errorBean.errorCode!=nil) {
        if ([listBO.errorBean.errorCode isEqualToString:@"-1"]) {//成功
            if (listBO.objList!=nil&&listBO.objList.count>0) {//成功并返回了数据
                //
                return YES;
            }else{//成功但未返回数据
                //
                dispatch_async(dispatch_get_main_queue(), ^{
                    //关闭等待框
                    CusAlertView *alert=[[CusAlertView alloc] initWithTitle:@"" message:@"您输入的查询条件未检索到符合条件的信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alert show];
                    [alert release];
                });
                return NO;
            }
        }else{//失败
            //
            NSString *infoStr=listBO.errorBean.errorInfo;
            if (infoStr==nil||[infoStr isEqualToString:@""]||infoStr.length==0) {
                infoStr=listBO.errorBean.returnMsg;
            }
            if (infoStr==nil) {
                infoStr=@"您输入的查询条件错误，请核对后重新输入！";
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //关闭等待框
                CusAlertView *alert=[[CusAlertView alloc] initWithTitle:@"" message:infoStr delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
                [alert show];
                [alert release];
            });
            return NO;
        }
    }else{
        NSDictionary *respDict=[remoteService resHeadDict];
        NSString *errorcode=[respDict valueForKey:@"errorcode"];
        NSString *errormsg=[respDict valueForKey:@"errormsg"];
        NSString *infoStr=nil;
        if ([errorcode isEqualToString:@"90001"]) {
            infoStr=@"您输入的查询条件未检索到符合条件的信息";
        }else if ([errorcode isEqualToString:@"88888"]){
            infoStr=@"后台业务接口无应答";
        }else if ([errorcode isEqualToString:@"10001"]){
            infoStr=@"不允许该设备登录";
        }else if ([errorcode isEqualToString:@"20001"]){
            infoStr=@"当前版本不是最新，请升级APP";
        }else if ([errorcode isEqualToString:@"20002"]){
            infoStr=@"版本信息不合法";
        }else if ([errorcode isEqualToString:@"30001"]){
            infoStr=@"客户管理平台对用户验证请求无响应";
        }else if ([errorcode isEqualToString:@"30002"]){
            infoStr=@"对不起，您没有跨站访问权限";
        }else if ([errorcode isEqualToString:@"30003"]){
            infoStr=@"对不起，用户名或密码缺失。请重新登录";
        }else if ([errorcode isEqualToString:@"30004"]){
            infoStr=@"对不起，您的账号已经失效，该账户被锁定,请找管理员解锁";
        }else if ([errorcode isEqualToString:@"30005"]){
            infoStr=@"对不起，您的密码输错次数超过系统允许的出错次数，账号被锁定";
        }else if ([errorcode isEqualToString:@"30006"]){
            infoStr=@"对不起，您需要修改初始密码";
        }else if ([errorcode isEqualToString:@"30007"]){
            infoStr=@"对不起，您需要修改密码";
        }else if ([errorcode isEqualToString:@"30009"]){
            infoStr=@"对不起，用户名或密码错误。请重新登录";
        }else if ([errorcode isEqualToString:@"30010"]){
            infoStr=@"对不起，您没有登录或登录信息丢失。请重新登录";
        }else if ([errorcode isEqualToString:@"30011"]){
            infoStr=@"对不起，您没有访问权限";
        }else if ([errorcode isEqualToString:@"30012"]){
            infoStr=@"对不起，权限验证异常";
        }else if ([errorcode isEqualToString:@"30008"]){
            infoStr=@"对不起，密码已重置。请登录奔驰系统修改密码后登陆";
        }else if ([errorcode isEqualToString:@"30013"]){
            infoStr=@"您的密码还有3天到期，请尽早修改密码";
        }else if ([errorcode isEqualToString:@"30021"]){
            infoStr=@"没有此用户";
        }else if ([errorcode isEqualToString:@"30022"]){
            infoStr=@"原密码输入错误";
        }else if ([errorcode isEqualToString:@"30023"]){
            infoStr=@"新密码不能与原密码一样";
        }else if ([errorcode isEqualToString:@"30024"]){
            infoStr=@"密码修改失败";
        }else if ([errorcode isEqualToString:@"30025"]){
            infoStr=@"密码长度错误";
        }else if ([errorcode isEqualToString:@"30026"]){
            infoStr=@"密码必须包含大写字母，小写字母，数字，特殊字符四项中的三项";
        }else if ([errorcode isEqualToString:@"40001"]){
            infoStr=@"该用户已在别处登陆，请重新登录";
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"backToLogin" object:nil];
                
            });
        }else if ([errorcode isEqualToString:@"40002"]){
            infoStr=@"连接超时，请重新登录";
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter]postNotificationName:@"backToLogin" object:nil];

            });

        }else if ([errorcode isEqualToString:@"99999"]){
            infoStr=@"接入端网路异常";
        }else{
            errorcode=@"00000";
            infoStr=@"网络异常，请稍后再试！";
        }
        
        errormsg=[NSString stringWithFormat:@"%@",infoStr];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //关闭等待框
            CusAlertView *alert=[[CusAlertView alloc] initWithTitle:@"" message:errormsg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alert release];
        });
        
        return NO;
    }
    //过滤结束
    
    return NO;
}
*/
@end
