//
//  PayManager.h
//  CMBillingTest
//
//  Created by shon wang on 13-7-9.
//  Copyright (c) 2013年 cmgc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Yodo1OGPaymentAPIEnvironmentProduction,
    Yodo1OGPaymentAPIEnvironmentTest
}Yodo1OGPaymentAPIEnvironment;

typedef enum {
    Yodo1OGPaymentOrderStatusOCUnknown,
    Yodo1OGPaymentOrderStatusOCPaySuccess,
    Yodo1OGPaymentOrderStatusOCPayFailure,
    Yodo1OGPaymentOrderStatusOCSyncSuccess,
    Yodo1OGPaymentOrderStatusOCSyncFailure
}Yodo1OGPaymentOrderStatusOC;

@interface Yodo1OGPaymentError : NSObject
/**
 错误代码
 */
@property (nonatomic,assign) long errorCode;
/**
 错误描述
 */
@property (nonatomic,copy) NSString* errorMessage;

@end

typedef void (^CreateOrderCompletionBlock) (BOOL success,Yodo1OGPaymentError* error,NSString* response);
typedef void (^QueryOrderCompletionBlock)(BOOL success,Yodo1OGPaymentOrderStatusOC orderStatus,Yodo1OGPaymentError* error,NSString* response);
typedef void (^CreateSPOrderCompletionBlock)(BOOL success,Yodo1OGPaymentError* error,NSString* response);
typedef void (^VerifyIAPOrderCompletionBlock)(BOOL success,Yodo1OGPaymentError* error,NSString* response);
typedef void (^QuerySubscriptionsCompletionBlock)(BOOL success,Yodo1OGPaymentError* error,NSString* response);

@interface Yodo1OGPayment : NSObject

@property (nonatomic,copy) CreateOrderCompletionBlock createOrderCompletionBlock;
@property (nonatomic,copy) QueryOrderCompletionBlock queryOrderCompletionBlock;
@property (nonatomic,copy) CreateSPOrderCompletionBlock createSPOrderCompletionBlock;
@property (nonatomic,copy) VerifyIAPOrderCompletionBlock verifyIAPOrderCompletionBlock;

+ (Yodo1OGPayment*)sharedInstance;

/**
 创建订单
 @param userId 用户ID，必填。
 @param orderId 订单ID，必填。
 @param itemCode 订单物品编号，必填。
 @param extra 保留字段，根据Server端需要决定是否填写，填写什么内容。注意：短代支付时，必须填写此字段。
 @param appkey 游戏APPKEY，必填。
 @param channelId 渠道号，必填。
 @param gameRegionCode 游戏分区代码，必填。
 @param callback 回调方法。
 */
- (void) createOrder:(NSString *)userId
             orderId:(NSString *)orderId
            itemCode:(NSString *)itemCode
               extra:(NSString *)extra
              appkey:(NSString *)appkey
           channelId:(NSString *)channelId
      gameRegionCode:(NSString *)gameRegionCode
     completionBlock:(CreateOrderCompletionBlock)callback;

/**
 查询订单状态
 @param orderId 订单ID，必填。
 @param callback 查询回调方法
 */
- (void) queryOrder:(NSString *)orderId completionBlock:(QueryOrderCompletionBlock)callback;

/**
 查询订阅状态
 @param appkey 游戏APPKEY
 @param channelId   渠道号
 @param callback 查询回调方法
 @param excludeOldTransactions 是否排除旧交易
 */
- (void) querySubscriptionsWithAppkey:(NSString *)appkey
                            channelId:(NSString *)channelId
               excludeOldTransactions:(BOOL)excludeOldTransactions
                      completionBlock:(QuerySubscriptionsCompletionBlock)callback;

/**
 创建运营商（短信代收）订单。
 @param orderId 订单ID，必填。
 @param spCode SP代码，必填。
 @param amount 支付金额，必填。
 @param extra 保留字段，根据Server端需要决定是否填写，填写什么内容。
 @param appkey 游戏APPKEY，必填。
 @param channelId 渠道号，必填。
 @param gameRegionCode 游戏分区代码，必填。
 @param callback 回调方法。
 */
- (void) createSPOrder:(NSString *)orderId
                spCode:(NSString *)spCode
                amount:(NSString *)amount
                 extra:(NSString *)extra
                appkey:(NSString *)appkey
             channelId:(NSString *)channelId
        gameRegionCode:(NSString *)gameRegionCode
       completionBlock:(CreateSPOrderCompletionBlock)callback;

/**
 验证AppStore IPA订单合法性
 @param userId 用户ID，必填。
 @param nickname 用户昵称，选填，如果有用户昵称就上传。
 @param ucuid uc用户ID，可选。
 @param deviceid 设备id，可选。
 @param orderId 订单ID，必填。
 @param itemCode 订单物品编号，必填。
 @param amount 支付金额，必填。
 @param currencyCode 币种，必填
 @param trxReceipt AppStore IPA成功后返回的订单回执 （BASE64字符串）,必填。
 @param extra 保留字段，根据Server端需要决定是否填写，填写什么内容。
 @param appkey 游戏APPKEY，必填。
 @param gameRegionCode 游戏分区代码，必填。
 @param callback 回调方法。
 */
- (void) verifyAppStoreIAPOrder:(NSString *)userId
                       nickname:(NSString *)nickname
                          ucuid:(NSString *)ucuid
                       deviceid:(NSString *)deviceid
                        orderId:(NSString *)orderId
                       itemCode:(NSString *)itemCode
                         amount:(NSString *)amount
                   currencyCode:(NSString *)currencyCode
                     trxReceipt:(NSString *)trxReceipt
                          extra:(NSString *)extra
                         appkey:(NSString *)appkey
                      channelId:(NSString *)channelId
                 gameRegionCode:(NSString *)gameRegionCode
                    productType:(NSString *)productType
                completionBlock:(VerifyIAPOrderCompletionBlock)callback;
/*
@progam env 1表示测试环境，0表示生产环境
*/
- (void)setYodo1APIEnvironment:(Yodo1OGPaymentAPIEnvironment)env;

/**
打开/关闭日志功能,默认为关。
@param enable 是否打开日志功能
*/
- (void) setYodo1LogEnabled:(BOOL)enable;

/**
 打开/关闭异步连网功能(多线程)，默认为开。
 异步连网功能打开时，网络返回数据的回调方法会在连网线程中执行，游戏需要自己处理主线程/子线程之间的切换。
 @param async 是否打开异步连网功能
 */
- (void) setYodo1AsyncConnections:(BOOL) async;

@end
