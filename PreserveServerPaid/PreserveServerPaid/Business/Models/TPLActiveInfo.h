//
//  TPLActiveInfo.h
//  TPLAppBQPad
//
//  Created by cz on 5/6/14.
//  Copyright (c) 2014 TPL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TPLActiveInfo : NSObject

@property (retain, nonatomic) NSDate *activeDate;

+ (TPLActiveInfo *)shareInstance;

- (void)updateWithActiveDate:(NSDate *)activeDate;

@end
