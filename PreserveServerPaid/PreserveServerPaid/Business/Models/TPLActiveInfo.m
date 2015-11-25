//
//  TPLActiveInfo.m
//  TPLAppBQPad
//
//  Created by cz on 5/6/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import "TPLActiveInfo.h"

static TPLActiveInfo *activeInfo=nil;

@implementation TPLActiveInfo

+ (TPLActiveInfo *)shareInstance{
    if (activeInfo==nil) {
        activeInfo=[[TPLActiveInfo alloc] init];
    }
    return activeInfo;
}

- (void)updateWithActiveDate:(NSDate *)activeDate{
    activeInfo.activeDate=activeDate;
}


@end
