///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallProvider.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASBid.h"
#import "VASComponentFactory.h"
#import "VASCreativeInfo.h"

NS_ASSUME_NONNULL_BEGIN

@class VASVerizonSSPWaterfall;
@class VASVerizonSSPSuperAuctionDemandSource;
@class VASVerizonSSPSuperAuctionBidder;
@class VASBid;


@interface VASVerizonSSPBid : VASBid

@property (nullable, readonly) VASVerizonSSPWaterfall *waterfall;
@property (nullable, readonly, copy) NSArray<VASVerizonSSPSuperAuctionDemandSource *> *demandSources;
@property (nullable, readonly) VASVerizonSSPSuperAuctionBidder *bidderItem;
@property (nullable, readonly, copy) NSString *winURL;
@property (readonly) NSDate *bidCreationTime;
@property (nullable, readonly, copy) NSString *itemId;
@property (nullable, readonly, copy) NSDictionary<NSString *, id> *adSize;

- (instancetype)initWithAdSession:(VASAdSession *)adSession
                        waterfall:(VASVerizonSSPWaterfall *)waterfall
                    demandSources:(NSArray<VASVerizonSSPSuperAuctionDemandSource *> *)demandSources
                       bidderItem:(VASVerizonSSPSuperAuctionBidder *)bidderItem
                            value:(NSString *)value
                           winURL:(NSString *)winURL
                  bidCreationTime:(NSDate *)bidCreationTime
                           itemId:(NSString *)itemId
                           adSize:(NSDictionary<NSString *, id> *)adSize;

@end

@interface VASVerizonSSPWaterfallProviderFactory : NSObject <VASComponentFactory>

@end

@interface VASVerizonSSPWaterfallProvider : VASWaterfallProvider

// All waterfallItem types are loaded at launch allowing post-launch registry usage to be thread-safe.
@property (class, readonly) NSDictionary<NSString *, Class> *registeredWaterfallItemsByType;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

+ (void)registerWaterfallItemClass:(Class)class forItemType:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
