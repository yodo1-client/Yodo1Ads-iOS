///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallItemMediation.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import "VASVerizonSSPWaterfallProvider.h"
#import "VASVerizonSSPWaterfallItem.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * The Client Mediation Playlist Item type.
 *
 * Currently this class only used by Super Auction.
 *
 */

@interface VASVerizonSSPWaterfallItemMediation : VASVerizonSSPWaterfallItem

@property (nonatomic, readonly, copy) NSString *siteId;
@property (nonatomic, readonly, copy) NSString *spaceId;

- (instancetype)initWithItemId:(NSString *)itemId
                     networkId:(nullable NSString *)networkId
                   placementId:(nullable NSString *)placementId
                        siteId:(NSString *)siteId
                       spaceId:(NSString *)spaceId
             enhancedAdControl:(BOOL)enhancedAdControlEnabled
                        adSize:(nullable NSDictionary<NSString *, id> *)adSizeDictionary;

- (instancetype)initWithResponseDictionary:(NSDictionary<NSString *, id> *)waterfallItemEntry
                               placementId:(nullable NSString *)placementId
                                   vasAds:(VASAds *)vasAds
                           HTTPURLResponse:(nullable NSHTTPURLResponse *)response;

@end

NS_ASSUME_NONNULL_END

