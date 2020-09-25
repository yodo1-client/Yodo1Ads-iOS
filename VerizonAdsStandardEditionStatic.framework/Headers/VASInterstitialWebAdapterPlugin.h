///
///  @file
///  @brief Definitions for VASInterstitialWebAdapterPlugin.
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Interstitial Web Adapter plugin.
 */
@interface VASInterstitialWebAdapterPlugin: VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
