///
///  @file
///  @brief Definitions for VASInterstitialVASTAdapterPlugin.
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASAds.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Interstitial VAST ad adapter plugin.
 */
@interface VASInterstitialVASTAdapterPlugin : VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
