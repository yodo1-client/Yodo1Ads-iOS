//
//  Yodo1NetGameManager.h
//  NetGameSDK_Sample
//
//  Created by yodo1 on 14-5-20.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Yodo1Membership.h"
#import "Yodo1OGPayment.h"
#import "Yodo1Types.h"
#import "AppStoreProduct.h"

@interface ProductInfo : NSObject

/**@brief 程序用户用的产品id */
@property (nonatomic, copy) NSString* uniformProductId;
/**@brief 渠道产品id:比如91的产品id，AppStore的产品 */
@property (nonatomic, copy) NSString* channelProductId;
/**@brief 产品名字 */
@property (nonatomic, copy) NSString* productName;
/**@brief 产品价格 */
@property (nonatomic, copy) NSString* productPrice;
/**@brief 显示价格:￥6:00 */
@property (nonatomic, copy) NSString* priceDisplay;
/**@brief 产品描述 */
@property (nonatomic, copy) NSString* productDescription;
/**@brief 货币类型 */
@property (nonatomic, copy) NSString* currency;
/**@brief 是否为消耗品 */
@property (nonatomic, assign) ProductType productType;

@end

#pragma mark  Payment


/**
 *@brief
 *  查询promotion order回调
 *@param storePromotionOrder 产品排序（unitformProdcutID排序）
 *@param error 错误信息
 */
typedef void (^FetchStorePromotionOrderCompletionBlock) (NSArray<NSString *> *  storePromotionOrder, BOOL success, NSString*  error);

/**
 *@brief
 * 查询promotion
 *@param storePromotionVisibility  显示状态回调
 *@param success 是否显示
 *@param error 错误信息
 */
typedef void (^FetchStorePromotionVisibilityCompletionBlock) (Yodo1PromotionVisibility storePromotionVisibility, BOOL success, NSString*  error);

/**
 *@brief
 *  更新promotion order回调
 *@param success 是否成功
 *@param error 错误信息
 */
typedef void (^UpdateStorePromotionOrderCompletionBlock) (BOOL success, NSString*  error);

/**
 *@brief
 *  更新promotion 显示状态回调
 *@param success 是否成功
 *@param error 错误信息
 */
typedef void (^UpdateStorePromotionVisibilityCompletionBlock)(BOOL success, NSString*  error);

/**
 *@brief 
 *  渠道支付接口回调方法
 *@param paymentState 支付状态
 *@param uniformProductId 产品ID
 *@param response 返回信息
 *@response 服务端返回的JSON字符串
 *@param extra 保留的字段信息
 */
typedef void (^PaymentCompletionBlock) (NSString *uniformProductId,PaymentState paymentState,NSString* response, NSString* extra);

/**
 *@brief 
 *  查询漏单接口、AppsStore恢复购买回调方法
 *@param success YES查询漏单成功，NO查询漏单失败。
 *@param productIds 产品IDs
 *@param lossOrderType 查询漏单LossOrderType查询类型
 *@response 服务端返回的JSON字符串
 */
typedef void (^LossOrderCompletionBlock)(NSArray *productIds,BOOL success,LossOrderType lossOrderType,NSString* response);


/**
 *@brief
 *  查询订阅信息接口
 *@param success YES查询订阅信息成功，NO查询订阅信息失败。
 *@param subscriptions 订阅信息
 *@param serverTime 当前服务器时间
 *@error 错误信息
 */
typedef void (^QuerySubscriptionBlock)(NSArray* subscriptions, NSTimeInterval serverTime, BOOL success,NSString* error);


/**
 *@brief
 *  查询产品信息
 *@param uniformProductId 产品ID
 *@param productInfo 返回产品信息
 */
typedef void (^ProductInfoCompletionBlock) (NSString *uniformProductId,ProductInfo *productInfo);

/**
 *@brief
 *  查询产品所有信息
 *@param productInfo 返回所有产品信息（ProductInfo对象）
 */
typedef void (^ProductsInfoCompletionBlock) (NSArray *productInfo);

#pragma mark  UCenter
/**
 *@brief
 *  登录回调方法
 *@param loginState 登录状态
 *@response 服务端返回的JSON字符串
 */
typedef void (^LoginUCenterCompletionBlock) (UCenterLoginState loginState,NSString* response);

/**
 *@brief
 *  退出登录回调方法
 */
typedef void (^LoginOutUCenterCompletionBlock) ();

/**
 *@brief
 *  获取分区列表回调方法
 *@param success YES获取成功，NO获取失败。
 *@param error 获取分区列表失败时返回的错误信息,获取分区列表成功时为nil
 *@param regionList 分区列表
 */
typedef void (^RegionListUCenterCallback)(BOOL success,NSArray* regionList,NSError* error);

/**
 *@brief
 *  获取版本信息回调方法
 *@param success YES获取成功，NO获取失败。
 *@param error 返回错误信息
 *@param response 服务端返回的JSON字符串
 */
typedef void (^GetUpdateInfoUCenterCallback)(BOOL success,NSError* error,NSString* response);

/**
 *@brief
 *  注册接口回调方法
 *@param success YES注册成功，NO注册失败。
 *@param authorization 注册成功时返回的UC用户授权信息，注册失败时为nil。
 *@param error 注册失败时返回的错误信息,注册成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^RegisterUCenterWithUsernameCallback)(BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 *@brief
 * 登录接口回调方法
 *@param loginState 登录状态
 *@param authorization 登陆成功时返回的UC用户授权信息，登陆失败时为nil
 *@param error 登陆失败时返回的错误信息,登陆成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^LoginUCenterWithUsernameCallback)(UCenterLoginState loginState,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);


/**
 *@brief
 *  渠道用户登陆接口回调方法
 *@param success YES登录成功，NO登录失败。
 *@param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 *@param error 登陆失败时返回的错误信息,登陆成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^LoginUCenterWithChannelUserCallback)(BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 *@brief
 *  渠道登陆回调方法
 *@param success YES登录成功，NO登录失败。
 *@param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 *@param error 登陆失败时返回的错误信息,登陆成功时为nil
 *@param response 服务端返回内容
 */
typedef void (^LoginUCenterWithChannelUserBindCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 *@brief
 *  设备ID登陆回调方法
 *@param success YES登录成功，NO登录失败。
 *@param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 *@param error 登陆失败时返回的错误信息,登陆成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^LoginUCenterWithChannelUserDeviceIdCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 *@brief
 *  转换设备用户回调方法
 *@param success YES转换成功，NO转换失败。
 *@param error 转换设备用户错误信息,转换成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^UCenterDeviceUserConvertCallback) (BOOL success,NSError* error,NSString* response);

/**
 *@brief
 *  回调方法:转换设备用户为SNS用户
 *@param success YES转换成功，NO转换失败。
 *@param error 转换设备用户错误信息,转换成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^UCenterDeviceUserConvertToSNSUserCallback) (BOOL success,NSError* error,NSString* response);

/**
 *@brief
 *  SNS登陆回调方法
 *@param success YES登录成功，NO登录失败。
 *@param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 *@param error 登陆失败时返回的错误信息,登陆成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^SNSLoginUCenterCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 *@brief
 *  回调方法:用devceId 替换用户名密码的用户id
 *@param success YES替换成功，NO替换失败。
 *@param error 替换uid错误信息,转换成功时为nil
 *@response 服务端返回的JSON字符串
 */
typedef void (^UCenterChangeIdCallback) (BOOL success,NSError* error,NSString* response);

@class Yodo1Adapter;

@interface UCenterManager : NSObject
/**@brief UC用户注册回调*/
@property (nonatomic,copy) RegisterUCenterWithUsernameCallback registerCompletionBlock;
/**@brief UC用户登录回调*/
@property (nonatomic,copy) LoginUCenterWithUsernameCallback loginWithUsernameCompletionBlock;
/**@brief UC渠道用户登录回调*/
@property (nonatomic,copy) LoginUCenterWithChannelUserCallback loginWithChannelUserCompletionBlock;
/**@brief 渠道登陆回调*/
@property (nonatomic,copy) LoginUCenterWithChannelUserBindCallback loginWithChannelUserBindCompletionBlock;
/**@brief 设备ID登陆回调*/
@property (nonatomic,copy) LoginUCenterWithChannelUserDeviceIdCallback loginWithChannelUserDeviceIdCompletionBlock;
/**@brief 转换设备用户回调*/
@property (nonatomic,copy) UCenterDeviceUserConvertCallback deviceUserConvertCompletionBlock;
/**@brief 转换设备用户为SNS用户回调*/
@property (nonatomic,copy) UCenterDeviceUserConvertToSNSUserCallback deviceUserConvertToSNSUserCompletionBlock;
/**@brief 退出登录回调*/
@property (nonatomic,copy) LoginOutUCenterCompletionBlock loginOutCompletionBlock;
/**@brief 用deviceId替换有用户名和密码的用户id回调*/
@property (nonatomic,copy) UCenterChangeIdCallback changeIdBlock;
/**@brief 替换用户名密码的用户id回调*/
@property (nonatomic,copy) UCenterChangeIdCallback transferIdBlock;
/**@brief Yodo1Adapter实例*/
@property (nonatomic,retain) Yodo1Adapter* currentAdapter;
/**@brief SNS登陆回调*/
@property (nonatomic,copy) SNSLoginUCenterCallback snsLoginCompletionBlock;
/**@brief 渠道支付接口回调*/
@property (nonatomic,copy) PaymentCompletionBlock paymentCompletionBlock;
/**@brief 查询漏单、恢复购买回调*/
@property (nonatomic,copy) LossOrderCompletionBlock lossOrderCompletionBlock;
/**@brief 查询订阅信息回调*/
@property (nonatomic, copy) QuerySubscriptionBlock  querySubscriptionBlock;
/**@brief Yodo1每个项目游戏唯一的appkey*/
@property (nonatomic,copy) NSString* appKey;
/**@brief UC用户id */
@property (nonatomic,copy) NSString* yodo1UCUid;
/**@brief UC用户名*/
@property (nonatomic,copy) NSString* yodo1UCUserName;
/**@brief 游戏用户id*/
@property (nonatomic,copy) NSString* gameUserId;
/**@brief 游戏用户昵称*/
@property (nonatomic,copy) NSString* gameNickname;
/**@brief 渠道id*/
@property (nonatomic,copy) NSString* channelId;
/**@brief 游戏分区码*/
@property (nonatomic,retain) NSString* gameRegionCode;
/**@brief 设备id*/
@property (nonatomic,copy) NSString* deviceId;
/**@brief 保留数据字段*/
@property (nonatomic,copy) NSString* extra;
/**@brief 是否登录*/
@property (nonatomic,assign) BOOL bLogined;
/**@brief 查询Promotion Order回调*/
@property (nonatomic,copy) FetchStorePromotionOrderCompletionBlock  fetchStorePromotionOrderCompletionBlock;
/**@brief 查询Promotion Visibility回调*/
@property (nonatomic,copy) FetchStorePromotionVisibilityCompletionBlock  fetchStorePromotionVisibilityCompletionBlock;
/**@brief 更新Promotion Order回调*/
@property (nonatomic,copy) UpdateStorePromotionOrderCompletionBlock  updateStorePromotionOrderCompletionBlock;
/**@brief 查询Promotion Visibility回调*/
@property (nonatomic,copy) UpdateStorePromotionVisibilityCompletionBlock  updateStorePromotionVisibilityCompletionBlock;

/**
 *  UCenterManager的单例
 *
 *  @return UCenterManager实例
 */
+ (UCenterManager*)sharedInstance;

/**
 *   打开/关闭日志功能,默认为关。
 *
 *  @param enable YES打开，NO关闭
 */
- (void)setLogEnabled:(BOOL)enable;

/**
 *   设置ops支付验证环境,默认为生产环境。
 *
 *  @param env UCenterEnvironmentProduction
 */
- (void)setAPIEnvironment:(UCenterEnvironment)env;

#pragma mark UCenter登录

/**
 *  检测是不是UC SNS授权登录区别于kt或Yodo1 SNS授权分享
 *
 *  @return YES UC的SNS授权，NO不是UC的SNS授权
 */
- (BOOL)isUCAuthorzie;

/**
 *  获取在线分区列表
 *
 *  @param channelCode     渠道Code比如AppStore,91
 *  @param gameAppkey      Yodo1每个项目游戏唯一的appkey
 *  @param regionGroupCode 分区组Code OPS后台设置
 *  @param env             UCenterEnvironmentTest测试环境，UCenterEnvironmentProduction生产环境
 *  @param callback        回调
 */
- (void)regionList:(NSString*)channelCode
         gameAppkey:(NSString*)gameAppkey
    regionGroupCode:(NSString*)regionGroupCode
       environment:(UCenterEnvironment)env
          callback:(RegionListUCenterCallback)callback;

/**
 *  获取版本更新信息
 *
 *  @param gameAppkey  Yodo1每个项目游戏唯一的appkey
 *  @param channelCode 渠道Code比如AppStore,91
 *  @param callback    获取版本更新信息回调GetUpdateInfoUCenterCallback
 */
- (void)getUpdateInfoWithAppKey:(NSString*)gameAppkey
                    channelCode:(NSString*)channelCode
                       callback:(GetUpdateInfoUCenterCallback)callback;

/**
 *UC账号注册
 *
 *  @param username uc用户名
 *  @param pwd      uc用户密码
 *  @param callback 回调
 */
- (void)registUsername:(NSString*)username
                   pwd:(NSString*)pwd
              callback:(RegisterUCenterWithUsernameCallback)callback;

/**
 *  UC登录
 *
 *  @param usertype 用户登录类型
 *  @param username 用户名或是设备id或是sns登录的类型sina_weibo,qq
 *  @param pwd      用户密码
 *  @param callback 回调
 */
- (void)login:(UCenterUserType)usertype
     username:(NSString*)username
          pwd:(NSString*)pwd
     callback:(LoginUCenterWithUsernameCallback)callback;

/**
 *设备账号转换
 *
 *  @param username 用户名
 *  @param pwd      用户密码
 *  @param callback 回调
 */
- (void)converDeviceToNormal:(NSString*)username
                         pwd:(NSString*)pwd
                    callback:(UCenterDeviceUserConvertCallback)callback;

/**
 *  仍使用传入的user_id作为deviceId代表用户的存档数据的user_id，并将此存档变更为use的主帐号，原有device的存档被删除
 *  用户再次登录时取到的user_id不变，但是对应的存档是device_id对应的存档，原存档已经删除了（如分区信息等）
 *  device_id再次登录是取到的存档是全新的
 *
 *  @param replacedUserId 用户id
 *  @param deviceId       设备id
 *  @param callback       回调
 */
- (void)replaceContentOfUserId:(NSString *)replacedUserId
                      deviceId:(NSString *)deviceId
                      callback:(UCenterChangeIdCallback)callback;

/**
 *  将deviceId代表用户的存档的主帐号变更为user_id代表的帐号，user_id本身的数据被删除，替换的数据包括user_id本身
 *  用户再次登录时取到的user_id是操作前deviceId对应的user_id，原user_id已经删除了
 *  deviceId再次登录是取到的user_id是全新的
 *
 *  @param transferedUserId 用户id
 *  @param deviceId         设备id
 *  @param callback         回调
 */
- (void)transferWithDeviceUserId:(NSString *)transferedUserId
                        deviceId:(NSString *)deviceId
                        callback:(UCenterChangeIdCallback)callback;

/**
 *  设置UCenter退出登录的回调
 *
 *  @param callback UCenter退出登录时的回调
 */
+ (void)setUCenterLoginOutCallback:(LoginOutUCenterCompletionBlock)callback;

/**
 *注销退出:先设置UCenter退出登录时的回调(setUCenterLoginOutCallback)
 */
- (void)loginOut;


#pragma mark- Payment支付

/**
 *  设置Payment支付的回调
 *
 *  @param callback Payment支付时的回调
 */
+ (void)setPaymentCallback:(PaymentCompletionBlock)callback;

/**
 *  设置游戏用户id
 *
 *  @param gameUserId 游戏用户id
 */
- (void)gameUserId:(NSString*)gameUserId;

/**
 *  游戏用户昵称
 *
 *  @param gameNickname 游戏用户id
 */
- (void)gameNickname:(NSString*)gameNickname;


/**
 *  AppStore支付,调用这个接口之前先设置setPaymentCallback回调
 *
 *  @param uniformProductId 产品id 在ConfigKey.h里面定义
 *  @param extra            支付保留字段（可选）
 */
- (void)paymentWithProductId:(NSString *)uniformProductId
                       extra:(NSString *)extra;

/**
 *  设置Payment查询漏单、AppsStore恢复购买的回调
 *
 *  @param callback Payment查询漏单时的回调
 */
+ (void)setLossOrderCallback:(LossOrderCompletionBlock)callback;

/**
 *  查询漏单:先设置Payment查询漏单回调(setQueryLossOrderBlock)
 */
- (void)queryLossOrder;


/**
 *  查询订阅信息
 *  先设置恢复购买回调(setQuerySubscriptionBlock)
 * @param excludeOldTransactions 是否排除老旧交易
 */
- (void)querySubscriptions:(BOOL)excludeOldTransactions;

/**
 *  设置查询订阅信息的回调
 *
 *  @param callback 查询订阅信息的回调
 */
+ (void)setQuerySubscriptionBlock:(QuerySubscriptionBlock)callback;

/**
 *  AppStore渠道，恢复购买
 *  先设置恢复购买回调(setRestorePaymentBlock)
 */
- (void)restorePayment;


- (AppStoreProduct*)GetPromotionProduct;

/**
 *  准备好继续promot的购买行为
 */
- (void)ReadyToContinuePurchaseFromPromot;


/**
 *  根据产品ID,获取产品信息
 *
 *  @param uniformProductId 产品id 在ConfigKey.h里面定义
 *  @param callback         回调
 */
- (void)productInfoWithProductId:(NSString*)uniformProductId
                        callback:(ProductInfoCompletionBlock)callback;

/**
 *  获取所有产品ID信息
 *  @param callback         回调
 */
- (void)productsInfo:(ProductsInfoCompletionBlock)callback;

/**
 *  处理回调：有些平台支付回调,比如PP助手支付宝回调
 *
 *  @param url               AppDelegate的openURL方法中传入的url，直接使用。
 *  @param sourceApplication AppDelegate的参数，直接传入，没有可以传入nil
 */
- (void)handleOpenURL:(NSURL*)url
    sourceApplication:(NSString*)sourceApplication;


/**
 *  查询promotion排序,首先设置回调
 */
- (void)fetchStorePromotionOrder;
+ (void)setFetchStorePromotionOrderCallback:(FetchStorePromotionOrderCompletionBlock  )callback;

/**
 *  查询promotion是否显示,首先设置回调
 */
- (void)fetchStorePromotionVisibilityForProduct:(NSString*)uniformProductId;
+ (void)setFetchStorePromotionVisibilityCallback:(FetchStorePromotionVisibilityCompletionBlock  )callback;


- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray;
+ (void)setUpdateStorePromotionOrderCompletionBlock:(UpdateStorePromotionOrderCompletionBlock )callback;

- (void)updateStorePromotionVisibility:(BOOL)visibility Product:(NSString*)uniformProductId;
+ (void)setUpdateStorePromotionVisibilityCompletionBlock:(UpdateStorePromotionVisibilityCompletionBlock )callback;

@end
