///
/// @file
/// @brief Definitions for VASNativeVerizonNativeAdapter.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsNativePlacement.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsVerizonNativeController.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The ad adapter for interfacing with Verizon native format ads.
 */
@interface VASNativeVerizonNativeAdapter : NSObject <VASNativeAdAdapter>

/// The ad type. Will be nil until prepareWithAdContent has been called.
@property (readonly, nullable) NSString *adType;

/// A set of strings representing the required components for the current ad response, if available, otherwise an empty set.
@property (readonly) NSSet<NSString *> *requiredComponentIds;

/// The omVendors array for this object instance. Will be nil until prepareWithAdContent has been called.
@property (readonly, nullable) NSArray <NSDictionary *> *omVendors;

/// The Open Measurement session type for this object instance. Will be nil until prepareWithAdContent has been called.
@property (readonly, nullable) NSString *omSessionType;

/// The default action URL.
@property (readonly, nullable) NSURL *defaultActionURL;

/// The adapter's delegate.
@property (weak, nullable) id<VASNativeAdAdapterDelegate> delegate;

/**
 Initialize a new instance. Called from the VASAds adAdapterForAdRequestorClass method.
 
 @param vasAds The VASAds instance to use.
 @return an instance of this class.
 */
- (instancetype)initWithVASAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Stop the loading of components intitiated by the loadComponentsWithTimeout:skipAssets:completionHandler: call. If successfully aborted, then the `completionHandler` will not be called.
 */
- (void)abortLoadComponents;

/**
 Fetches all the first level component ids from the associated controller for the "components" key or from the top level original JSON data.
 
 @param nativeComponentBundle   The VASNativeComponentBundle for requesting component ids. May be nil to use the top level "components" of the controller original, native JSON.
 @return an NSSet of component ids found within the requested bundle component or from the original JSON. May be an empty set if the "components" entry is missing from the JSON.
 */
- (NSSet<NSString *> *)componentIds:(nullable VASNativeComponentBundle *)nativeComponentBundle;

/**
 TBD
 */
- (void)fireImpression;

/**
 TBD
 */
- (void)invokeDefaultAction;

/**
 Releases any adapter allocated resources and calls down to the controller to release its resources.
 */
- (void)releaseResources;

@end

NS_ASSUME_NONNULL_END
