//
//  UnityAdsManager.h
//  Yodo1Ads
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <UnityAds/UnityAds.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString* const YODO1_VIDEO_UNITY_GAMEID;
FOUNDATION_EXPORT NSString* const YODO1_VIDEO_UNITY_PLACEMENTID;

FOUNDATION_EXPORT NSString* const YODO1_INTERS_UNITY_GAMEID;
FOUNDATION_EXPORT NSString* const YODO1_INTERS_UNITY_PLACEMENTID;

@protocol Yodo1UnityAdsDelegate <NSObject>

@optional

- (void)unityAdsReady:(NSString *)placementId;

- (void)unityAdsDidError:(UnityAdsError)error
             placementId:(NSString*)placementId
             withMessage:(NSString *)message;

- (void)unityAdsDidStart:(NSString *)placementId;

- (void)unityAdsDidFinish:(NSString *)placementId
          withFinishState:(UnityAdsFinishState)state;

@end

@interface UnityAdsManager : NSObject

+ (instancetype)instance;

- (void)startWithGameId:(NSString *)gameId
            placementId:(NSString*)placementId
               delegate:(id<Yodo1UnityAdsDelegate>)delegate
                isVideo:(BOOL)isVideo;

- (void)playWithPlacementId:(NSString*)placementId
             viewcontroller:(UIViewController *)viewController;

- (BOOL)isReadyWithPlacementId:(NSString*)placementId;

- (void)requestWithPlacementId:(NSString*)placementId;

- (void)setPIDataUseConsent:(BOOL)consent;

- (void)setCCPA:(BOOL)consent;

+ (NSString *)getVersion;
@end

NS_ASSUME_NONNULL_END
