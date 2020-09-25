///
/// @internal
/// @file
/// @brief Internal definitions for VASCore VASWaterfallResult.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASWaterfallResult.h>

NS_ASSUME_NONNULL_BEGIN

@class VASWaterfall;

@interface VASWaterfallResult (Internal)

/// Internal redefinition to readwrite.
@property VASErrorInfo *errorInfo;

/// Internal redefinition to readwrite.
@property NSTimeInterval elapsedTime;

/**
 @param waterfall   The VASWaterfall object associated with the request.
 @param bid         The bid info or null if the waterfall is not super auction.
 @return an instance of this class.
 */
- (instancetype)initWithWaterfall:(id<VASWaterfall>)waterfall
                              bid:(nullable VASBid *)bid;

/**
 Add an VASWaterfallItemResult object to waterfallItemResults.
 
 @param waterfallItemResult The VASWaterfallItemResult object to add.
 */
- (void)addWaterfallItemResult:(VASWaterfallItemResult *)waterfallItemResult;

@end

NS_ASSUME_NONNULL_END
