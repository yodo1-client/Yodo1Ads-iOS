//
//  Yodo1Manager.m
//  localization_sdk_sample
//
//  Created by shon wang on 13-8-13.
//  Copyright (c) 2013年 游道易. All rights reserved.
//

#import "Yodo1Manager.h"
#import "Yodo1Commons.h"
#import "Yodo1KeyInfo.h"
#import "Yodo1UnityTool.h"
#import "Yodo1OnlineParameter.h"
#import "Yodo1Ads.h"

#ifdef YODO1_ANALYTICS
#import "AnalyticsYodo1Track.h"
#import "Yodo1AnalyticsManager.h"
#endif

#ifdef YODO1_SNS
#import "SNSManager.h"
#endif

#ifdef YODO1_MORE_GAME
#import "MoreGameManager.h"
#endif

#ifdef YODO1_UCCENTER
#import "UCenterManager.h"
#endif

#ifdef YODO1_FACEBOOK_ANALYTICS
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#endif

#import "YYModel.h"

NSString* const kFacebookAppId      = @"FacebookAppId";
NSString* const kYodo1ChannelId     = @"AppStore";

@implementation SDKConfig

@end

@interface Yodo1Manager ()

@end

@implementation Yodo1Manager

+ (void)initSDKWithConfig:(SDKConfig*)sdkConfig {
    
    NSAssert(sdkConfig.appKey != nil, @"appKey is not set!");

#ifndef UNITY_PROJECT
    //初始化广告，在线参数
    [Yodo1Ads initWithAppKey:sdkConfig.appKey];
#endif
    
#ifdef YODO1_ANALYTICS
    AnalyticsInitConfig * config = [[AnalyticsInitConfig alloc]init];
    config.gaCustomDimensions01 = sdkConfig.gaCustomDimensions01;
    config.gaCustomDimensions02 = sdkConfig.gaCustomDimensions02;
    config.gaCustomDimensions03 = sdkConfig.gaCustomDimensions03;
    config.gaResourceCurrencies = sdkConfig.gaResourceCurrencies;
    config.gaResourceItemTypes = sdkConfig.gaResourceItemTypes;
    [[Yodo1AnalyticsManager sharedInstance]initializeAnalyticsWithConfig:config];
    
    //初始化Yodo1Track
    NSString* trackAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kAdTrachingAppId];
    [AnalyticsYodo1Track setAppkey:sdkConfig.appKey];
    [AnalyticsYodo1Track initAdTrackingWithAppId:trackAppId
                                       channelId:kYodo1ChannelId];
#endif

#ifdef YODO1_SNS
    //初始化sns
    NSMutableDictionary* snsPlugn = [NSMutableDictionary dictionary];
    NSString* qqAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1QQAppId];
    NSString* wechatAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1WechatAppId];
    NSString* sinaAppKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1SinaWeiboAppKey];
    NSString* twitterConsumerKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerKey];
    NSString* twitterConsumerSecret = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerSecret];
    if (qqAppId) {
        [snsPlugn setObject:qqAppId forKey:kYodo1QQAppId];
    }
    if (wechatAppId) {
        [snsPlugn setObject:wechatAppId forKey:kYodo1WechatAppId];
    }
    if (sinaAppKey) {
        [snsPlugn setObject:sinaAppKey forKey:kYodo1SinaWeiboAppKey];
    }
    if (twitterConsumerKey && twitterConsumerSecret) {
        [snsPlugn setObject:twitterConsumerKey forKey:kYodo1TwitterConsumerKey];
        [snsPlugn setObject:twitterConsumerSecret forKey:kYodo1TwitterConsumerSecret];
    }
    [[SNSManager sharedInstance] initSNSPlugn:snsPlugn];
    
#endif

#ifdef YODO1_MORE_GAME
    [[MoreGameManager sharedInstance] setGameAppKey:sdkConfig.appKey];
#endif

    
#ifdef YODO1_FACEBOOK_ANALYTICS
    //初始化Facebook（启动统计激活）
    NSString* facebookAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kFacebookAppId];
    if ([facebookAppId length] > 0) {
        [FBSDKSettings setAppID:facebookAppId];
        [FBSDKAppEvents activateApp];
    }
#endif
    
#ifdef YODO1_UCCENTER
    [UCenterManager sharedInstance].appKey = sdkConfig.appKey;
    [UCenterManager sharedInstance].gameRegionCode = sdkConfig.regionCode;
    [UCenterManager sharedInstance].channelId = kYodo1ChannelId;
#endif
}

- (void)dealloc {
    
}

+ (void)handleOpenURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication {
#ifdef YODO1_SNS
    if ([SNSManager sharedInstance].isYodo1Shared) {
        [[SNSManager sharedInstance] application:nil openURL:url options:nil];
    }
#endif

#ifdef YODO1_UCCENTER
    if ([[UCenterManager sharedInstance] isUCAuthorzie]) {
        [[UCenterManager sharedInstance] handleOpenURL:url sourceApplication:sourceApplication];
    }
#endif
}


#ifdef __cplusplus

extern "C" {

    void UnityInitSDKWithConfig(const char* sdkConfigJson) {
        NSString* _sdkConfigJson = Yodo1CreateNSString(sdkConfigJson);
        SDKConfig* yySDKConfig = [SDKConfig yy_modelWithJSON:_sdkConfigJson];
        [Yodo1Manager initSDKWithConfig:yySDKConfig];
        
    }

    char* UnityStringParams(const char* key,const char* defaultValue) {
        NSString* _defaultValue = Yodo1CreateNSString(defaultValue);
         NSString* _key = Yodo1CreateNSString(key);
        NSString* param = [Yodo1OnlineParameter stringParams:_key defaultValue:_defaultValue];
        return Yodo1MakeStringCopy([param cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    bool UnityBoolParams(const char* key,bool defaultValue) {
        bool param = [Yodo1OnlineParameter boolParams:Yodo1CreateNSString(key) defaultValue:defaultValue];
        return param;
    }
    
    bool UnitySwitchMoreGame() {
    #ifdef YODO1_MORE_GAME
        return [[MoreGameManager sharedInstance]switchYodo1GMG];
    #else
        return NO;
    #endif
    }
    
    void UnityShowMoreGame() {
    #ifdef YODO1_MORE_GAME
        [[MoreGameManager sharedInstance] present];
    #endif
    }

    char* UnityGetDeviceId() {
        const char* deviceId = [Yodo1Commons idfvString].UTF8String;
        return Yodo1MakeStringCopy(deviceId);
    }
}

#endif

@end
