///
///  @file
///  @brief Definitions for VASInterstitialAdFactory.
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>
#import "VASInterstitialAd.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Defines the strategies that can be used to trim the cache.
 */
typedef NS_ENUM(VASCacheTrimStrategy, VASInterstitialCacheTrimStrategy) {
    /// Remove the oldest entries in the cache.
    VASInterstitialCacheTrimStrategyOldest = 1,
    /// Remove the newest entries in the cache.
    VASInterstitialCacheTrimStrategyNewest,
};

/// VASInterstitialAdFactory error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASInterstitialAdFactoryErrorDomain;

/// Error codes that are used in the VASInterstitialAdFactory error domain.
typedef NS_ENUM(NSInteger, VASInterstitialAdFactoryError) {
    /// There were no ads in the cache.
    VASInterstitialAdFactoryErrorNoAdsInCache = 1,
    /// An ad load is already in progress.
    VASInterstitialAdFactoryErrorAdLoadInProgress,
    /// The trim strategy is unknown.
    VASInterstitialAdFactoryErrorUnknownTrimStrategy,
};

/// VASRequestMetadata - Interstitial Ad Placement ID key
FOUNDATION_EXPORT NSString * const kVASMetadataInterstitialAdPlacementIdKey;
/// VASRequestMetadata - Interstitial Ad Type key
FOUNDATION_EXPORT NSString * const kVASMetadataInterstitialPlacementTypeKey;


@class VASInterstitialAdFactory;

/**
 Protocol for receiving notifications from the VASInterstitialAdFactory.
 */
@protocol VASInterstitialAdFactoryDelegate <NSObject>

/**
 Called when the VASInterstitialAd has been loaded. A new VASInterstitialAd instance will be provided as part of this callback.
 
 @param adFactory         The calling VASInterstitialAdFactory.
 @param interstitialAd    The VASInterstitialAd object that is ready to be displayed.
 */
- (void)interstitialAdFactory:(VASInterstitialAdFactory *)adFactory didLoadInterstitialAd:(VASInterstitialAd *)interstitialAd;

/**
 Called when the cache request is complete.
 
 @param adFactory    The calling VASInterstitialAdFactory.
 @param numRequested The number of ads requested for the cache (i.e. the difference between the maximum number of ads for your cache and the ads already in the cache).
 @param numReceived  The number of ads received for the cache.  This value may be less than the number requested if not all ads requested were available.
 */
- (void)interstitialAdFactory:(VASInterstitialAdFactory *)adFactory cacheLoadedNumRequested:(NSInteger)numRequested numReceived:(NSInteger)numReceived;

/**
 Called when the number of ads in the cache has been modified. This could mean that ads have been added to the cache or that an ad was removed from the cache for display.
 
 @param adFactory The calling VASInterstitialAdFactory.
 @param cacheSize The new value of the cache. Represents the number of cached ads available.
 */
- (void)interstitialAdFactory:(VASInterstitialAdFactory *)adFactory cacheUpdatedWithCacheSize:(NSInteger)cacheSize;

/**
 Called when there is an error requesting a VASInterstitialAd or loading a VASInterstitialAd from the cache.
 
 @param adFactory The calling VASInterstitialAdFactory.
 @param errorInfo An VASErrorInfo object containing details about the error.
 */
- (void)interstitialAdFactory:(VASInterstitialAdFactory *)adFactory didFailWithError:(VASErrorInfo *)errorInfo;

@end

/**
 VASInterstitialAdFactory is a factory class that handles loading and caching of VASInterstitialAd placements. It uses the VASInterstitialAdFactoryDelegate protocol to provide notifications about VASInterstitialAd creation.
 */
@interface VASInterstitialAdFactory : NSObject

/**
 Initialize an VASInterstitialAdFactory for creating VASInterstitialAd objects. Use this to set the placementId and listener for VASInterstitialAd that the VASInterstitialAdFactory will create.
 
 @param placementId   The placementId that will be set for all VASInterstitialAd that the VASInterstitialAdFactory creates.
 @param vasAds        The VASAds instance for this object to use.
 @param delegate      The VASInterstitialAdFactoryDelegate that will receive ad factory events for the VASInterstitialAdFactory.
 @return An initialized instance of this class.
 */
- (instancetype)initWithPlacementId:(NSString *)placementId
                             vasAds:(VASAds *)vasAds
                           delegate:(nullable id <VASInterstitialAdFactoryDelegate>)delegate NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Requests a new VASInterstitialAd. Calling this method does not affect the cache.
 
 @param interstitialAdDelegate the VASInterstitialAdDelegate that will receive ad events for the  VASInterstitialAd.
 */
- (void)load:(id <VASInterstitialAdDelegate>)interstitialAdDelegate;

/**
 Loads the VASInterstitialAd for the provided bid.
 
 @param bid              The Bid that will be loaded.
 @param interstitialAdDelegate The VASInterstitialAdDelegate that will receive ad events for the VASInterstitialAd.
 */
- (void)loadBid:(VASBid *)bid interstitialAdDelegate:(id <VASInterstitialAdDelegate>)interstitialAdDelegate;

/**
 Loads an ad from the cache. Calling this method when there are no ads in the cache will invoke the VASInterstitialAdFactoryDelegate#adFactory:didFailWithError: callback.
 
 @param interstitialAdDelegate The VASInterstitialAdDelegate that will receive ad events for the VASInterstitialAd.
 @return instance of VASInterstitialAd if at least one unexpired ad is in the cache; otherwise nil.
 */
- (nullable VASInterstitialAd *)loadFromCache:(id <VASInterstitialAdDelegate>)interstitialAdDelegate;

/**
 Aborts any load requests that are still active.
 */
- (void)abortLoad;

/**
 Aborts VASInterstitialAdFactory#cacheAds: requests that are still active.
 */
- (void)abortCacheLoad;

/**
 Sets the size of the cache and fills the cache with ads to the specified size.
 
 @param maxAds The number of VASInterstitialAd to load into the cache.
 */
- (void)cacheAds:(NSInteger)maxAds;

/**
 Trims the size of the current cache to a specified number of ads.
 
 @param trimStrategy Describes how you want to trim the cache.
 @param maxSize      The total number of VASInterstitialAd desired in the cache.
 */
- (void)trimCache:(VASInterstitialCacheTrimStrategy)trimStrategy maxSize:(NSUInteger)maxSize;

/**
 Requests a bid for the provided placement Id.
 
 @param placementId        The placementId that will be set for all VASInterstitialAd that the VASInterstitialAdFactory creates.
 @param requestMetadata    The VASRequestMetadata to use for ad requests.
 @param vasAds             The VASAds instance for this object to use.
 @param handler            The completion handler that will receive the bid request result.
 */
+ (void)requestBidForPlacementId:(NSString *)placementId
                 requestMetadata:(nullable VASRequestMetadata *)requestMetadata
                          vasAds:(VASAds *)vasAds
               completionHandler:(VASBidRequestCompletionHandler)handler;

/**
 Returns the number of VASInterstitialAd items loaded in the cache.
 */
@property (readonly) NSUInteger cacheSize;

/**
 Get the placementId for the VASInterstitialAdFactory.
 */
@property (nonatomic, readonly) NSString *placementId;

/**
 The VASRequestMetadata object that overrides global VASRequestMetadata for the VASInterstitialAdFactory ad requests.
 */
@property (nullable) VASRequestMetadata *requestMetadata;

/**
 The object implementing the VASInterstitialAdFactoryDelegate protocol, to receive ad factory event callbacks.
 */
@property (nonatomic, weak, nullable) id <VASInterstitialAdFactoryDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
