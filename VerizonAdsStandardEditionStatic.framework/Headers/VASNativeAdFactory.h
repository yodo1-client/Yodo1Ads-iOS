///
/// @file
/// @brief Definitions for VASNativeAdFactory
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Defines the strategies that can be used to trim the cache.
 */
typedef NS_ENUM(VASCacheTrimStrategy, VASNativeCacheTrimStrategy) {
    /// Remove the oldest entries in the cache.
    VASNativeCacheTrimStrategyOldest = 1,
    /// Remove the newest entries in the cache.
    VASNativeCacheTrimStrategyNewest,
};

/// VASNatveAd error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASNativeAdFactoryErrorDomain;

/// VASRequestMetadata - Native Ad Placement Type key
FOUNDATION_EXPORT NSString * const kVASMetadataKeyNativeAdPlacementType;
/// VASRequestMetadata - Native Ad Placement ID key
FOUNDATION_EXPORT NSString * const kVASMetadataKeyNativeAdPlacementId;
/// VASRequestMetadata - Native Ad Types key
FOUNDATION_EXPORT NSString * const kVASMetadataKeyNativeAdTypes;

/// Error codes that are used in the NativeAd error domain
typedef NS_ENUM(NSInteger, VASNativeAdFactoryError) {
    /// The WaterfallProvider could not be created.
    VASNativeAdFactoryErrorNoWaterfallProvider = 1,
    /// There were no ads in the cache.
    VASNativeAdFactoryErrorNoAdsInCache,
    /// An ad load is already in progress.
    VASNativeAdFactoryErrorAdLoadInProgress,
    /// The trim strategy is unknown.
    VASNativeAdFactoryErrorUnknownTrimStrategy,
};

@class VASNativeAdFactory;
@class VASNativeAd;
@protocol VASNativeAdDelegate;

/**
 Protocol for receiving notifications from the VASNativeAdFactory.
 */
@protocol VASNativeAdFactoryDelegate <NSObject>

/**
 Called when the components for the VASNativeAd have been loaded. A new VASNativeAd instance will be provided as part of this callback.
 
 Called on an arbitrary background queue, dispatch to the main queue for UI placement.
 
 @param adFactory The calling VASNativeAdFactory.
 @param nativeAd  The VASNativeAd object that is ready to be displayed.
 */
- (void)nativeAdFactory:(VASNativeAdFactory *)adFactory
        didLoadNativeAd:(VASNativeAd *)nativeAd;

/**
 Called when the cache request is complete.
 
 Called on an arbitrary background queue.
 
 @param adFactory    The calling VASNativeAdFactory.
 @param numRequested The number of ads requested for the cache (i.e. the difference between the maximum number of ads for your cache and the ads already in the cache).
 @param numReceived  The number of ads received for the cache. This value may be less than the number requested if not all ads requested were available.
 */
- (void)nativeAdFactory:(VASNativeAdFactory *)adFactory
cacheLoadedNumRequested:(NSUInteger)numRequested
            numReceived:(NSUInteger)numReceived;

/**
 Called when the number of ads in the cache has been modified.  This could mean that ads have been added to the cache or that an ad was removed from the cache for display.
 
 Called on an arbitrary background queue.
 
 @param adFactory The calling VASNativeAdFactory.
 @param cacheSize The new value representing the number of cached ads available.
 */
- (void)nativeAdFactory:(VASNativeAdFactory *)adFactory
cacheUpdatedWithCacheSize:(NSUInteger)cacheSize;

/**
 Called when there is an error requesting an VASNativeAd or loading an VASNativeAd from the cache.
 
 Called on an arbitrary background queue.
 
 @param adFactory The calling VASNativeAdFactory.
 @param errorInfo An VASErrorInfo object containing details about the error.
 */
- (void)nativeAdFactory:(VASNativeAdFactory *)adFactory
       didFailWithError:(nullable VASErrorInfo *)errorInfo;

@end

/**
 VASNativeAdFactory is a factory class that handles loading and caching of VASNativeAd placements. It uses the VASNativeAdFactoryDelegate protocol to provide notifications about VASNativeAd creation.
 */
@interface VASNativeAdFactory : NSObject

/**
 Initialize an VASNativeAdFactory for creating VASNativeAd objects. Use this to set the placementId and listener for VASNativeAd objects that the VASNativeAdFactory will create.
 
 @param placementId       The placementId that will be set for all VASNativeAd objects that the VASNativeAdFactory creates.
 @param adTypes           The array of requested native types.
 @param vasAds           The VASAds object to use for creating an VASNativeAd.
 @param delegate          The VASNativeAdFactoryDelegate that will receive ad factory events for the VASNativeAdFactory.
 @returns An instance of this class.
 */
- (instancetype)initWithPlacementId:(NSString *)placementId
                            adTypes:(NSArray<NSString *> *)adTypes
                             vasAds:(VASAds *)vasAds
                           delegate:(nullable id <VASNativeAdFactoryDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Requests a bid for the opportunity to win the VASNativeAd impression.
 
 @param placementId        The placementId that will be set for all VASNativeAds that the VASNativeAdFactory creates.
 @param adTypes            The array of requested native types.
 @param requestMetadata    The VASRequestMetadata to use for ad requests.
 @param vasAds             The VASAds instance for this object to use.
 @param handler            The completion handler that will receive the bid request result.
 */
+ (void)requestBidForPlacementId:(NSString *)placementId
                         adTypes:(NSArray<NSString *> *)adTypes
                 requestMetadata:(nullable VASRequestMetadata *)requestMetadata
                          vasAds:(VASAds *)vasAds
               completionHandler:(VASBidRequestCompletionHandler)handler;

/**
 Requests a new VASNativeAd. Calling this method does not affect the cache.
 
 @param nativeAdDelegate    The VASNativeAdDelegate that will receive ad events for the VASNativeAd.
 */
- (void)load:(id <VASNativeAdDelegate>)nativeAdDelegate;

/**
 Loads the VASNativeAd for the provided bid.
 
 @param bid              The Bid that will be loaded.
 @param nativeAdDelegate The VASNativeAdDelegate that will receive ad events for the VASNativeAd.
 */
- (void)loadBid:(VASBid *)bid nativeAdDelegate:(id <VASNativeAdDelegate>)nativeAdDelegate;

/**
 Requests a new VASNativeAd without loading its assets. Calling this method does not affect the cache. Assets (images and videos) will not be loaded.
 
 @param nativeAdDelegate    The VASNativeAdDelegate that will receive ad events for the VASNativeAd.
 */
- (void)loadWithoutAssets:(id <VASNativeAdDelegate>)nativeAdDelegate;

/**
 Loads the VASNativeAd for the provided bid, without loading the ad's assets. Assets (images and videos) will not be loaded.
 
 @param bid              The Bid that will be loaded.
 @param nativeAdDelegate The VASNativeAdDelegate that will receive ad events for the VASNativeAd.
 */
- (void)loadBidWithoutAssets:(VASBid *)bid nativeAdDelegate:(id <VASNativeAdDelegate>)nativeAdDelegate;

/**
 Loads an ad from the cache. Calling this method when there are no ads in the cache will invoke the VASNativeAdFactoryDelegate#adFactory:didFailWithError: callback.
 
 @param nativeAdDelegate The VASNativeAdDelegate that will receive ad events for the VASNativeAd.
 @return instance of VASNativeAd if at least one unexpired ad is in the cache; otherwise nil.
 */
- (nullable VASNativeAd *)loadFromCache:(id <VASNativeAdDelegate>)nativeAdDelegate;

/**
 Sets the size of the cache and fills the cache with ads to the specified size.
 
 @param maxAds The number of VASNativeAd to load into the cache.
 */
- (void)cacheAds:(NSUInteger)maxAds;

/**
 Aborts any load requests that are still active.
 */
- (void)abortLoad;

/**
 Aborts VASNativeAdFactory cacheAds requests that are still active.
 */
- (void)abortCacheLoad;

/**
 Trims the size of the current cache to a specified number of ads.
 
 @param trimStrategy Describes how you want to trim the cache.
 @param maxSize      The total number of VASNativeAd desired in the cache.
 */
- (void)trimCache:(VASNativeCacheTrimStrategy)trimStrategy maxSize:(NSUInteger)maxSize;

/**
 The placementId for the VASNativeAdFactory.
 */
@property (readonly, copy) NSString *placementId;

/**
 The object implementing the VASNativeAdFactoryDelegate protocol, to receive ad factory event callbacks.
 */
@property (weak, nullable) id <VASNativeAdFactoryDelegate> delegate;

/**
 The VASRequestMetadata object that overrides global VASRequestMetadata for the VASNativeAdFactory ad requests.
 */
@property (nullable) VASRequestMetadata *requestMetadata;

/**
 The number of VASNativeAd items loaded in the cache.
 */
@property (readonly) NSUInteger cacheSize;

@end

NS_ASSUME_NONNULL_END
