//
//  Yodo1Adapter.h
//  NetGameSDK_Sample
//
//  Created by hyx on 14-6-3.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "UCenterManager.h"
#import "Yodo1Commons.h"

@interface Yodo1Adapter : NSObject 

@property (nonatomic,copy) LoginUCenterCompletionBlock loginCompletionBlock;
@property (nonatomic,assign) LoginType currentType;
@property (nonatomic,retain) NSMutableArray* orderIdArray;          //保存订单数组
@property (nonatomic,retain) NSDictionary* productIdDic;            //产品ID个平台信息
@property (nonatomic,assign) int bCreateOrderSucceed;               //创建订单是否成功
@property (nonatomic,retain) NSMutableArray* restoreProductIdArray; //查询恢复的产品ID

/**
 初始化
 */
- (id)initWithType:(LoginType)type orientation:(UIInterfaceOrientation)orientation;

/* 获取当前用户ID
 * \return  返回当前channel用户ID
 */
- (NSString*)channelUserId;

/* 获取当前用户名
 * \return  返回channel当前用户名
 */
- (NSString*)channelUserName;

/* 获取当前用户的SessionId
 * \return 返回当前用户的SessionId
 */
- (NSString*)channelSessionId;

/*
 *显示设置channel用户界面：比如密码管理等
 */
- (void)channelUserView;

/*
 *检查版本更新
 */
- (void)checkAppUpdate;

/*
 *注销退出
 */
- (void)loginOut;

/*
 *是否已经登录
 */
- (BOOL)isLogined;

/*
 *登录
 */
- (void)login:(LoginUCenterCompletionBlock)block;

/*
 显示ToolBar：有些渠道有这个需求
 place是显示的位置
 */
- (void)showToolBar:(ChannelToolBarPlace)place;

/*
 隐藏ToolBar
 */
- (void)hideToolBar;

/**
 处理回调：有些平台支付回调,比如PP助手支付宝回调
 */
- (void)handleOpenURL:(NSURL*)url
            sourceApplication:(NSString*)sourceApplication;

/*
 *支付
 */
- (void)paymentWithProductId:(NSString*)uniformProductId;

/*
 查询漏单
 */
- (void)queryLossOrder;

/*
 查询订阅信息
 @param excludeOldTransactions 是否排除老旧交易
 */
- (void)querySubscriptions:(BOOL)excludeOldTransactions;

/*
 appstore渠道，恢复购买
 */
- (void)restorePayment;

/*
 查询产品信息
 */
- (void)productInfoWithProductId:(NSString*)uniformProductId
                        callback:(ProductInfoCompletionBlock)callback;

/*
 查询产品所有信息
 */
- (void)productsInfo:(ProductsInfoCompletionBlock)callback;

/*
 根据key,存PaymentProduct对象
 key:请求或验证
 */
- (void)savePaymentProducts:(id)products key:(NSString *)key;

/*
 获取PaymentProduct对象
 key:请求或验证
 */
- (id)loadPaymentProducts:(NSString*)key;

- (void)CancelPromotion;

- (AppStoreProduct*)GetPromotionProduct;

- (void)ReadyToContinuePurchaseFromPromot;

- (void)updateStorePromotionVisibility:(BOOL)visibility Product:(NSString*)uniformProductId;

- (void)fetchStorePromotionOrder;

- (void)fetchStorePromotionVisibilityForProduct:(NSString*)uniformProductId;

- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray;

@end
