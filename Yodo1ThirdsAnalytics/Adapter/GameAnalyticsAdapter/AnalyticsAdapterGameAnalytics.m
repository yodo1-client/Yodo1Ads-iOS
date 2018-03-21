//
//  AnalyticsAdapterGameAnalytics.m
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "AnalyticsAdapterGameAnalytics.h"
#import "Yodo1Registry.h"
#import <GameAnalytics/GameAnalytics.h>
#import "Yodo1Commons.h"

NSString* const YODO1_ANALYTICS_GAMEANALYTICS_GAME_KEY      = @"GameAnalyticsGameKey";
NSString* const YODO1_ANALYTICS_GAMEANALYTICS_GAME_SECRET   = @"GameAnalyticsGameSecret";

NSString* const kGameAnalyticsChargeRequstAnalytics = @"kGameAnalyticsChargeRequstAnalytics";

@implementation AnalyticsAdapterGameAnalytics
{
    double _currencyAmount;//现金金额
    double _virtualCurrencyAmount;//虚拟币金额
    NSString* _itemId;//物品id
    NSString* _iapId;//产品ID
    NSString* _currencyType;//货币类型USD,RMB等等
    NSString* _paymentType;//支付类型
    
}

+ (AnalyticsType)analyticsType
{
    return AnalyticsTypeGameAnalytics;
}

+ (void)load
{
    [[Yodo1Registry sharedRegistry] registerClass:self withRegistryType:@"analyticsType"];
}

- (id)initWithAnalytics:(AnalyticsInitConfig *)initConfig
{
    self = [super init];
    if (self) {
        
        [GameAnalytics configureBuild:[Yodo1Commons appVersion]];
        [GameAnalytics configureUserId:[Yodo1Commons idfvString]];
        if ([initConfig.gaCustomDimensions01 count] > 0 ) {
            [GameAnalytics configureAvailableCustomDimensions01:initConfig.gaCustomDimensions01];
        }
        if ([initConfig.gaCustomDimensions02 count] > 0 ) {
            [GameAnalytics configureAvailableCustomDimensions02:initConfig.gaCustomDimensions02];
        }
        if ([initConfig.gaCustomDimensions03 count] > 0 ) {
            [GameAnalytics configureAvailableCustomDimensions03:initConfig.gaCustomDimensions03];
        }
        if ([initConfig.gaResourceCurrencies count] > 0 ) {
            [GameAnalytics configureAvailableResourceCurrencies:initConfig.gaResourceCurrencies];
        }
        if ([initConfig.gaResourceItemTypes count] > 0 ) {
            [GameAnalytics configureAvailableResourceItemTypes:initConfig.gaResourceItemTypes];
        }
        [GameAnalytics initializeWithGameKey:[[Yodo1KeyInfo shareInstance] configInfoForKey:YODO1_ANALYTICS_GAMEANALYTICS_GAME_KEY]
                                  gameSecret:[[Yodo1KeyInfo shareInstance] configInfoForKey:YODO1_ANALYTICS_GAMEANALYTICS_GAME_SECRET]];
    }
    return self;
}

/**
 1) NSDictionary的Value目前仅支持字符串（NSString）和数字（NSNumber）类型，
    key类型必须是NSString。如果value为NSString，TalkingData会统计每种value出现的次数；
    如果为NSNumber类型，那么TalkingData会统计value的总和/平均值。
 2）	eventId、Dictionary的key和NSString类型的value，分别最多支持32个字符。
 */
- (void)eventWithAnalyticsEventName:(NSString *)eventName
                          eventData:(NSDictionary *)eventData
{
    if (eventName) {
        [GameAnalytics addDesignEventWithEventId:eventName];
    }

}

- (void)startLevelAnalytics:(NSString*)level
{
    if (level) {
        [GameAnalytics addProgressionEventWithProgressionStatus:GAProgressionStatusStart
                                                  progression01:level
                                                  progression02:nil
                                                  progression03:nil];
    }
}

- (void)finishLevelAnalytics:(NSString*)level
{
    if (level) {
        [GameAnalytics addProgressionEventWithProgressionStatus:GAProgressionStatusComplete
                                                  progression01:level
                                                  progression02:nil
                                                  progression03:nil];
    }
}

- (void)failLevelAnalytics:(NSString*)level failedCause:(NSString*)cause
{
    if (level) {
        [GameAnalytics addProgressionEventWithProgressionStatus:GAProgressionStatusFail
                                                  progression01:level
                                                  progression02:nil
                                                  progression03:nil];
    }
}

- (void)userLevelIdAnalytics:(int)level
{

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
    _currencyType = currencyType;
    _paymentType = paymentType;
    
    if (orderId) {
        NSDictionary*dic1 = @{orderId:[NSNumber numberWithDouble:currencyAmount]};
        NSDictionary*dic2 = @{orderId:[NSNumber numberWithDouble:virtualCurrencyAmount]};
        NSDictionary*dic3 = @{orderId:iapId == nil?@"":iapId};
        NSDictionary*dic4 = @{orderId:currencyType == nil?@"":currencyType};
        NSDictionary*dic5 = @{orderId:paymentType == nil?@"":paymentType};
        
        NSArray* arr = @[dic1,dic2,dic3,dic4,dic5];
        [[NSUserDefaults standardUserDefaults] setObject:arr forKey:kGameAnalyticsChargeRequstAnalytics];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
   
}

//虚拟货币充值成功
- (void)chargeSuccessAnalytics:(NSString *)orderId source:(int)source
{
    if (orderId) {
        NSArray* arr = [[NSUserDefaults standardUserDefaults] objectForKey:kGameAnalyticsChargeRequstAnalytics];
        if ([arr count] >0) {
            for (int i = 0; i<[arr count]; i++) {
                NSDictionary* dic = [arr objectAtIndex:i];
                if ([[dic allKeys]containsObject:orderId]) {
                    if (i==0) {
                        _currencyAmount = [[dic objectForKey:orderId]doubleValue];
                    }else if(i==1){
                        _virtualCurrencyAmount = [[dic objectForKey:orderId]doubleValue];
                    }else if(i==2){
                        _iapId = (NSString*)[dic objectForKey:orderId];
                    }else if (i==3) {
                        _currencyType = (NSString*)[dic objectForKey:orderId];
                    }else if(i==4){
                        _paymentType = (NSString*)[dic objectForKey:orderId];
                    }
                }
            }
        }
        [GameAnalytics addBusinessEventWithCurrency:_currencyType
                                             amount:_currencyAmount
                                           itemType:_iapId
                                             itemId:_iapId
                                           cartType:_paymentType
                                   autoFetchReceipt:YES];
    }
}

//虚拟货币赠送
- (void)rewardAnalytics:(double)virtualCurrencyAmount reason:(NSString *)reason source:(int)source
{
    //奖励金币
    [GameAnalytics addResourceEventWithFlowType:GAResourceFlowTypeSource
                                       currency:@"Coins"
                                         amount:[NSNumber numberWithFloat:virtualCurrencyAmount]
                                       itemType:@"Rewards"
                                         itemId:@"Coins"];
}

//使用虚拟货币购买游戏道具
- (void)purchaseAnalytics:(NSString *)item itemNumber:(int)number priceInVirtualCurrency:(double)price;
{
    [GameAnalytics addResourceEventWithFlowType:GAResourceFlowTypeSink
                                       currency:@"Coins"
                                         amount:[NSNumber numberWithFloat:price]
                                       itemType:item
                                         itemId:item];
    
    [GameAnalytics addResourceEventWithFlowType:GAResourceFlowTypeSource
                                       currency:item
                                         amount:[NSNumber numberWithFloat:number]
                                       itemType:@"Coins"
                                         itemId:item];
}

//虚拟物品消耗
- (void)useAnalytics:(NSString *)item amount:(int)amount price:(double)price
{
    [GameAnalytics addResourceEventWithFlowType:GAResourceFlowTypeSink
                                       currency:item
                                         amount:[NSNumber numberWithFloat:price]
                                       itemType:@"Gameplay"
                                         itemId:item];
}

- (void)setGACustomDimension01:(NSString*)dimension01
{
    [GameAnalytics setCustomDimension01:dimension01];
}

- (void)setGACustomDimension02:(NSString *)dimension02
{
    [GameAnalytics setCustomDimension02:dimension02];
}

- (void)setGACustomDimension03:(NSString*)dimension03
{
    [GameAnalytics setCustomDimension03:dimension03];
}

- (void)dealloc
{
    
}

@end
