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
#import "Yd1OnlineParameter.h"
#import "Yodo1Tool+Storage.h"
#import "AnalyticsYodo1Track.h"
#import "Yodo1UDIDManager.h"
#import "Bugly.h"

#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

#import "Yodo1Ads.h"

#ifdef YODO1_ANALYTICS
#import "Yodo1AnalyticsManager.h"
#endif

#ifdef YODO1_SNS
#import "SNSManager.h"
#endif

#ifdef YODO1_MORE_GAME
#import "MoreGameManager.h"
#endif

#ifdef YODO1_UCCENTER
#import "Yd1UCenterManager.h"
#endif

#ifdef YODO1_FACEBOOK_ANALYTICS
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#endif

#ifdef YODO1_SOOMLA
#import "SoomlaConfig.h"
#import "SoomlaTraceback.h"
#endif

#import "Yodo1Model.h"

NSString* const kFacebookAppId      = @"FacebookAppId";
NSString* const kYodo1ChannelId     = @"AppStore";

NSString* const kSoomlaAppKey       = @"SoomlaAppKey";

@implementation SDKConfig

@end

static SDKConfig* kYodo1Config = nil;
static BOOL isInitialized = false;

@interface Yodo1Manager ()

@end

@implementation Yodo1Manager

+ (void)initSDKWithConfig:(SDKConfig*)sdkConfig {
    
    NSAssert(sdkConfig.appKey != nil, @"appKey is not set!");
    if (isInitialized) {
        NSLog(@"[Yodo1 SDK] has already been initialized!");
        return;
    }
    isInitialized = true;
    //同意上传数据
    BOOL isGDPR = [[NSUserDefaults standardUserDefaults]boolForKey:@"gdpr_data_consent"];
    //16岁以上
    BOOL isCCPA = [NSUserDefaults.standardUserDefaults boolForKey:@"below_age_data_consent"];
#ifdef YODO1_SOOMLA
    if (!isGDPR) {
        [[SoomlaTraceback getInstance]setUserConsent:YES];
    } else {
        [[SoomlaTraceback getInstance]setUserConsent:NO];
    }
    NSString *appKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kSoomlaAppKey];
    SoomlaConfig *config = [SoomlaConfig config];
    [[SoomlaTraceback getInstance] initializeWithAppKey:appKey andConfig:config];
#endif

    //初始化Yodo1Track
    NSString* trackAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kAdTrachingAppId];
    [AnalyticsYodo1Track setAppkey:sdkConfig.appKey];
    [AnalyticsYodo1Track initAdTrackingWithAppId:trackAppId
                                       channelId:kYodo1ChannelId];
#ifndef UNITY_PROJECT
    //初始化广告，在线参数
    [Yodo1Ads initWithAppKey:sdkConfig.appKey];
#endif
    
#ifdef YODO1_ANALYTICS
    kYodo1Config = sdkConfig;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onlineParameterPaNotifi:)
                                                 name:kYodo1OnlineConfigFinishedNotification
                                               object:nil];
#endif

#ifdef YODO1_SNS
    //初始化sns
    NSMutableDictionary* snsPlugn = [NSMutableDictionary dictionary];
    NSString* qqAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1QQAppId];
    NSString* wechatAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1WechatAppId];
    NSString* wechatUniversalLink = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1WechatUniversalLink];
    NSString* sinaAppKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1SinaWeiboAppKey];
    NSString* twitterConsumerKey = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerKey];
    NSString* twitterConsumerSecret = [[Yodo1KeyInfo shareInstance]configInfoForKey:kYodo1TwitterConsumerSecret];
    if (qqAppId) {
        [snsPlugn setObject:qqAppId forKey:kYodo1QQAppId];
    }
    if (wechatAppId) {
        [snsPlugn setObject:wechatAppId forKey:kYodo1WechatAppId];
    }
    if (wechatUniversalLink) {
        [snsPlugn setObject:wechatUniversalLink forKey:kYodo1WechatUniversalLink];
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
    if (!isGDPR) {
        [FBSDKSettings setAutoInitEnabled:YES];
        [FBSDKSettings setAutoLogAppEventsEnabled:YES];
        [FBSDKSettings setLimitEventAndDataUsage:NO];
        [FBSDKAppEvents activateApp];
    } else {
        [FBSDKSettings setAutoInitEnabled:NO];
        [FBSDKSettings setAutoLogAppEventsEnabled:NO];
        [FBSDKSettings setLimitEventAndDataUsage:YES];
    }
    
    NSString* facebookAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:kFacebookAppId];
    if ([facebookAppId length] > 0) {
        [FBSDKSettings setAppID:facebookAppId];
    }
    
#endif
    
#ifdef YODO1_UCCENTER
    [Yd1OnlineParameter.shared cachedCompletionHandler:^{
        YD1LOG(@"Online Parameter is Success!");
        NSLog(@"%@",Yd1UCenterManager.shared);
    }];
#endif
    NSString* buglyAppId = [Yd1OnlineParameter.shared stringConfigWithKey:@"BuglyAnalytic_AppId" defaultValue:@""];
    if (buglyAppId.length > 0 && isGDPR && isCCPA) {
        BuglyConfig* buglyConfig = [[BuglyConfig alloc]init];
#ifdef DEBUG
        buglyConfig.debugMode = YES;
#endif
        buglyConfig.channel = @"appstore";
        
        [Bugly startWithAppId:buglyAppId config:buglyConfig];
        
        NSString* sdkInfo = [NSString stringWithFormat:@"%@,%@",[Yodo1Manager publishType],[Yodo1Manager publishVersion]];
        
        [Bugly setUserIdentifier:Bugly.buglyDeviceId];
        [Bugly setUserValue:@"appstore" forKey:@"ChannelCode"];
        [Bugly setUserValue:sdkConfig.appKey forKey:@"GameKey"];
        [Bugly setUserValue:[Yodo1Commons idfaString] forKey:@"DeviceID"];
        [Bugly setUserValue:sdkInfo forKey:@"SdkInfo"];
        [Bugly setUserValue:[Yodo1Commons idfaString] forKey:@"IDFA"];
        [Bugly setUserValue:[Yodo1Commons idfvString] forKey:@"IDFV"];
        [Bugly setUserValue:[Yodo1Commons territory] forKey:@"CountryCode"];
    }
    
}

+ (NSDictionary*)config {
    NSBundle *bundle = [[NSBundle alloc] initWithPath:[[NSBundle mainBundle]
                                                       pathForResource:@"Yodo1Ads"
                                                       ofType:@"bundle"]];
    if (bundle) {
        NSString *configPath = [bundle pathForResource:@"config" ofType:@"plist"];
        if (configPath) {
            NSDictionary *config =[NSDictionary dictionaryWithContentsOfFile:configPath];
            return config;
        }
    }
    return nil;
}

+ (NSString*)publishType {
    NSDictionary* _config = [Yodo1Manager config];
    NSString* _publishType = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishType"]) {
        _publishType = (NSString*)[_config objectForKey:@"PublishType"];
    }
    return _publishType;
}
    
+ (NSString*)publishVersion {
    NSDictionary* _config = [Yodo1Manager config];
    NSString* _publishVersion = @"";
    if (_config && [[_config allKeys]containsObject:@"PublishVersion"]) {
        _publishVersion = (NSString*)[_config objectForKey:@"PublishVersion"];
    }
    return _publishVersion;
}

#ifdef YODO1_ANALYTICS
+ (void)onlineParameterPaNotifi:(NSNotification *)notif {
    AnalyticsInitConfig * config = [[AnalyticsInitConfig alloc]init];
    config.gaCustomDimensions01 = kYodo1Config.gaCustomDimensions01;
    config.gaCustomDimensions02 = kYodo1Config.gaCustomDimensions02;
    config.gaCustomDimensions03 = kYodo1Config.gaCustomDimensions03;
    config.gaResourceCurrencies = kYodo1Config.gaResourceCurrencies;
    config.gaResourceItemTypes = kYodo1Config.gaResourceItemTypes;
    config.appsflyerCustomUserId = kYodo1Config.appsflyerCustomUserId;
    [[Yodo1AnalyticsManager sharedInstance]initializeAnalyticsWithConfig:config];
}
#endif

- (void)dealloc {
#ifdef YODO1_ANALYTICS
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:kYodo1OnlineConfigFinishedNotification
                                                 object:nil];
    kYodo1Config = nil;
#endif
}

+ (void)handleOpenURL:(NSURL*)url sourceApplication:(NSString*)sourceApplication {
#ifdef YODO1_SNS
    if ([SNSManager sharedInstance].isYodo1Shared) {
        [[SNSManager sharedInstance] application:nil openURL:url options:nil];
    }
#endif

}


#ifdef __cplusplus

extern "C" {

    void UnityInitSDKWithConfig(const char* sdkConfigJson) {
        NSString* _sdkConfigJson = Yodo1CreateNSString(sdkConfigJson);
        SDKConfig* yySDKConfig = [SDKConfig yodo1_modelWithJSON:_sdkConfigJson];
        [Yodo1Manager initSDKWithConfig:yySDKConfig];
        
    }

    char* UnityStringParams(const char* key,const char* defaultValue) {
        NSString* _defaultValue = Yodo1CreateNSString(defaultValue);
         NSString* _key = Yodo1CreateNSString(key);
        NSString* param = [Yd1OnlineParameter.shared stringConfigWithKey:_key defaultValue:_defaultValue];
        return Yodo1MakeStringCopy([param cStringUsingEncoding:NSUTF8StringEncoding]);
    }
    
    bool UnityBoolParams(const char* key,bool defaultValue) {
        bool param = [Yd1OnlineParameter.shared boolConfigWithKey:Yodo1CreateNSString(key) defaultValue:defaultValue];
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
        const char* deviceId = Yd1OpsTools.keychainDeviceId.UTF8String;
        return Yodo1MakeStringCopy(deviceId);
    }

    char* UnityUserId(){
        const char* userId = Yd1OpsTools.keychainUUID.UTF8String;
        return Yodo1MakeStringCopy(userId);
    }

    bool UnityIsChineseMainland()
    {
        CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
        CTCarrier *carrier = [info subscriberCellularProvider];
            //运营商可用
        BOOL use = carrier.allowsVOIP;
        if(use){
            NSString *code = carrier.isoCountryCode;
            if([code isEqualToString:@"cn"]){
                return true;
            }
        }
        if([[Yodo1Commons territory]isEqualToString:@"CN"]){
            return true;
        }
        return false;
    }
}

#endif

@end
