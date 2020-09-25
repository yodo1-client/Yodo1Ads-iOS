//
//  @file
//  @brief Definitions for VASNativePlacementPlugin.
//
//  @copyright Copyright (c) 2018 Verizon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Native Placement plugin.
 */
@interface VASNativePlacementPlugin : VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
