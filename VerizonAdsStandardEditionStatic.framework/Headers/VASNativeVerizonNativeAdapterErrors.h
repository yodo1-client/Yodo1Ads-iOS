///
/// @file
/// @brief Definitions for errors declared in this plugin.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVASNativeVerizonControllerErrorDomain;

/// Error codes that are used in the NativVerizonControllerErrorDomain error domain. Check the underlying error for possible additional errors indicating the cause of the parsing error.
typedef NS_ENUM(NSInteger, VASNativeVerizonNativeAdapterError) {
    /// An error was encountered while parsing the ad content.
    VASNativeVerizonNativeAdapterErrorPreparingContent = 1,
};

// Error convenience methods.
VASErrorInfo * NativeVerizonNativeAdapterPreparingContentError(NSString *reason);

NS_ASSUME_NONNULL_END
