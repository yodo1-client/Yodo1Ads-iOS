///
///  @file
///  @brief Definitions for VASInlineAdView
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>
#import "VASInlineAdSize.h"

NS_ASSUME_NONNULL_BEGIN

/// VASInlineAdView error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASInlineAdViewErrorDomain;

/// The default value (0) for refreshInterval indicating refresh is disabled.
FOUNDATION_EXPORT const NSUInteger kVASInlineAdRefreshDisabledInterval;

@class VASInlineAdView;

/**
 Protocol for receiving notifications from the VASInlineAdView.
 Unless otherwise specified, all methods will be called on an arbitrary background queue.
 */
@protocol VASInlineAdViewDelegate <NSObject>

/**
 Called when an error occurs during the VASInlineAdView lifecycle. An VASErrorInfo object provides detail about the error.
 
 @param inlineAd    The VASInlineAdView that experienced the error.
 @param errorInfo   The VASErrorInfo that describes the error that occured.
 */
- (void)inlineAdDidFail:(VASInlineAdView *)inlineAd withError:(VASErrorInfo *)errorInfo;

/**
 Called when the VASInlineAdView has been shown.
 
 @param inlineAd    The VASInlineAdView that was shown.
 */
- (void)inlineAdDidExpand:(VASInlineAdView *)inlineAd;

/**
 Called when The VASInlineAdView has been closed.
 
 @param inlineAd    The VASInlineAdView that was closed.
 */
- (void)inlineAdDidCollapse:(VASInlineAdView *)inlineAd;

/**
 Called when the VASInlineAdView has been clicked.
 
 @param inlineAd    The VASInlineAdView that was clicked.
 */
- (void)inlineAdClicked:(VASInlineAdView *)inlineAd;

/**
 Called when the VASInlineAdView causes the user to leave the application. For example, tapping a VASInlineAdView may launch an external browser.
 
 @param inlineAd    The VASInlineAdView that caused the application exit.
 */
- (void)inlineAdDidLeaveApplication:(VASInlineAdView *)inlineAd;

/**
 Called after the VASInlineAdView completed resizing.
 
@param inlineAd    The VASInlineAdView that caused the application exit.
 */
- (void)inlineAdDidResize:(VASInlineAdView *)inlineAd;

/**
 Called after the VASInlineAdView has been refreshed.
 
 @param inlineAd    The VASInlineAdView that was refreshed.
 */
- (void)inlineAdDidRefresh:(VASInlineAdView *)inlineAd;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen ad.
 
 Note that this method is called on the main queue.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen ad. Returning nil will result in no fullscreen ad being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)inlineAdPresentingViewController;

/**
 This callback is used to surface additional events to the publisher from the SDK.
 
 @param inlineAd  The VASInlineAdView that is relaying the event.
 @param eventId   The event identifier.
 @param source    The identifier of the event source.
 @param arguments A dictionary of key/value pairs of arguments related to the event.
 */
- (void)inlineAd:(VASInlineAdView *)inlineAd
           event:(NSString *)eventId
          source:(NSString *)source
       arguments:(NSDictionary<NSString *, id> *)arguments;

@end

/**
 VASInlineAdView is a placement used for rectangular ads that are displayed within the screen layout, such as banners.
 */
@interface VASInlineAdView : UIView <VASPlacement>

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Destroys the VASInlineAdView and frees all associated resources. After the ad has been destroyed, the VASInlineAdView instance is no longer usable.
 */
- (void)destroy;

/**
 Starts refreshing the inline ad.
 */
- (void)startRefresh;

/**
 The ad sizes that were requested.
 */
@property (readonly, copy) NSArray<VASInlineAdSize *> *requestAdSizes;

/**
 The ad size for the VASInlineAdView.
 */
@property (nullable, readonly) VASInlineAdSize *adSize;

/**
 Specifies whether the ad should be immersive.
 */
@property (getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 Specifies the refresh is enabled or not based on the refreshInterval value.
 */
@property (readonly) BOOL isRefreshEnabled;

/**
 Specifies the refresh interval between the ads.
 Default is (0) which indicates refresh is disabled.
 */
@property (atomic) NSUInteger refreshInterval;

/**
 The object implementing the VASInlineAdViewDelegate protocol, to receive VASInlineAdView callbacks.
 */
@property (weak, nullable) id<VASInlineAdViewDelegate> delegate;

/**
 The placementId for the VASInlineAdView.
 */
@property (readonly, nullable) NSString *placementId;

/**
 Gets an VASCreativeInfo object containing identifiers for the VASInlineAdView creative and its demand source, if available.
 */
@property (readonly, nullable) VASCreativeInfo *creativeInfo;

@end

NS_ASSUME_NONNULL_END
