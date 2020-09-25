///
/// @file
/// @brief Definitions for VASNativeAd+Private.h
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VASCommon.h>
#import <VerizonAdsStandardEditionStatic/VASNativeAdAdapter.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASNativeAd (Private)

// VASAds object used for initialization.
@property (readonly) VASAds *vasAds;

@end

NS_ASSUME_NONNULL_END
