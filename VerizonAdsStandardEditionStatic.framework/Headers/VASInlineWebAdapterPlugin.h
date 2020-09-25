///
/// @file
/// @brief Definitions for VASInlineWebAdapterPlugin
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASAds.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The Inline Web Adapter plugin.
 */
@interface VASInlineWebAdapterPlugin : VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
