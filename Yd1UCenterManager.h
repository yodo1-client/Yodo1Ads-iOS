//
//  Yd1UCenterManager.h
//
//  Created by yixian huang on 2017/7/24.
//
//

#ifndef Yd1UCenterManager_h
#define Yd1UCenterManager_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    PaymentCannel = 0,      //取消支付
    PaymentSuccess,         //支付成功
    PaymentFail,            //支付失败
    PaymentValidationFail   //ops 验证失败
}PaymentState;

typedef enum {
    Default = 0,
    Visible,
    Hide
}PromotionVisibility;

typedef enum {
    NonConsumables = 0,//不可消耗
    Consumables,//可消耗
    Auto_Subscription,//自动订阅
    None_Auto_Subscription//非自动订阅
}ProductType;

@class Product;

typedef void (^PaymentCallback) (NSString *uniformProductId,NSString* orderId,NSString* channelOrderid,PaymentState paymentState,NSString* response);
typedef void (^RestoreCallback)(NSArray *productIds,NSString* response);
typedef void (^LossOrderCallback)(NSArray *productIds,NSString* response);
typedef void (^FetchStorePromotionOrderCallback) (NSArray<NSString *> *  storePromotionOrder, BOOL success, NSString*  error);
typedef void (^FetchStorePromotionVisibilityCallback) (PromotionVisibility storePromotionVisibility, BOOL success, NSString*  error);
typedef void (^UpdateStorePromotionOrderCallback) (BOOL success, NSString*  error);
typedef void (^UpdateStorePromotionVisibilityCallback)(BOOL success, NSString*  error);
typedef void (^ProductsInfoCallback) (NSArray<Product*> *productInfo);

/**
 *@brief
 *  查询订阅信息接口
 *@param success YES查询订阅信息成功，NO查询订阅信息失败。
 *@param subscriptions 订阅信息
 *@param serverTime 当前服务器时间
 *@error 错误信息
 */
typedef void (^QuerySubscriptionCallback)(NSArray* subscriptions, NSTimeInterval serverTime, BOOL success,NSString* _Nullable error);

@interface Product : NSObject
@property (nonatomic, strong) NSString* uniformProductId;
@property (nonatomic, strong) NSString* channelProductId;
@property (nonatomic, strong) NSString* productName;
@property (nonatomic, strong) NSString* productPrice;
@property (nonatomic, strong) NSString* priceDisplay;
@property (nonatomic, strong) NSString* productDescription;
@property (nonatomic, strong) NSString* currency;
@property (nonatomic, assign) ProductType productType;
///订阅时间: 每周，每月，每年,每2个月...
@property (nonatomic, strong) NSString* periodUnit;
- (instancetype)initWithDict:(NSDictionary*)dictProduct
                   productId:(NSString*)uniformProductId;
@end

@class YD1User;

@interface Yd1UCenterManager : NSObject

+ (instancetype)shared;

@property (nonatomic,assign)__block BOOL isLogined;
@property (nonatomic,strong)__block YD1User* user;

/**
 * 购买产品
 */
- (void)paymentWithUniformProductId:(NSString *)uniformProductId
                           callback:(PaymentCallback)callback;

/**
 *  恢复购买
 */
- (void)restorePayment:(RestoreCallback)callback;

/**
 *  查询漏单
 */
- (void)queryLossOrder:(LossOrderCallback)callback;

/**
 *  查询订阅
 */
- (void)querySubscriptions:(BOOL)excludeOldTransactions
                  callback:(QuerySubscriptionCallback)callback;

/**
 *  获取产品信息
 */
- (void)productWithUniformProductId:(NSString*)uniformProductId
                           callback:(ProductsInfoCallback)callback;

/**
 *  获取所有产品信息
 */
- (void)products:(ProductsInfoCallback)callback;

/**
 *  获取促销订单
 */
- (void)fetchStorePromotionOrder:(FetchStorePromotionOrderCallback) callback;

/**
 *  获取促销活动订单可见性
 */
- (void)fetchStorePromotionVisibilityForProduct:(NSString*)uniformProductId
                                       callback:(FetchStorePromotionVisibilityCallback)callback;
/**
 *  更新促销活动订单
 */
- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray
                         callback:(UpdateStorePromotionOrderCallback)callback;

/**
 *  更新促销活动可见性
 */
- (void)updateStorePromotionVisibility:(BOOL)visibility
                               product:(NSString*)uniformProductId
                              callback:(UpdateStorePromotionVisibilityCallback)callback;

/**
 *  准备继续购买促销
 */
- (void)readyToContinuePurchaseFromPromot;

/**
 *  取消购买
 */
- (void)cancelPromotion;

/**
 *  获取促销产品
 */
- (Product*)promotionProduct;

@end

NS_ASSUME_NONNULL_END
#endif /* Yd1UCenterManager_h */
