//
//  TPLUUIDUtil.m
//  TPLAppBQPad
//
//  Created by cz on 4/23/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLUUIDUtil.h"

@implementation TPLUUIDUtil

+ (NSString *)mac{
    int mib[6];
    size_t len;
    char *buf;
    unsigned char *ptr;
    struct if_msghdr *ifm;
    struct sockaddr_dl *sdl;
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    return [outstring uppercaseString];
}

+ (NSString *)uuid{
    /*
    NSDictionary *dic=[[NSBundle mainBundle] infoDictionary];//获取info－plist
    NSString *appName=[dic objectForKey:@"CFBundleIdentifier"];//获取Bundle identifier
    KeychainItemWrapper *wrapper=[[KeychainItemWrapper alloc] initWithIdentifier:@"TPLCustServ" accessGroup:appName];
    NSString *uuid=[wrapper objectForKey:(id)kSecValueData];
    if (uuid==nil||[uuid isEqualToString:@""]||uuid.length==0) {
        uuid=[[UIDevice currentDevice].identifierForVendor UUIDString];
        [wrapper setObject:uuid forKey:(id)kSecValueData];
    }
    */
    NSString *uuid=nil;
    if (uuid==nil||[uuid isEqualToString:@""]||uuid.length==0) {
        uuid=[[UIDevice currentDevice].identifierForVendor UUIDString];
    }
    return uuid;
}

+ (NSString *)md5WithStr:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *)deviceUUID{
    //return [[TPLUUIDUtil md5WithStr:[TPLUUIDUtil mac]] retain];
    return [[TPLUUIDUtil md5WithStr:[TPLUUIDUtil uuid]] retain];
    //return [[TPLUUIDUtil mac] retain];
    //return [[TPLUUIDUtil uuid] retain];
}

+ (void)initUUID{
    NSString *uuid=[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    if (uuid==nil) {
        uuid=[TPLUUIDUtil deviceUUID];
        [[NSUserDefaults standardUserDefaults] setObject:uuid forKey:@"UUID"];
    }
}

@end
