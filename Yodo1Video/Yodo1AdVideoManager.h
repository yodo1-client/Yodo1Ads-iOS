//
//  Yodo1AdVideoManager.h
//  Yodo1Ads
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Yodo1AdVideoManager : NSObject

/**
 *  返回Yodo1AdVideoManager的实例
 */
+ (Yodo1AdVideoManager*)sharedInstance;

/**
 *  初始化视频广告sdk，需要先设置各家广告的key
 */
- (void)initAdVideoSDK;

/**
 *  检测是否有视频可以播放
 *
 *  @return YES有广告，NO没有广告。
 */
- (BOOL)hasAdVideo;

/**
 *  显示视频广告
 *
 *  @param controller 为RootViewController
 *  @param block      回调
 */
- (void)showAdVideo:(UIViewController*)controller
         awardBlock:(void (^)(bool finished))block;

@end
