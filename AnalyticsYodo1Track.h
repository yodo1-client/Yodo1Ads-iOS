//
//  AnalyticsYodo1Track.h
//  localization_sdk
//
//  Created by xingbin on 13-10-28.
//  Copyright (c) 2013年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString* const kAdTrachingAppId;

@interface AnalyticsYodo1Track : NSObject

/*
 先设置appkey
 */
+ (void)setAppkey:(NSString*)appKey;

+ (NSString*)appKey;

/*
 初始化AdTracking
 */
+ (void)initAdTrackingWithAppId:(NSString*)appId
                      channelId:(NSString*)channelId;

/*
 yodo1 激活统计
 */
+ (void)deviceActivate;

/*
 AnalyticsYodo1Track sdk的版本号
 */
+ (NSString*)sdkVersion;

@end
