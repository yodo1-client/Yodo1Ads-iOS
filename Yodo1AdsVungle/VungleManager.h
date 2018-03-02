//
//  VungleManager.h
//  Yodo1Ads
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <VungleSDK/VungleSDK.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString* const YODO1_VIDEO_VUNGLE_APPID;
FOUNDATION_EXPORT NSString* const YODO1_VIDEO_VUNGLE_PLACEMENT_ID;

FOUNDATION_EXPORT NSString* const YODO1_INTERS_VUNGLE_APPID;
FOUNDATION_EXPORT NSString* const YODO1_INTERS_VUNGLE_PLACEMENT_ID;

@protocol VungleAdDelegate <NSObject>

@optional

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(nullable NSString *)placementID;

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID;

- (void)vungleWillCloseAdWithViewInfo:(nonnull VungleViewInfo *)info placementID:(nonnull NSString *)placementID;

- (void)vungleSDKDidInitialize;

- (void)vungleSDKFailedToInitializeWithError:(NSError *)error;

@end

@interface VungleManager : NSObject

+ (instancetype)instance;

- (void)startWithAppId:(NSString *)appId
            placements:(nonnull NSArray<NSString *> *)placements
              delegate:(id<VungleAdDelegate>)delegate
               isVideo:(BOOL)isVideo;

- (void)playWithPlacementId:(NSString*)placementId viewcontroller:(UIViewController *)viewController;

- (BOOL)isReadyWithPlacementId:(NSString*)placementId;

- (void)requestWithPlacementId:(NSString*)placementId;

@end

NS_ASSUME_NONNULL_END
