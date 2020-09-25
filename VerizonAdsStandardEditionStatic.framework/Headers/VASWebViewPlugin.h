//
//  @file
//  @brief Definitions for VASWebViewPlugin.
//
//  @copyright Copyright (c) 2018 Verizon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

/**
 WebView plugin.
 */

@interface VASWebViewPlugin: VASPlugin

- (instancetype)init;

- (nonnull NSString *)version;

@end

NS_ASSUME_NONNULL_END
