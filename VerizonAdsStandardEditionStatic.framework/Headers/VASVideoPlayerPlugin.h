//
//  @file
//  @brief Definitions for VASVideoPlayerPlugin.
//
//  @copyright Copyright (c) 2018 Verizon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 The VideoPlayer plugin.
 */
@interface VASVideoPlayerPlugin : VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
