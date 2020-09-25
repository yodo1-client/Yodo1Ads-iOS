///
/// @internal
/// @file
/// @brief Definitions for VASSideloadingWaterfallItem.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

// An abstract base class for the variety of Sideloading waterfall item types.
@interface VASSideloadingWaterfallItem : NSObject <VASWaterfallItem>

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithValue:(NSString *)value requestMetadata:(nullable NSDictionary<NSString*, id> *)requestMetadata;

@end

NS_ASSUME_NONNULL_END

