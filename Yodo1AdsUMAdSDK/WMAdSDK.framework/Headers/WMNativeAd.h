//
//  WMNativeAd.h
//  WMAdSDK
//
//  Created by chenren on 18/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "WMAdSlot.h"
#import "WMMaterialMeta.h"

@protocol WMNativeAdDelegate;

NS_ASSUME_NONNULL_BEGIN


/**
 抽象的广告位，包含广告数据加载， 展示，响应
 */
@interface WMNativeAd : NSObject

/**
 广告位的描述说明， 目前Native广告支持信息流 插屏 Banner广告位，暂不支持开屏
 */
@property (nonatomic, strong, readwrite, nullable) WMAdSlot *adslot;

/**
 广告位的素材资源
 */
@property (nonatomic, strong, readonly, nullable) WMMaterialMeta *data;

/**
 广告位加载 展示 响应的回调
 */
@property (nonatomic, weak, readwrite, nullable) id<WMNativeAdDelegate> delegate;

/**
 创建一个Native广告的推荐构造函数

 @param slot 广告位描述信息
 @return Native广告位
 */
- (instancetype)initWithSlot:(WMAdSlot *)slot;

// 广告类与view相关联绑定，注册具体事件，比如跳转页面、打电话、下载，行为由SDK控制，不建议使用，比如有可能注册电话事件但实际没有电话信息
- (void)registerViewForInteraction:(UIView *)view
               withInteractionType:(WMInteractionType)interactionType
                withViewController:(UIViewController *)viewController;

// 广告类与view相关联绑定，注册交互事件并使用默认内置的广告属性，行为由SDK控制
- (void)registerViewForInteraction:(UIView *_Nullable)view
                withViewController:(UIViewController *_Nullable)viewController;

// 广告类与一组可点击view相关联绑定，注册交互事件并使用默认内置的广告属性，行为由SDK控制，具体到view的子view
- (void)registerViewForInteraction:(UIView *)view
                withViewController:(UIViewController *_Nullable)viewController
                withClickableViews:(NSArray<UIView *> *_Nullable)clickableViews;

// 广告类与view相关联绑定，注册交互事件并在回调代理（一般是VC）中处理相应事件，行为由用户控制
- (void)registerViewForCustomInteraction:(UIView *)view
                      withViewController:(UIViewController *_Nullable)viewController;

// 广告类解除和view的绑定
- (void)unregisterView;

/**
 主动 请求广告数据
 */
- (void)loadAdData;

@end


@protocol WMNativeAdDelegate <NSObject>

@optional

/**
 nativeAd 网络加载成功
 @param nativeAd 加载成功
 */
- (void)nativeAdDidLoad:(WMNativeAd *)nativeAd;

/**
 nativeAd 出现错误
 @param nativeAd 错误的广告
 @param error 错误原因
 */
- (void)nativeAd:(WMNativeAd *)nativeAd didFailWithError:(NSError *_Nullable)error;

/**
 nativeAd 即将进入可是区域
 @param nativeAd 广告位即将出现在可视区域
 */
- (void)nativeAdDidBecomeVisible:(WMNativeAd *)nativeAd;

/**
 nativeAd 被点击

 @param nativeAd 被点击的 广告位
 @param view 被点击的视图
 */
- (void)nativeAdDidClick:(WMNativeAd *)nativeAd withView:(UIView *_Nullable)view;

@end

NS_ASSUME_NONNULL_END
