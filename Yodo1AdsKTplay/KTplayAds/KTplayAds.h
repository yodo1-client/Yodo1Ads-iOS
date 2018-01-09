//
//  KTplayAds.h
//  KTplayAds
//
//  Created by xingbin on 2017/5/31.
//  Copyright © 2017年 mengyou. All rights reserved.
//

#import <UIKit/UIKit.h>




typedef NS_ENUM(NSInteger, KTplayAdsPreloadType) {
    
    KTplayAdsPreloadTypeAll=0, //预加载插屏广告和视频广告
    KTplayAdsPreloadTypeInterstitialAd, //预加载插屏广告
    KTplayAdsPreloadTypeVideoAd, //预加载视频广告
    KTplayAdsPreloadTypeNull //不预加载
    
    
    
};


typedef NS_ENUM(NSInteger, KTplayAdsVideoEvent) {
    
    kKTplayAdsVideoEventError,
    
    kKTplayAdsVideoEventSkipped,
    
    kKTplayAdsVideoEventCompleted
};

@protocol KTplayAdsInterstitialDelegate <NSObject>

@optional

/*
 插屏广告将要显示
 */

- (void)interstitialAdWillShow;




- (void)interstitialAdStatusChanged:(BOOL)isInterstitialAdReady;




- (void)interstitialAdClosed;




@end



@protocol KTplayAdsVideoDelegate <NSObject>

@optional



/*
 视频广告将要显示
 */

- (void)videoAdWillShow;



/*
 视频广告缓存状态变更
 */


- (void)videoAdStatusChanged:(BOOL)isVideoAdReady;



/*
 关闭视频广告
 */
- (void)videoAdClosed:(KTplayAdsVideoEvent)event;



@end




@interface KTplayAds : NSObject



/*
 初始化,初始化后SDK会根据preLoadType来确认预加载类型
 */

+(void)startWithAppKey:(NSString *)appKey preLoadType:(KTplayAdsPreloadType)preLoadType;


/*
 插屏广告数据是否已经准备好 ，注意：调用时如果本地没有插屏广告数据，本次调用会自动请求插屏广告数据。
 */


+(BOOL)isInterstitialAdReady;


/*
 显示插屏广告 ，注意：调用时如果本地没有插屏广告数据，本次调用仅会请求插屏广告数据，并不会显示插屏广告。插屏广告关闭后会自动请求新的插屏广告数据，。
 */

+(void)showInterstitialAd;


/*
 视频广告数据是否已经准备好 ，注意：调用时如果本地没有视频广告数据，本次调用会自动请求视频广告数据。
 */


+(BOOL)isVideoAdReady;


/*
 显示视频广告，注意：调用时如果本地没有视频广告数据，本次调用仅会请求视频逛数据，并不会显示视频广告。视频广告关闭后会自动请求新的视频广告数据，。
 */

+(void)showVideoAd;


+(void)setInterstitialDelegate:(id<KTplayAdsInterstitialDelegate>)delegate;

+(void)setVideoDelegate:(id<KTplayAdsVideoDelegate>)delegate;




@end
