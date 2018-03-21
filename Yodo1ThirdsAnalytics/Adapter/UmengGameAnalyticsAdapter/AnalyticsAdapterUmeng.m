//
//  AnalyticsAdapterUmeng.m
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "AnalyticsAdapterUmeng.h"
#import <MobClickInOne/MobClick.h>
#import <MobClickInOne/DplusMobClick.h>
#import "MobClickGameAnalytics.h"
#import "Yodo1AnalyticsManager.h"
#import "Yodo1Registry.h"
#import <Yodo1Commons.h>

NSString* const YODO1_ANALYTICS_UMENG_APPKEY  = @"UmengAnalytics";
NSString* const kChargeRequstAnalytics = @"kChargeRequstAnalytics";

@implementation AnalyticsAdapterUmeng
{
    double _currencyAmount;//现金金额
    double _virtualCurrencyAmount;//虚拟币金额
    NSString* _iapId;//物品id
}

+ (AnalyticsType)analyticsType
{
    return AnalyticsTypeUmeng;
}

+ (void)load
{
    [[Yodo1Registry sharedRegistry] registerClass:self withRegistryType:@"analyticsType"];
}

- (id)initWithAnalytics:(AnalyticsInitConfig *)initConfig
{
    self = [super init];
    if (self) {
#ifdef DEBUG
        [MobClick setLogEnabled:YES];
#endif
        UMConfigInstance.appKey = [[Yodo1KeyInfo shareInstance] configInfoForKey:YODO1_ANALYTICS_UMENG_APPKEY];
        UMConfigInstance.channelId = @"AppStore";
        UMConfigInstance.ePolicy = SEND_INTERVAL;
        UMConfigInstance.eSType = E_UM_GAME;
        [MobClick startWithConfigure:UMConfigInstance];
        [MobClick setAppVersion:[self appVersion]];
    }
    return self;
}

- (NSString*)appVersion
{
    NSDictionary* infoDictionary = [[NSBundle mainBundle] infoDictionary];
    if ([[infoDictionary allKeys] containsObject:@"CFBundleShortVersionString"]) {
        return [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    }
    return nil;
}

- (void)eventWithAnalyticsEventName:(NSString *)eventName
                          eventData:(NSDictionary *)eventData
{
    if (eventData) {
        [MobClick event:eventName attributes:eventData];
    }
}

- (void)startLevelAnalytics:(NSString*)level
{
    if (level) {
        [MobClickGameAnalytics startLevel:level];
    }
}

- (void)finishLevelAnalytics:(NSString*)level
{
    if (level) {
        [MobClickGameAnalytics finishLevel:level];
    }
}

- (void)failLevelAnalytics:(NSString*)level  failedCause:(NSString*)cause
{
    if (level) {
        [MobClickGameAnalytics failLevel:level];
    }
}

- (void)userLevelIdAnalytics:(int)level
{
    [MobClickGameAnalytics setUserLevelId:level];
}

//虚拟货币请求
- (void)chargeRequstAnalytics:(NSString*)orderId
                        iapId:(NSString*)iapId
               currencyAmount:(double)currencyAmount
                 currencyType:(NSString *)currencyType
        virtualCurrencyAmount:(double)virtualCurrencyAmount
                  paymentType:(NSString *)paymentType
{
    _currencyAmount = currencyAmount;
    _virtualCurrencyAmount = virtualCurrencyAmount;
    _iapId = iapId;
    
    if (orderId) {
        NSDictionary*dic1 = @{orderId:[NSNumber numberWithDouble:currencyAmount]};
        NSDictionary*dic2 = @{orderId:[NSNumber numberWithDouble:virtualCurrencyAmount]};
        NSDictionary*dic3 = @{orderId:iapId==nil?@"":iapId};
        NSArray* arr = @[dic1,dic2,dic3];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kChargeRequstAnalytics];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
    
    NSString* userId = [Yodo1Commons idfvString];
    NSString* amount = [NSString stringWithFormat:@"%f",virtualCurrencyAmount];
    [MobClick event:@"__submit_payment" attributes:@{@"userid":userId,@"orderid":orderId,@"item":iapId,@"amount":amount}];
}

//虚拟货币交易成功
- (void)chargeSuccessAnalytics:(NSString *)orderId source:(int)source
{
    if (orderId) {
        NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:kChargeRequstAnalytics];
        if ([arr count] >0) {
            for (int i = 0; i<[arr count]; i++) {
                 NSDictionary* dic = [arr objectAtIndex:i];
                if ([[dic allKeys]containsObject:orderId]) {
                    if (i==0) {
                        _currencyAmount = [[dic objectForKey:orderId]doubleValue];
                    }else if(i==1){
                        _virtualCurrencyAmount = [[dic objectForKey:orderId]doubleValue];
                    }else if (i==2){
                        _iapId = (NSString*)[dic objectForKey:orderId];
                    }
                }
            }
        }

        [MobClickGameAnalytics pay:_currencyAmount source:0 coin:_virtualCurrencyAmount];
        NSString* userId = [Yodo1Commons idfvString];
        NSString* amount = [NSString stringWithFormat:@"%f",_virtualCurrencyAmount];
        [MobClick event:@"__finish_payment"
             attributes:@{@"userid":(userId?userId:@""),@"orderid":orderId,@"item":(_iapId?_iapId:@""),@"amount":(amount?amount:@"")}];
    }
}

//玩家获虚拟币奖励
- (void)rewardAnalytics:(double)virtualCurrencyAmount reason:(NSString *)reason source:(int)source
{
    [MobClickGameAnalytics bonus:virtualCurrencyAmount source:0];
}

//玩家支付货币购买道具.
- (void)purchaseAnalytics:(NSString *)item itemNumber:(int)number priceInVirtualCurrency:(double)price
{
    [MobClickGameAnalytics buy:item amount:number price:price];
}

//道具消耗统计
- (void)useAnalytics:(NSString *)item amount:(int)amount price:(double)price
{
    [MobClickGameAnalytics use:item amount:amount price:price];
}

#pragma mark- DplusMobClick

- (void)track:(NSString *)eventName
{
    if (eventName == nil) {
        return;
    }
    [DplusMobClick track:eventName];
}

- (void)track:(NSString *)eventName property:(NSDictionary *) property
{
    if (eventName == nil || property == nil) {
        return;
    }
    [DplusMobClick track:eventName property:property];
}

- (void)registerSuperProperty:(NSDictionary *)property
{
    if (property == nil) {
        return;
    }
    [DplusMobClick registerSuperProperty:property];
}

- (void)unregisterSuperProperty:(NSString *)propertyName
{
    if (propertyName == nil) {
        return;
    }
    [DplusMobClick unregisterSuperProperty:propertyName];
}

- (NSString *)getSuperProperty:(NSString *)propertyName
{
    if (propertyName) {
        return [DplusMobClick getSuperProperty:propertyName];
    }
    return nil;
}

- (NSDictionary *)getSuperProperties
{
  return [DplusMobClick getSuperProperties];
}

- (void)clearSuperProperties
{
    [DplusMobClick clearSuperProperties];
}

- (void)dealloc
{
    
}

@end
