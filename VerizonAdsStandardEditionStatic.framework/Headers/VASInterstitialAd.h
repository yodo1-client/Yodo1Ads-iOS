///
///  @file
///  @brief Definitions for VASInterstitialAd
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

/// VASInterstitialAd error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASInterstitialAdErrorDomain;

/// Error codes that are used by VASErrorInfo in the VASInterstitialAd error domain.
typedef NS_ENUM(NSInteger, VASInterstitialAdErrorCode) {
    /// The ad has expired.
    VASInterstitialAdErrorExpired = 1,
};

@class VASInterstitialAd;

/**
 Protocol for receiving notifications from the VASInterstitialAd.
 These notifications will be called on an arbitrary queue.
 */
@protocol VASInterstitialAdDelegate <NSObject>

/**
 Called when an error occurs during the VASInterstitialAd lifecycle. A VASErrorInfo object provides detail about the error.
 
 @param interstitialAd    The VASInterstitialAd that experienced the error.
 @param errorInfo         The VASErrorInfo that describes the error that occured.
 */
- (void)interstitialAdDidFail:(VASInterstitialAd *)interstitialAd withError:(VASErrorInfo *)errorInfo;

/**
 Called when the VASInterstitialAd has been shown.
 
 @param interstitialAd    The VASInterstitialAd that was shown.
 */
- (void)interstitialAdDidShow:(VASInterstitialAd *)interstitialAd;

/**
 Called when the VASInterstitialAd has been closed.
 
 @param interstitialAd    The VASInterstitialAd that was closed.
 */
- (void)interstitialAdDidClose:(VASInterstitialAd *)interstitialAd;

/**
 Called when the VASInterstitialAd has been clicked.
 
 @param interstitialAd    The VASInterstitialAd that was clicked.
 */
- (void)interstitialAdClicked:(VASInterstitialAd *)interstitialAd;

/**
 Called when the VASInterstitialAd causes the user to leave the application. For example, tapping a VASInterstitialAd may launch an external browser.
 
 @param interstitialAd    The VASInterstitialAd that caused the application exit.
 */
- (void)interstitialAdDidLeaveApplication:(VASInterstitialAd *)interstitialAd;

/**
 This callback is used to surface additional events to the publisher from the SDK.
 
 @param interstitialAd The VASInterstitialAd that is relaying the event.
 @param source         The identifier of the event source.
 @param eventId        The event identifier.
 @param arguments      A dictionary of key/value pairs of arguments related to the event.
 */
- (void)interstitialAdEvent:(VASInterstitialAd *)interstitialAd
                     source:(NSString *)source
                    eventId:(NSString *)eventId
                  arguments:(nullable NSDictionary<NSString *, id> *)arguments;

@end

/**
 VASInterstitialAd is a placement used for ads that generally display in a new fullscreen window.
 */
@interface VASInterstitialAd : NSObject <VASPlacement>

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Show the ad.
 
 @param viewController        The view controller from which the ad must be shown.
 */
- (void)showFromViewController:(UIViewController *)viewController;

/**
 Destroys the VASInterstitialAd and frees all associated resources. After the ad has been destroyed, the VASInterstitialAd instance is no longer usable.
 */
- (void)destroy;

/**
 Specifies whether the ad should show or hide the status bar for a more complete full screen experience.
 */
@property (nonatomic, getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 Specifies the animation for entering the ad when the ad is shown.
 */
@property (nonatomic) NSInteger enterAnimationId;

/**
 Specifies the the animation for exiting the ad when the ad is closed.
 */
@property (nonatomic) NSInteger exitAnimationId;

/**
 The object implementing the VASInterstitialAdDelegate protocol, to receive interstitial ad callbacks.
 */
@property (nonatomic, weak, nullable) id<VASInterstitialAdDelegate> delegate;

/**
 The placementId for the VASInterstitialAd.
 */
@property(readonly, copy, nullable) NSString *placementId;

/**
 Gets an VASCreativeInfo object containing identifiers for the VASInterstitialAd object's creative and its demand source, if available.
 */
@property (readonly, nullable) VASCreativeInfo *creativeInfo;

@end

NS_ASSUME_NONNULL_END

