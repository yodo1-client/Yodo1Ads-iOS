///
/// @file
/// @brief Definitions for VASNativeAd
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASNativeAdFactory.h>
#import <VerizonAdsStandardEditionStatic/VASNativeAdAdapter.h>
#import <VerizonAdsStandardEditionStatic/VASNativeAdErrors.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

@class VASNativeAd;

#pragma mark - VASNativeAdDelegate

/**
 Protocol for receiving notifications from the VASNativeAd.
 These notifications will be called on an arbitrary queue.
 */
@protocol VASNativeAdDelegate <NSObject>

/**
 Called when an error occurs during the VASNativeAd lifecycle. An VASErrorInfo object provides detail about the error.
 
 @param nativeAd  The VASNativeAd that experienced the error.
 @param errorInfo The VASErrorInfo that describes the error that occurred.
 */
- (void)nativeAdDidFail:(VASNativeAd *)nativeAd withError:(VASErrorInfo *)errorInfo;

/**
 Called when the VASNativeAd has been closed.
 
 @param nativeAd The VASNativeAd that was closed.
 */
- (void)nativeAdDidClose:(VASNativeAd *)nativeAd;

/**
 Called when the VASNativeAd has been clicked.
 
 @param nativeAd    The VASNativeAd associated with the click.
 @param component   The VASComponent that was clicked.
 */
- (void)nativeAdClicked:(VASNativeAd *)nativeAd
          withComponent:(id<VASComponent>)component;

/**
 Called when the VASNativeAd causes the user to leave the application. For example, tapping an VASNativeAd may launch an external browser.
 
 @param nativeAd The VASNativeAd that caused the application exit.
 */
- (void)nativeAdDidLeaveApplication:(VASNativeAd *)nativeAd;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen experiences.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen experiences. Returning nil will result in no fullscreen experience being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)nativeAdPresentingViewController;

/**
 This callback is used to surface additional events to the publisher from the SDK.
 
 @param nativeAd  The VASNativeAd that is relaying the event.
 @param eventId   The event identifier.
 @param source    The identifier of the event source.
 @param arguments A dictionary of key/value pairs of arguments related to the event.
 */
- (void)nativeAd:(VASNativeAd *)nativeAd
           event:(NSString *)eventId
          source:(NSString *)source
       arguments:(NSDictionary<NSString *, id> *)arguments;

@end

#pragma mark - VASNativeAd

/**
 VASNativeAd is a placement used for ads that are a collection of assets that can be individually laid out in a way that looks and feels like the application.
 */
@interface VASNativeAd : NSObject <VASPlacement>

/**
 The VASNativeAd type, or nil if the ad has been destroyed.
 */
@property (readonly, nullable) NSString *adType;

/**
 The object implementing the VASNativeAdDelegate protocol, to receive native ad callbacks.
 */
@property (weak, nullable) id<VASNativeAdDelegate> delegate;

/**
 An VASCreativeInfo object containing identifiers for the ad's creative and its demand source, if available.
 */
@property (readonly, nullable) VASCreativeInfo *creativeInfo;

/**
 The placementId for the VASNativeAd. Will be nil after the ad is destroyed.
 */
@property (readonly, copy, nullable) NSString *placementId;

/**
 A sanitized copy of the native ad JSON that can be queried for things like ad properties and metadata.
 */
@property (readonly, nullable) NSDictionary<NSString *, id> *JSON;

/**
 The component IDs that are found on this ad.
 */
@property (readonly, copy) NSSet<NSString *> *componentIds;

/**
 The component IDs that are required for this ad. A subset of the componentIds property.
 */
@property (readonly, copy) NSSet<NSString *> *requiredComponentIds;

/**
 Returns a VASComponent for the specified component identifier.
 This method must be called on the main thread.
 
 @param componentId     The component identifier for retrieving the VASComponent.
 @return a VASComponent object.
 */
- (nullable id<VASComponent>)component:(NSString *)componentId;

/**
 Destroys the VASNativeAd and frees all associated resources and removes all requested VASTextView and VASDisplayMediaView views.
 After the ad has been destroyed, the VASNativeAd instance is no longer usable.
 This method must be called on the main thread.
 */
- (void)destroy;

/**
 Performs the default action for the ad.  This method should be called when the user interacts with an ad in a manner that is not
 captured by the built in click listeners, and the publisher intends for the interaction to represent ad interaction.  Examples of
 non typical ad interaction captured by the publisher would be a user gesture, voice trigger or other uncaptured behavior.
 */
- (void)invokeDefaultAction;

/// @cond (INTERNAL)
/// @{
/**
 Fires an impression for the native ad. Use this method to notify the placement that the criteria for an ad impression have been met. This method is intended for integrations where the component Views are being created outside of the NativeAd instance.
 */
- (void)fireImpression;
/// @}
/// @endcond

/**
 Register a view for tracking using the Open Measurement SDK.
 This view should contain all required component views for the native ad.  This method must be called on the main thread.
 
 @param containerView The UIView containing the native ad's component views.
 @return YES if the Open Measurement SDK started tracking the containerView successfully, otherwise NO.
 */
- (BOOL)registerContainerView:(UIView *)containerView;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
