///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallItemSuperAuction.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///


#import "VASVerizonSSPWaterfallItemMediation.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVerizonSSPSuperAuctionBidder : NSObject

@property (nullable, readonly) NSString *type;      // "type"
@property (nullable, readonly) NSString *price;     // "price"

@end

#pragma mark - VASVerizonSSPSuperAuctionDemandSource

@interface VASVerizonSSPSuperAuctionDemandSource : NSObject

@property (readonly) NSString *type;    // "type"
@property (readonly, copy) NSDictionary<NSString *, id> *sourceDict;

- (instancetype)initWithDictionary:(NSDictionary<NSString *, id> *)demandDictionary;

@end

@interface VASVerizonSSPWaterfallItemSuperAuction : VASVerizonSSPWaterfallItemMediation

@property (readonly, weak) VASVerizonSSPWaterfall *waterfall;
@property (nullable, readonly) VASVerizonSSPSuperAuctionBidder *winningBidder;
@property (readonly, copy) NSArray<VASVerizonSSPSuperAuctionDemandSource *> *demandSources;

- (instancetype)initWithResponseDictionary:(NSDictionary<NSString *, id> *)playlistEntry
                                 waterfall:(nullable VASVerizonSSPWaterfall *)waterfall
                                    vasAds:(VASAds *)vasAds
                           HTTPURLResponse:(nullable NSHTTPURLResponse *)response;

- (nullable VASBid *)createBid:(VASAdSession *)adSession;

@end

NS_ASSUME_NONNULL_END
