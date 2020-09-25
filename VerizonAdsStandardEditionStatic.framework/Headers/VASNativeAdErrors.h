///
/// @file
/// @brief Definitions for errors declared in this plugin.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

/// VASNativeAd error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASNativeAdErrorDomain;

/// Error codes that are used by VASErrorInfo in the VASNativeAd error domain.
typedef NS_ENUM(NSInteger, VASNativeAdError) {
    /// The native ad has expired.
    VASNativeAdErrorAdExpired = 1,
};

// Error convenience methods.
VASErrorInfo * NativeAdAdExpiredError(void);

NS_ASSUME_NONNULL_END
