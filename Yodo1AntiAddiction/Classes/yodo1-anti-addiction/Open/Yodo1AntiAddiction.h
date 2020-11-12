//
//  Yodo1AntiAddiction.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 统一成功回调
/// return YES 表示游戏自己处理成功逻辑，NO表示由SDK默认处理
typedef BOOL (^Yodo1AntiAddictionSuccessful)(id _Nullable);
/// 统一错误回调
/// return YES 表示游戏自己处理错误逻辑，NO表示由SDK默认处理
typedef BOOL (^Yodo1AntiAddictionFailure)(NSError * _Nonnull);

typedef enum: NSInteger {
    Yodo1AntiAddictionProductTypeNonConsumables = 0,
    Yodo1AntiAddictionProductTypeConsumables = 1,
    Yodo1AntiAddictionProductTypeAutoSubscription = 2
} Yodo1AntiAddictionProductType;

typedef enum: NSInteger {
    Yodo1AntiAddictionActionResumeGame = 0,
    Yodo1AntiAddictionActionEndGame = 1
} Yodo1AntiAddictionAction;

typedef enum: NSInteger {
    Yodo1AntiAddictionEventCodeNone = 0,
    /**
     * 对于已玩时间的通知-未成年人
     */
    Yodo1AntiAddictionEventCodeMinorPlayedTime = 11001,
    /**
     * 对于禁玩时段的通知-未成年人
     */
    Yodo1AntiAddictionEventCodeMinorForbiddenTime = 12001,
    /**
     * 对于已玩时间的通知-游客
     */
    Yodo1AntiAddictionEventCodeGuestPlayedTime = 11011,
    /**
     * 对于禁玩时段的通知-游客
     */
    Yodo1AntiAddictionEventCodeGuestForbiddenTime = 12011
} Yodo1AntiAddictionEventCode;

@interface Yodo1AntiAddictionEvent : NSObject

@property (nonatomic, assign) Yodo1AntiAddictionEventCode eventCode;
@property (nonatomic, assign) Yodo1AntiAddictionAction action;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

//小票及商品信息组
@interface Yodo1AntiAddictionProductReceipt : NSObject

@property (nonatomic, retain) NSString *orderId; // 订单编号
@property (nonatomic, retain) NSString *itemCode; // 商品编号
@property (nonatomic, assign) Yodo1AntiAddictionProductType itemType; // 商品类型
@property (nonatomic, assign) NSInteger money; // 金额 单位分
@property (nonatomic, retain) NSString *region; // 区
@property (nonatomic, retain) NSString *spendDate; // 消费时间
@property (nonatomic, retain) NSString *currency; // 币种（大写） ,示例值(CNY)

@end

@protocol Yodo1AntiAddictionDelegate <NSObject>

@optional
/// SDK初始化回调
- (void)onInitFinish:(BOOL)result message:(NSString *)message;
/// 游戏通知
/// 返回YES 表示由游戏自己处理通知，否则SDK会使用默认处理方式
- (BOOL)onTimeLimitNotify:(Yodo1AntiAddictionEvent *)event title:(NSString *)title message:(NSString *)message;

@end

@interface Yodo1AntiAddiction : NSObject

@property (nonatomic, assign) BOOL autoTimer; // 自动开启计时

+ (Yodo1AntiAddiction *)shared;

/// 初始化
- (void)init:(NSString *)appKey delegate: (id<Yodo1AntiAddictionDelegate>)delegate;
- (void)init:(NSString *)appKey regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiAddictionDelegate>)delegate;
- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiAddictionDelegate>)delegate;

/// 开启计时, 如果当前正在计时中则会忽略
- (void)startTimer;
/// 停止计时，同时会上报时间
- (void)stopTimer;
/// 是否正在计时
- (BOOL)isTimer;

- (BOOL)isGuestUser;

/// 验证玩家防沉迷信息
/// accountId 玩家账号ru
/// 如果 autoTimer == YES游客及未成年会自动开启计时
- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure;

///是否已限制消费
/// money 单位: 分
/// [data[@"hasLimit"] boolValue] == true // 已被限制消费
/// data[@"alertMsg"]  // 提示文字
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure;

///上报消费信息 - 支付信息&商品信息
/// receipt.money 商品金额, 单位分
- (void)reportProductReceipt:(Yodo1AntiAddictionProductReceipt *)receipt success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure;

@end



NS_ASSUME_NONNULL_END
