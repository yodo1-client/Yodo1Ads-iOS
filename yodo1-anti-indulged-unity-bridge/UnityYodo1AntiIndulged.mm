//
//  UnityYodo1AntiIndulged.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//
#import <Foundation/Foundation.h>

#import "Yodo1AntiIndulged.h"
#import "Yodo1UnityTool.h"

@interface Yodo1U3dAntiIndulgedDelegate:NSObject <Yodo1AntiIndulgedDelegate>
{
    
}
+ (Yodo1U3dAntiIndulgedDelegate*)shared;
@end

@implementation Yodo1U3dAntiIndulgedDelegate

static Yodo1U3dAntiIndulgedDelegate* _instance = nil;
+ (Yodo1U3dAntiIndulgedDelegate*)shared
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[Yodo1U3dAntiIndulgedDelegate alloc] init];
    });
    return _instance;
}

/// SDK初始化回调
- (void)onInitFinish:(BOOL)result message:(NSString *)message
{
    
}

/// 游戏通知
/// 返回YES 表示由游戏自己处理通知，否则SDK会使用默认处理方式
- (BOOL)onTimeLimitNotify:(Yodo1AntiIndulgedEvent *)event title:(NSString *)title message:(NSString *)message
{
    return YES;
}

@end


#ifdef __cplusplus
extern "C" {
#endif
    void UnityInit(const char* appKey, const char*extraSettings, const char* regionCode, const char* gameObjectName, const char* callbackName)
    {
    
    }

    void UnityVerifyCertificationInfo(const char* accountId, const char* gameObjectName, const char* callbackName)
    {
    
    }
    

    void UnityVerifyPurchase(double price, const char*  currency, const char* gameObjectName, const char*  callbackName)
    {
        
    }


    void UnityReportProductReceipt(const char* receipt)
    {
    
    }

    bool UnityIsGuestUser()
    {
        return false;
    }

    bool UnityIsChineseMainland()
    {
        return false;
    }
#ifdef __cplusplus
}
#endif
