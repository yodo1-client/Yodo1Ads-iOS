///
/// @file
/// @brief Defintions for VASOMSDKPlugin
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import "VASOpenMeasurement.h"

NS_ASSUME_NONNULL_BEGIN

/**
 The Verizon Ads interface to the Open Measurement SDK.
 */
@interface VASOMSDKPlugin : VASPlugin

/// Will be nil if the plugin is disabled or until after the prepare method successfully completes.
@property (readonly, nullable) VASOpenMeasurement *openMeasurement;

- (instancetype)init;

- (NSString *)version;

@end

NS_ASSUME_NONNULL_END
