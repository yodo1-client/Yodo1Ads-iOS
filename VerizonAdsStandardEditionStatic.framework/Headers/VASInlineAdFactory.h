///
///  @file
///  @brief Definitions for VASInlineAdFactory.
///
///  @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>
#import "VASInlineAdView.h"
#import "VASInlineAdSize.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Defines the strategies that can be used to trim the cache.
 */
typedef NS_ENUM(VASCacheTrimStrategy, VASInlineCacheTrimStrategy) {
    /// Remove the oldest entries in the cache.
    VASInlineCacheTrimStrategyOldest = 1,
    /// Remove the newest entries in the cache.
    VASInlineCacheTrimStrategyNewest,
};

/// VASInlineAdFactory error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASInlineAdFactoryErrorDomain;

/// Error codes that are used in the VASInlineAdFactory error domain.
typedef NS_ENUM(NSInteger, VASInlineAdFactoryError) {
    /// There were no ads in the cache.
    VASInlineAdFactoryErrorNoAdsInCache = 1,
    /// An ad load is already in progress.
    VASInlineAdFactoryErrorAdLoadInProgress,
    /// The trim strategy is unknown.
    VASInlineAdFactoryErrorUnknownTrimStrategy,
    /// The ad adapter view failed.
    VASInlineAdFactoryErrorNilAdView,
};

/// Inline Ad configuration domain.
FOUNDATION_EXPORT NSString * const kDomainVASInlinePlacement;

/// The key for the placement id found within placementData in the VASRequestMetadata.
FOUNDATION_EXPORT NSString * const kVASRequestMetadataInlineAdPlacementIdKey;       // NSString

/// The key for the placement type found within placementData in the VASRequestMetadata.
FOUNDATION_EXPORT NSString * const kVASRequestMetadataInlineAdPlacementTypeKey;     // NSString

/// VASRequestMetadata key for an array of dictionaries of ad sizes ("width"/"height")
FOUNDATION_EXPORT NSString * const kVASRequestMetadataInlineAdPlacementAdSizesKey;  // NSArray<NSDictionary<NSString,NSNumber>>

/// Width key for an ad size dict
FOUNDATION_EXPORT NSString * const kVASRequestMetadataInlineAdPlacementAdSizeWidthKey;

/// Height key for an ad size dict
FOUNDATION_EXPORT NSString * const kVASRequestMetadataInlineAdPlacementAdSizeHeightKey;

@class VASInlineAdFactory;

/**
 Protocol for receiving notifications from the VASInlineAdFactory.
 */
@protocol VASInlineAdFactoryDelegate <NSObject>

/**
 Called when the VASInlineAdView has been loaded. A new VASInlineAdView instance will be provided as part of this callback.
 
 @param adFactory The calling VASInlineAdFactory.
 @param inlineAd  The VASInlineAdView object that is ready to be displayed.
 */
- (void)inlineAdFactory:(VASInlineAdFactory *)adFactory didLoadInlineAd:(VASInlineAdView *)inlineAd;

/**
 Called when the cache request is complete.
 
 @param adFactory    The calling VASInlineAdFactory.
 @param numRequested The number of ads requested for the cache (i.e. the difference between the maximum number of ads for your cache and the ads already in the cache).
 @param numReceived  The number of ads received for the cache.  This value may be less than the number requested if not all ads requested were available.
 */
- (void)inlineAdFactory:(VASInlineAdFactory *)adFactory cacheLoadedNumRequested:(NSInteger)numRequested numReceived:(NSInteger)numReceived;

/**
 Called when the number of ads in the cache has been modified. This could mean that ads have been added to the cache or that an ad was removed from the cache for display.
 
 @param adFactory The calling VASInlineAdFactory.
 @param cacheSize The new value of the cache. Represents the number of cached ads available.
 */
- (void)inlineAdFactory:(VASInlineAdFactory *)adFactory cacheUpdatedWithCacheSize:(NSInteger)cacheSize;

/**
 Called when there is an error requesting a VASInlineAdView or loading a VASInlineAdView from the cache.
 
 @param adFactory The calling VASInlineAdFactory.
 @param errorInfo An VASErrorInfo object containing details about the error.
 */
- (void)inlineAdFactory:(VASInlineAdFactory *)adFactory didFailWithError:(VASErrorInfo *)errorInfo;

@end

/**
 VASInlineAdFactory is a factory class that handles loading and caching of VASInlineAdView placements. It uses the VASInlineAdFactoryDelegate protocol to provide notifications about VASInlineAdView creation.
 */
@interface VASInlineAdFactory : NSObject

/**
 Initialize an VASInlineAdFactory for creating VASInlineAdView objects. Use this to set the placementId and listener for VASInlineAdView that the VASInlineAdFactory will create.
 
 @param placementId     The placementId that will be set for all VASInlineAdView that the VASInlineAdFactory creates.
 @param adSizes         The ad sizes supported by the inline placement (size is specified in dips).
 @param vasAds          The VASAds instance for this object to use.
 @param delegate        The VASInlineAdFactoryDelegate that will receive ad factory events for the VASInlineAdFactory.
 @return An initialized instance of this class.
 */
- (instancetype)initWithPlacementId:(NSString *)placementId
                            adSizes:(NSArray<VASInlineAdSize *> *)adSizes
                             vasAds:(VASAds *)vasAds
                           delegate:(nullable id <VASInlineAdFactoryDelegate>)delegate NS_DESIGNATED_INITIALIZER;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Requests a new VASInlineAdView. Calling this method does not affect the cache.
 
 @param inlineAdDelegate The VASInlineAdViewDelegate that will receive ad events for the  VASInlineAdView.
 */
- (void)load:(id <VASInlineAdViewDelegate>)inlineAdDelegate;

/**
 Loads the VASInlineAdView for the provided bid.
 
 @param bid              The Bid that will be loaded.
 @param inlineAdDelegate The VASInlineAdViewDelegate that will receive ad events for the VASInlineAdView.
 */
- (void)loadBid:(VASBid *)bid inlineAdDelegate:(id<VASInlineAdViewDelegate>)inlineAdDelegate;

/**
 Loads an ad from the cache. Calling this method when there are no ads in the cache will invoke the VASInlineAdFactoryDelegate#adFactory:didFailWithError: callback.
 
 @param inlineAdDelegate The VASInlineAdViewDelegate that will receive ad events for the VASInlineAdView.
 @return instance of VASInlineAdView if at least one unexpired ad is in the cache; otherwise nil.
 */
- (nullable VASInlineAdView *)loadFromCache:(id<VASInlineAdViewDelegate>)inlineAdDelegate;

/**
 Aborts any load requests that are still active.
 */
- (void)abortLoad;

/**
 Aborts VASInlineAdFactory#cacheAds: requests that are still active.
 */
- (void)abortCacheLoad;

/**
 Sets the size of the cache and fills the cache with ads to the specified size.
 
 @param maxAds The number of VASInlineAdView to load into the cache.
 */
- (void)cacheAds:(NSInteger)maxAds;

/**
 Requests a bid for the provided placement Id.
 
 @param placementId     The placementId that will be set for all VASInlineAdView that the VASInlineAdFactory creates.
 @param adSizes         The ad sizes that are supported by the VASInlineAdView that the VASInlineAdFactory creates.
 @param requestMetadata The VASRequestMetadata to use for ad requests.
 @param vasAds          The VASAds instance for this object to use.
 @param handler         The completion handler that will receive the bid request result.
 */
+ (void)requestBidForPlacementId:(NSString *)placementId
                         adSizes:(NSArray<VASInlineAdSize *> *)adSizes
                 requestMetadata:(nullable VASRequestMetadata *)requestMetadata
                          vasAds:(VASAds *)vasAds
                      completion:(VASBidRequestCompletionHandler)handler;

/**
 Trims the size of the current cache to a specified number of ads.
 
 @param trimStrategy Describes how you want to trim the cache.
 @param maxSize      The total number of VASInlineAdView desired in the cache.
 */
- (void)trimCache:(VASInlineCacheTrimStrategy)trimStrategy maxSize:(NSUInteger)maxSize;

/**
 Returns the ad sizes supported by this ad factory.
 */
@property (readonly, copy) NSArray<VASInlineAdSize *> *adSizes;

/**
 Returns the number of VASInlineAdView items loaded in the cache.
 */
@property (readonly) NSUInteger cacheSize;

/**
 Get the placementId for the VASInlineAdFactory.
 */
@property (nonatomic, readonly) NSString *placementId;

/**
 The VASRequestMetadata object that overrides global VASRequestMetadata for the VASInlineAdFactory ad requests.
 */
@property (nullable) VASRequestMetadata *requestMetadata;

/**
 The object implementing the VASInlineAdFactoryDelegate protocol, to receive ad factory event callbacks.
 */
@property (nonatomic, weak, nullable) id <VASInlineAdFactoryDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
