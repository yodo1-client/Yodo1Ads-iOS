///
/// @file
/// @internal
/// @brief Definition for the VASVASTEventProcessor.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTTracking.h"
#import "VASVASTUrlWithId.h"

@class VASVASTExtensionAdVerifications;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM (NSInteger, VASVASTEventType) {
    VASVASTEventTrackStart,
    VASVASTEventTrackFirstQuartile,
    VASVASTEventTrackMidpoint,
    VASVASTEventTrackThirdQuartile,
    VASVASTEventTrackComplete,
    VASVASTEventTrackClose,
    VASVASTEventTrackCreativeView,
    VASVASTEventTrackCompanionCreativeView,
    VASVASTEventTrackCloseLinear,
    VASVASTEventTrackSkip,
    VASVASTEventTrackProgress,
    VASVASTEventTrackVerificationNotExecuted
};

FOUNDATION_EXPORT NSString * _Nonnull const VASVASTEventType_toString[];

@interface VASVASTEventProcessor : NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithTrackingEvents:(NSArray<VASVASTTracking *> *)trackingEvents
               companionTrackingEvents:(NSArray<VASVASTTracking *> *)companionTrackingEvents
                       adVerifications:(NSArray<VASVASTExtensionAdVerifications *> *)adVerifications
                           usingVASAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;

- (void)trackEvent:(VASVASTEventType)vastEvent;
- (void)trackEventProgress:(NSTimeInterval)currentPlaybackTime withDuration:(NSTimeInterval) duration;
- (NSTimeInterval)offsetFromString:(NSString *)offsetString duration:(NSTimeInterval)duration;

+ (void)sendVASTUrlsWithId:(NSArray<VASVASTUrlWithId *> *)vastUrls;
+ (void)sendTrackingRequest:(NSURL *)trackingURL;


// OM Integration

@property (weak, nullable) UIView *trackingView;

- (void)trackOMEventLoaded:(CGFloat)skipOffset;
- (void)trackOMEventStart:(CGFloat)duration volume:(CGFloat)volume;
- (void)trackOMEventImpression;
- (void)trackOMEventVolumeChanged:(CGFloat)volume;
- (void)trackOMEventPause;
- (void)trackOMEventResume;
    
NS_ASSUME_NONNULL_END

@end
