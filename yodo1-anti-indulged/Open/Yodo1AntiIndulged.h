//
//  Yodo1AntiIndulged.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 统一成功回调
/// return YES 表示游戏自己处理成功逻辑，NO表示由SDK默认处理
typedef BOOL (^Yodo1AntiIndulgedSuccessful)(id _Nullable);
/// 统一错误回调
/// return YES 表示游戏自己处理错误逻辑，NO表示由SDK默认处理
typedef BOOL (^Yodo1AntiIndulgedFailure)(NSError * _Nonnull);

typedef enum: NSInteger {
    Yodo1AntiIndulgedProductTypeNonConsumables = 0,
    Yodo1AntiIndulgedProductTypeConsumables = 1,
    Yodo1AntiIndulgedProductTypeAutoSubscription = 2
} Yodo1AntiIndulgedProductType;

typedef enum: NSInteger {
    Yodo1AntiIndulgedActionResumeGame = 0,
    Yodo1AntiIndulgedActionEndGame = 1
} Yodo1AntiIndulgedAction;

typedef enum: NSInteger {
    Yodo1AntiIndulgedEventCodeNone = 0,
    /**
     * 对于已玩时间的通知-未成年人
     */
    Yodo1AntiIndulgedEventCodeMinorPlayedTime = 11001,
    /**
     * 对于禁玩时段的通知-未成年人
     */
    Yodo1AntiIndulgedEventCodeMinorForbiddenTime = 12001,
    /**
     * 对于已玩时间的通知-游客
     */
    Yodo1AntiIndulgedEventCodeGuestPlayedTime = 11011,
    /**
     * 对于禁玩时段的通知-游客
     */
    Yodo1AntiIndulgedEventCodeGuestForbiddenTime = 12011
} Yodo1AntiIndulgedEventCode;

@interface Yodo1AntiIndulgedEvent : NSObject

@property (nonatomic, assign) Yodo1AntiIndulgedEventCode eventCode;
@property (nonatomic, assign) Yodo1AntiIndulgedAction action;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;

@end

//小票及商品信息组
@interface Yodo1AntiIndulgedProductReceipt : NSObject

@property (nonatomic, retain) NSString *orderId; // 订单编号
@property (nonatomic, retain) NSString *itemCode; // 商品编号
@property (nonatomic, assign) Yodo1AntiIndulgedProductType itemType; // 商品类型
@property (nonatomic, assign) NSInteger money; // 金额 单位分
@property (nonatomic, retain) NSString *region; // 区
@property (nonatomic, retain) NSString *spendDate; // 消费时间
@property (nonatomic, retain) NSString *currency; // 币种（大写） ,示例值(CNY)

@end

@protocol Yodo1AntiIndulgedDelegate <NSObject>

@optional
/// SDK初始化回调
- (void)onInitFinish:(BOOL)result message:(NSString *)message;
/// 游戏通知
/// 返回YES 表示由游戏自己处理通知，否则SDK会使用默认处理方式
- (BOOL)onTimeLimitNotify:(Yodo1AntiIndulgedEvent *)event title:(NSString *)title message:(NSString *)message;

@end

@interface Yodo1AntiIndulged : NSObject

@property (nonatomic, assign) BOOL autoTimer; // 自动开启计时

+ (Yodo1AntiIndulged *)shared;

/// 初始化
- (void)init:(NSString *)appKey delegate: (id<Yodo1AntiIndulgedDelegate>)delegate;
- (void)init:(NSString *)appKey regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiIndulgedDelegate>)delegate;
- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate: (id<Yodo1AntiIndulgedDelegate>)delegate;

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
- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure;

///是否已限制消费
/// money 单位: 分
/// [data[@"hasLimit"] boolValue] == true // 已被限制消费
/// data[@"alertMsg"]  // 提示文字
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure;

///上报消费信息 - 支付信息&商品信息
/// receipt.money 商品金额, 单位分
- (void)reportProductReceipt:(Yodo1AntiIndulgedProductReceipt *)receipt success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure;

@end



NS_ASSUME_NONNULL_END
