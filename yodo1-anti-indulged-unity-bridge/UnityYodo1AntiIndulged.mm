//
//  UnityYodo1AntiIndulged.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//
#import <Foundation/Foundation.h>

#import "UnityYodo1AntiIndulged.h"
#import "Yodo1AntiIndulgedUtils.h"
#import "Yodo1AntiIndulged.h"
#import "Yodo1UnityTool.h"
#import "Yodo1Model.h"
static NSString *kLog_TAG = @"[Yodo1-AntiIndulged-SDK] ";


static NSString *kRESULT_TYPE_KEY = @"result_type";
static NSString *kRESULT_CODE_KEY = @"code";
static NSString *kRESULT_BOOL_KEY = @"state";
static NSString *kRESULT_ERROR_KEY = @"error";
static NSString *kRESULT_EVENT_ACTION = @"event_action";
static NSString *kRESULT_EVENT_CODE = @"event_code";
static NSString *kRESULT_TITLE = @"title";
static NSString *kRESULT_CONTEXT = @"context";

@interface Yodo1U3dAntiIndulgedDelegate:NSObject <Yodo1AntiIndulgedDelegate>
{
    NSString* _gameObjectName;
    NSString* _callbackName;
}
@end

@implementation Yodo1U3dAntiIndulgedDelegate
- (Yodo1U3dAntiIndulgedDelegate*)initWith:(NSString*)gameObjectName  callbackName: (NSString*)callbackName
{
    _gameObjectName = gameObjectName;
    _callbackName = callbackName;
    return self;
}

/// SDK初始化回调
- (void)onInitFinish:(BOOL)result message:(NSString *)message
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:ResulTypeInit] forKey:kRESULT_TYPE_KEY];
    [dict setObject:[[NSNumber alloc]initWithBool:result] forKey:kRESULT_BOOL_KEY];
    [dict setObject:message forKey:kRESULT_CONTEXT];
    
    NSError* parseJSONError = nil;
    NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
    if(parseJSONError){
        [dict setObject:[NSNumber numberWithInt:ResulTypeInit] forKey:kRESULT_TYPE_KEY];
        [dict setObject:[[NSNumber alloc]initWithBool:result] forKey:kRESULT_BOOL_KEY];
        [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
        msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
    }
    UnitySendMessage([_gameObjectName cStringUsingEncoding:NSUTF8StringEncoding],
                     [_callbackName cStringUsingEncoding:NSUTF8StringEncoding],
                     [msg cStringUsingEncoding:NSUTF8StringEncoding]);
}

/// 游戏通知
/// 返回YES 表示由游戏自己处理通知，否则SDK会使用默认处理方式
- (BOOL)onTimeLimitNotify:(Yodo1AntiIndulgedEvent *)event title:(NSString *)title message:(NSString *)message
{
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    [dict setObject:[NSNumber numberWithInteger:ResulTypeTimeLimit] forKey:kRESULT_TYPE_KEY];
    [dict setObject:[NSNumber numberWithInteger:[event action]] forKey:kRESULT_EVENT_ACTION];
    [dict setObject:[NSNumber numberWithInteger:[event eventCode]] forKey:kRESULT_EVENT_CODE];
    [dict setObject:title forKey:kRESULT_TITLE];
    [dict setObject:message forKey:kRESULT_CONTEXT];
    
    NSError* parseJSONError = nil;
    NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
    if(parseJSONError){
        [dict setObject:[NSNumber numberWithInt:ResulTypeTimeLimit] forKey:kRESULT_TYPE_KEY];
        [dict setObject:[NSNumber numberWithInteger:[event action]] forKey:kRESULT_EVENT_ACTION];
        [dict setObject:[NSNumber numberWithInteger:[event eventCode]] forKey:kRESULT_EVENT_CODE];
        [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
        msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
    }
    UnitySendMessage([_gameObjectName cStringUsingEncoding:NSUTF8StringEncoding],
                     [_callbackName cStringUsingEncoding:NSUTF8StringEncoding],
                     [msg cStringUsingEncoding:NSUTF8StringEncoding]);
    return YES;
}

@end


#ifdef __cplusplus
extern "C" {
#endif
    void UnityInit(const char* appKey, const char*extraSettings, const char* regionCode, const char* gameObjectName, const char* methodName)
    {
        NSLog(@"%@UnityCall %s, appKey = %s, extraSettings = %s, regionCode = %s",kLog_TAG, __FUNCTION__, appKey, extraSettings, regionCode);
        NSString* ocAppKey = Yodo1CreateNSString(appKey);
        NSString* ocExtraSettings = Yodo1CreateNSString(extraSettings);
        NSString* ocRegionCode = Yodo1CreateNSString(regionCode);
        NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
        NSString* ocMethodName = Yodo1CreateNSString(methodName);
        [[Yodo1AntiIndulged shared] init:ocAppKey regionCode:ocRegionCode delegate:[[Yodo1U3dAntiIndulgedDelegate new] initWith:ocGameObjName callbackName:ocMethodName]];
    }

    void UnityVerifyCertificationInfo(const char* accountId, const char* gameObjectName, const char* methodName)
    {
        NSLog(@"%@UnityCall %s, accountId = %s",kLog_TAG, __FUNCTION__, accountId);
        NSString* ocAccountId = Yodo1CreateNSString(accountId);
        NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
        NSString* ocMethodName = Yodo1CreateNSString(methodName);
        
        
        [[Yodo1AntiIndulged shared] verifyCertificationInfo:ocAccountId success:^BOOL(id data) {
            Yodo1AntiIndulgedEvent* event = data;
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:ResulTypeCertification] forKey:kRESULT_TYPE_KEY];
            [dict setObject:[NSNumber numberWithInteger:event.action] forKey:kRESULT_EVENT_ACTION];
            
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInteger:ResulTypeCertification] forKey:kRESULT_TYPE_KEY];
                [dict setObject:[NSNumber numberWithInteger:YES] forKey:kRESULT_EVENT_ACTION];
                [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
                msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            return YES;
        } failure:^BOOL(NSError *error) {
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:ResulTypeCertification] forKey:kRESULT_TYPE_KEY];
            [dict setObject:[NSNumber numberWithInteger:Yodo1AntiIndulgedActionEndGame] forKey:kRESULT_EVENT_ACTION];
            
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInteger:ResulTypeCertification] forKey:kRESULT_TYPE_KEY];
                [dict setObject:[NSNumber numberWithInteger:Yodo1AntiIndulgedActionEndGame] forKey:kRESULT_EVENT_ACTION];
                [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
                msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            return YES;
        }];
    }
    

    void UnityVerifyPurchase(double price, const char*  currency, const char* gameObjectName, const char*  methodName)
    {
        NSLog(@"%@UnityCall %s, price = %f, currency = %s",kLog_TAG, __FUNCTION__, price, currency);
        NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
        NSString* ocMethodName = Yodo1CreateNSString(methodName);
        [[Yodo1AntiIndulged shared] verifyPurchase:(NSInteger)price success:^(id data) {
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:ResulTypeVerifyPurchase] forKey:kRESULT_TYPE_KEY];
            [dict setObject:[[NSNumber alloc]initWithBool:YES] forKey:kRESULT_BOOL_KEY];
            
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInteger:ResulTypeVerifyPurchase] forKey:kRESULT_TYPE_KEY];
                [dict setObject:[[NSNumber alloc]initWithBool:YES] forKey:kRESULT_BOOL_KEY];
                [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
                msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            return YES;
        } failure:^(NSError *error) {
            //error.localizedDescription
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInteger:ResulTypeVerifyPurchase] forKey:kRESULT_TYPE_KEY];
            [dict setObject:[[NSNumber alloc]initWithBool:YES] forKey:kRESULT_BOOL_KEY];
            [dict setObject:error.localizedDescription forKey:kRESULT_CONTEXT];
            
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInteger:ResulTypeVerifyPurchase] forKey:kRESULT_TYPE_KEY];
                [dict setObject:[[NSNumber alloc]initWithBool:NO] forKey:kRESULT_BOOL_KEY];
                [dict setObject:@"Convert result to json failed!" forKey:kRESULT_CONTEXT];
                msg =  [Yodo1AntiIndulgedUtils stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            return YES;
        }];
    }


    void UnityReportProductReceipt(const char* receipt)
    {
        NSString* receiptJson = Yodo1CreateNSString(receipt);
        NSLog(@"%@UnityCall %s receipt = %@",kLog_TAG, __FUNCTION__, receiptJson);
        Yodo1AntiIndulgedProductReceipt* receiptData = [Yodo1AntiIndulgedProductReceipt yodo1_modelWithJSON:receiptJson];
        receiptData.spendDate = [Yodo1AntiIndulgedUtils dateString:[NSDate date]];
        [[Yodo1AntiIndulged shared] reportProductReceipt:receiptData success:^(id data) {
            NSLog(@"%@%s %@",kLog_TAG, __FUNCTION__, @"上报成功");
            return YES;
        } failure:^(NSError *error) {
            NSLog(@"%@%s %@",kLog_TAG, __FUNCTION__, @"上报失败");
            return YES;
        }];
    }

    bool UnityIsGuestUser()
    {
        NSLog(@"%@UnityCall %s",kLog_TAG, __FUNCTION__);
        return [[Yodo1AntiIndulged shared] isGuestUser];
    }

    bool UnityIsChineseMainland()
    {
        NSLog(@"%@UnityCall %s",kLog_TAG, __FUNCTION__);
        return false;
    }
#ifdef __cplusplus
}
#endif
