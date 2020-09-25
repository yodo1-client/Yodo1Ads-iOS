//
//  @file
//  @brief Definitions for VASVASTControllerPlugin.
//
//  @copyright Copyright (c) 2018 Verizon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VAST Controller plugin.
 */
@interface VASVASTControllerPlugin : VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
