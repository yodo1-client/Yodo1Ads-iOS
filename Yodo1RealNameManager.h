//
//  Yodo1RealNameManager.h
//  Real-name
//
//  Created by yixian huang on 2020/1/2.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#ifndef Yodo1RealNameManager_h
#define Yodo1RealNameManager_h

typedef enum : NSUInteger {
    IndentifyDisabled, //禁用
    IndentifyPlayerInfo,//玩家信息系统
    IndentifyRealName,//实名制系统
    IndentifyChannel//渠道实名系统
} Indentify;

typedef enum : NSUInteger {
    StopGame,
    ResumeGame,
    ForeignIP
} VerifiedStatus;

typedef enum : NSUInteger {
    ResultCodeFailed,//失败
    ResultCodeSuccess,//成功
    ResultCodeCancel,//取消
} ResultCode;

typedef enum : NSUInteger {
    //游戏时长已到上限
    ERROR_TIME_OVER_UPPER_LIMIT = 2101,
    //达到试玩时间上限
    ERROR_TIME_OVER_GUEST = 2444,
    //禁止试玩
    ERROR_TIME_OVER_GUEST_BAN = 2445,
    //处于禁止游戏时段
    ERROR_TIME_OVER_NOGAMES_HOURS = 3101,
    //不允许购买
    ERROR_PAYMENT_HOLD_BACK = 4411,
    //达到单笔购买金额上限
    ERROR_PAYMENT_UPPER_LIMIT_PER = 4311,
    //达到累计购买金额上限
    ERROR_PAYMENT_UPPER_LIMIT_TOTAL = 4211,
    //试玩账号禁止购买
    ERROR_PAYMENT_BAN_GUEST = 4444,
} ImpubicProtectEvent;

/// 实名制回调
typedef void(^IndentifyUserCallback)(BOOL success,int resultCode,Indentify indentify,VerifiedStatus verifiedStatus,int age);
/// 当玩家剩余时长小于设定的时间（默认1小时）后，此接口开始每隔1秒触发一次
typedef void(^ConsumePlaytimeCallback)(BOOL success,long playedTime, long remainingTime);
/// 当玩家游戏时间已到时，会触发该接口
typedef void(^PlaytimeOverCallback)(BOOL success,int resultCode, NSString* msg,long playedTime);
/// 付费金额验证回调
typedef void(^VerifyPaymentCallback)(BOOL success,int resultCode, NSString* msg);

@class OnlineRealNameConfig;
@interface Yodo1RealNameManager : NSObject

@property (nonatomic,strong,readonly)NSString* yId;
@property (nonatomic,strong,readonly)NSString* userId;
@property (nonatomic,assign,readonly)int age;
@property (nonatomic,strong,readonly)OnlineRealNameConfig* onlineConfig;
@property (nonatomic,strong)IndentifyUserCallback indentifyUserCallback;
@property (nonatomic,strong)ConsumePlaytimeCallback playTimeCallback;
@property (nonatomic,strong)PlaytimeOverCallback playtimeOverCallback;
@property (nonatomic,strong)VerifyPaymentCallback verifyPaymentCallback;
@property (nonatomic,assign,readonly)long playerRemainingTime;
@property (nonatomic,assign)int playerRemainingCost;

+ (instancetype)shared;

/// 防沉迷配置
- (void)realNameConfig;

/// 实名验证
- (void)indentifyUserId:(NSString *)userId
         viewController:(UIViewController *)controller
               callback:(void (^)(BOOL isRealName,int resultCode,int age,NSError* error))callback;
/**
 *  当玩家剩余时长小于设定的时间（默认1小时）后，此接口开始每隔1秒触发一次
 */
- (void)playtimeNotifyTime:(long)seconds;

/// 创建防沉迷系统
- (void)createImpubicProtectSystem:(int)age
                          callback:(void (^)(BOOL success, NSString* msg))callback;

/// 启动防沉迷时长限制
- (void)startPlaytimeKeeper;

/// 付费前，先验证用户是否达到付款上限
- (void)verifyPaymentAmount:(int)price;

/// 查询玩家剩余可玩时长
- (void)queryPlayerRemainingTime:(void (^)(BOOL success,int resultCode, NSString* msg, double remainingTime))callback;

/// 查询玩家剩余的可花费金额
- (void)queryPlayerRemainingCost:(void (^)(BOOL success,int resultCode, NSString* msg, double cost))callback;

/// 查询模板规则
- (void)queryImpubicProtectConfigWithCode:(int)code
                                 callback:(void (^)(BOOL success,int resultCode, NSString* msg,NSString* response))callback;

@end

#endif /* Yodo1RealNameManager_h */
