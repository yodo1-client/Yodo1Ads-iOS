///
/// @file
/// @brief Definitions for VASWaterfall.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASWaterfallItem.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol for providing essential data to the Core waterfall processor.
 */
@protocol VASWaterfall <NSObject>

/// The waterfall metadata returned from the server.
@property (readonly, nullable) NSDictionary<NSString *, id> *metadata;

/// Called by the SDK core to get the list of items in the waterfall. 
@property (readonly, nullable) NSArray<id<VASWaterfallItem>> *waterfallItems;

@end

NS_ASSUME_NONNULL_END
