//
//  AdCompNativeAd.h
//  KuaiYouAdHello
//
//  Created by maming on 15/10/22.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AdCompNativeData : NSObject
/*
 * 广告内容字典
 * 详解：开发者调用loadNativeAdWithCount:成功之后返回广告内容，
 *       从该属性中获取以字典形式存储的广告数据
 */
@property (nonatomic, strong) NSDictionary *adProperties;

@end

@protocol AdCompNativeAdDelegate <NSObject>

/*
 * 原⽣广告加载广告数据成功回调
 * @param nativeDataArray 为 AdCompNativeData 对象的数组，即广告内容数组
 */
- (void)adCompNativeAdSuccessToLoadNativeData:(NSArray*)nativeDataArray;

/*
 * 原⽣广告加载广告数据失败回调
 * @param error 为加载失败返回的错误信息
 */
- (void)adCompNativeAdFailToLoadWithError:(NSError*)error;

/*
 * 原⽣广告后将要展示内嵌浏览器回调
 */
- (void)adCompNativeAdWillShowPresent;

/*
 * 原⽣广告点击后，内嵌浏览器被关闭时回调
 */
- (void)adCompNativeAdClosed;

/*
 * 原⽣广告点击之后应用进入后台时回调
 */
- (void)adCompNativeAdResignActive;

@end

@interface AdCompNativeAd : NSObject
@property (nonatomic, weak) id<AdCompNativeAdDelegate> delegate;
/*
 * viewControllerForPresentingModalView
 */
@property (nonatomic, strong) UIViewController *controller;

/*
 * 初始化方法
 * @param appkey 为应用id
 * @param positionID 为广告位id
 */
- (instancetype)initWithAppKey:(NSString*)appkey positionID:(NSString*)positionID;

/*
 * 广告加载方法
 * @param count 一次请求广告的个数
 */
- (void)loadNativeAdWithCount:(int)count;

/*
 * 广告view渲染完毕后即将展示调用方法（用于发送相关汇报）
 * @param nativeData 渲染广告的数据对象
 * @param view 渲染出的广告页面
 */
- (void)showNativeAdWithData:(AdCompNativeData*)nativeData onView:(UIView*)view;

/*
 * 广告点击调用的方法
 * 当⽤户点击广告时,开发者需调用本方法,sdk会做出相应响应（用于发送点击汇报）
 * @param nativeData 被点击的广告的数据对象
 */
- (void)clickNativeAdWithData:(AdCompNativeData*)nativeData;

@end
