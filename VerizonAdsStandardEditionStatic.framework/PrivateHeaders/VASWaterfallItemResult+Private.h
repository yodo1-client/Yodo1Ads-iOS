///
/// @internal
/// @file
/// @brief Internal definitions for VASCore VASWaterfallItemResult.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASWaterfallItemResult.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VASWaterfallItem;

@interface VASWaterfallItemResult (Internal)

/// Internal redefinition of this property to readwrite.
@property (readwrite, nullable) VASErrorInfo *errorInfo;

/// Internal redefinition of this property to readwrite.
@property (readwrite) NSTimeInterval elapsedTime;

/**
 @param waterfallItem The waterfall item associated with the request.
 @return an instance of this class.
 */
- (instancetype)initWithWaterfallItem:(id<VASWaterfallItem>)waterfallItem startTime:(nullable NSDate *)startTime;
;

@end

NS_ASSUME_NONNULL_END
