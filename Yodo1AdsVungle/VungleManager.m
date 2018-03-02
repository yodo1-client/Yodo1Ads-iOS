//
//  VungleManager.m
//  Yodo1Ads
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "VungleManager.h"

NSString* const YODO1_VIDEO_VUNGLE_APPID            = @"videoVungleAppId";
NSString* const YODO1_VIDEO_VUNGLE_PLACEMENT_ID     = @"videoVunglePlacementId";

NSString* const YODO1_INTERS_VUNGLE_APPID           = @"InterstitialVungleAppId";
NSString* const YODO1_INTERS_VUNGLE_PLACEMENT_ID    = @"InterstitialVunglePlacementId";

@interface VungleManager ()<VungleSDKDelegate> {
    id <VungleAdDelegate> videoDelegate;
    id <VungleAdDelegate> interstitialDelegate;
}

@end

@implementation VungleManager

+ (instancetype)instance {
    static VungleManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[VungleManager alloc] init];
    });
    
    return sharedInstance;
}

- (void)startWithAppId:(NSString *)appId
            placements:(NSArray<NSString *> *)placements
              delegate:(id<VungleAdDelegate>)delegate
               isVideo:(BOOL)isVideo {
    
    if (isVideo) {
        videoDelegate = delegate;
    } else {
        interstitialDelegate = delegate;
    }
    [[VungleSDK sharedSDK] startWithAppId:appId
                               placements:placements
                                    error:nil];
    [[VungleSDK sharedSDK] setLoggingEnabled:NO];
    [VungleSDK sharedSDK].delegate = self;
}

- (void)dealloc {

}

- (void)playWithPlacementId:(NSString*)placementId
             viewcontroller:(UIViewController *)viewController {
    
    [VungleSDK sharedSDK].delegate = self;
    
    if ([self isReadyWithPlacementId:placementId]) {
        UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
        BOOL isLandscape = UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation]);
        if (isLandscape) {
            mask = UIInterfaceOrientationMaskLandscape;
        }
        NSDictionary* options = @{VunglePlayAdOptionKeyOrientations: @(mask)};
        [[VungleSDK sharedSDK]playAd:viewController
                             options:options
                         placementID:placementId
                               error:nil];
    }
}

- (BOOL)isReadyWithPlacementId:(NSString*)placementId {
    if ([[VungleSDK sharedSDK] isAdCachedForPlacementID:placementId]) {
        return YES;
    }
    return NO;
}

- (void)requestWithPlacementId:(NSString*)placementId {
    if ([self isReadyWithPlacementId:placementId]) {
        return;
    }
    [[VungleSDK sharedSDK] loadPlacementWithID:placementId error:nil];
}

#pragma VungleSDKDelegate

- (void)vungleWillShowAdForPlacementID:(nullable NSString *)placementID {
    if (videoDelegate && [videoDelegate respondsToSelector:@selector(vungleWillShowAdForPlacementID:)]) {
        [videoDelegate vungleWillShowAdForPlacementID:placementID];
    }
    
    if (interstitialDelegate && [interstitialDelegate respondsToSelector:@selector(vungleWillShowAdForPlacementID:)]) {
        [interstitialDelegate vungleWillShowAdForPlacementID:placementID];
    }
}

- (void)vungleAdPlayabilityUpdate:(BOOL)isAdPlayable placementID:(nullable NSString *)placementID {
    if (videoDelegate && [videoDelegate respondsToSelector:@selector(vungleAdPlayabilityUpdate:placementID:)]) {
        [videoDelegate vungleAdPlayabilityUpdate:isAdPlayable placementID:placementID];
    }
    
    if (interstitialDelegate && [interstitialDelegate respondsToSelector:@selector(vungleAdPlayabilityUpdate:placementID:)]) {
        [interstitialDelegate vungleAdPlayabilityUpdate:isAdPlayable placementID:placementID];
    }
}

- (void)vungleWillCloseAdWithViewInfo:(nonnull VungleViewInfo *)info placementID:(nonnull NSString *)placementID {
    if (videoDelegate && [videoDelegate respondsToSelector:@selector(vungleWillCloseAdWithViewInfo:placementID:)]) {
        [videoDelegate vungleWillCloseAdWithViewInfo:info placementID:placementID];
    }
    
    if (interstitialDelegate && [interstitialDelegate respondsToSelector:@selector(vungleWillCloseAdWithViewInfo:placementID:)]) {
        [interstitialDelegate vungleWillCloseAdWithViewInfo:info placementID:placementID];
    }
}

- (void)vungleSDKDidInitialize {
    if (videoDelegate && [videoDelegate respondsToSelector:@selector(vungleSDKDidInitialize)]) {
        [videoDelegate vungleSDKDidInitialize];
    }
    
    if (interstitialDelegate && [interstitialDelegate respondsToSelector:@selector(vungleSDKDidInitialize)]) {
        [interstitialDelegate vungleSDKDidInitialize];
    }
}

- (void)vungleSDKFailedToInitializeWithError:(NSError *)error {
    if (videoDelegate && [videoDelegate respondsToSelector:@selector(vungleSDKFailedToInitializeWithError:)]) {
        [videoDelegate vungleSDKFailedToInitializeWithError:error];
    }
    
    if (interstitialDelegate && [interstitialDelegate respondsToSelector:@selector(vungleSDKFailedToInitializeWithError:)]) {
        [interstitialDelegate vungleSDKFailedToInitializeWithError:error];
    }
}
@end
