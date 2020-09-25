///
/// @file
/// @brief Definitions for VASVerizonNativeAd.
///
/// @copyright Copyright (c)2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASVerizonNativeComponentBundle.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsOMSDK.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVerizonNativeAdFactory : NSObject <VASComponentFactory>

/// Required args: kVASNativeComponentDelegateKey
- (nullable id<VASComponent>)newInstanceFromComponentInfo:(NSDictionary<NSString *,id> *)componentInfo
                                                     args:(nullable NSDictionary<NSString *, id> *)args
                                                   VASAds:(VASAds *)vasAds;

@end

#pragma mark - VASVerizonNativeAd

@interface VASVerizonNativeAd : VASVerizonNativeComponentBundle

/// Get the type of the ad content or nil if it does not exist.
@property (readonly, nullable) NSString *adType;

/// The Open Measurement session type for this object instance.
@property (readonly, nullable) NSString *omSessionType;

/// The omVendors array for this object instance.
@property (readonly, nullable) NSArray<NSDictionary *> *omVendors;

/// A set of strings representing the required components for this bundle, if available, otherwise an empty set.
@property (readonly) NSSet<NSString *> *requiredComponentIds;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// @cond (INTERNAL)
/// @{
/**
 Fires an impression for the native ad. Use this method to notify the placement that the criteria for an ad impression have been met. This method is intended for integrations where the component Views are being created outside of the NativeAd instance.
 */
- (void)fireImpression;
/// @}
/// @endcond

/// Called to invoke the default action for interaction with the ad.
- (void)invokeDefaultAction;

// Open Measurement SDK (OMSDK) support

/// The current omVideoEvents object. Should only be accessed from the main thread.
@property (readonly, nullable) OMIDOathVideoEvents *omVideoEvents;

/**
 Register a view for tracking using the Open Measurement SDK.
 This view should contain all required component views for the native ad.  This method must be called on the main thread.
 
 @param containerView The UIView containing the native ad's component views.
 @return YES if the Open Measurement SDK started tracking the containerView successfully, otherwise NO.
 */
- (BOOL)registerContainerView:(UIView *)containerView;

/**
 Load resources for this native component.
 
 Subclasses should override with any resource loading needed, otherwise this class method handler is called immediately with no errors.
 
 The VASErrorInfo response will be in the completion handler if an error occurs which may also contain an underlying error as well with more information about the cause of the error.
 
 @param timeout    Time limit for loading the native resources in NSTimeInterval seconds.
 @param skipAssets Set to YES if the controller should not download any of the component assets (i.e. images and videos).
 @param handler    Block that is called when loading resources is complete. If successful, `error` will be nil. If loading any required component fails, an VASErrorInfo object will be returned. Failing to load optional resources will not generate an error but continue attempting to load more resources. If abortLoadResources is called, the operation is aborted and no completionHandler callback will occur. The completion handler block will be called on an arbitrary background queue.
 */
- (void)loadResourcesWithTimeout:(NSTimeInterval)timeout
                      skipAssets:(BOOL)skipAssets
               completionHandler:(VASNativeLoadResourcesCompletionHandler)handler;

/**
 Abort the loading of resources initiated by the loadResourcesWithTimeout method.
 
 Subclasses should override this method if loadResourcesWithTimeout is implemented.
 */
- (void)abortLoadResources;

@end

NS_ASSUME_NONNULL_END
