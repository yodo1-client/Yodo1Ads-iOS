///
/// @internal
/// @file
/// @brief Definitions for VASSideloadingWaterfallProvider.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

@class VASTestWaterfall;

@interface VASSideloadingWaterfallProviderFactory : NSObject <VASComponentFactory>
@end

@interface VASSideloadingWaterfallProvider : VASWaterfallProvider

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
