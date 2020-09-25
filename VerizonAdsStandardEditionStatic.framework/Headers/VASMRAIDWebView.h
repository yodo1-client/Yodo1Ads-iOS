///
/// @file
/// @brief Definitions for VASMRAIDWebView
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsWebView.h>

NS_ASSUME_NONNULL_BEGIN

/// The possible states of our MRAID JS layer.
typedef NS_ENUM(NSUInteger, VASMRAIDState) {
    /// The initial setting of MRAID, set to this while loading the initial HTML.
    VASMRAIDStateLoading,
    /// Once loaded, set to the default state to allow execution of MRAID commands.
    VASMRAIDStateDefault,
    /// Set to this state while an ad is expanded.
    VASMRAIDStateExpanded,
    /// Set to resized when the ad size has been changed.
    VASMRAIDStateResized,
    /// Set to this when the ad has been hidden.
    VASMRAIDStateHidden,
};

/// The possible MRAID placement types.
typedef NS_ENUM(NSUInteger, VASMRAIDPlacementType) {
    /// The type is not yet known.
    VASMRAIDPlacementTypeUnknown,
    /// An MRAID inline banner ad.
    VASMRAIDPlacementTypeInline,
    /// An MRAID intersitial ad.
    VASMRAIDPlacementTypeInterstitial
};

/**
 * An extension of VASWebView which supports MRAID 3.0.
 */
@interface VASMRAIDWebView : VASWebView

/**
 Specifies whether the ad should show or hide the status bar for a more complete full screen experience. Must be read/set on the main thread.
 */
@property (getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 The designated initializer for an MRAID view.
 
 @param frame           The dimensions of the ad.
 @param interstitial    YES if the ad will be an VASMRAIDPlacementTypeInterstitial, NO for VASMRAIDPlacementTypeInline.
 @param delegate        The object that should receive VASWebViewDelegate callbacks.
 @param vasAds         The VASAds object this instance will use.
 @return an instance of the VASMRAIDWebView class.
 */
- (instancetype)initWithFrame:(CGRect)frame
                 interstitial:(BOOL)interstitial
                     delegate:(id<VASWebViewDelegate>)delegate
                      vasAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;

// This super class method is unavailable for constructing an VASMRAIDWebView object.
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<VASWebViewDelegate>)delegate
                      vasAds:(VASAds *)vasAds NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
