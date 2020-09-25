///
/// @file
/// @brief Definitions for VASInlineWebAdapterErrors.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

/// Error domain for VASInlineWebAdapter.
FOUNDATION_EXPORT NSErrorDomain const kVASInlineWebAdapterErrorDomain;

/// Error codes that are used in the VASInlineWebAdapter error domain. Check the underlying error for possible additional errors that may help indicate the root cause of the error.
typedef NS_ENUM(NSInteger, VASInlineWebAdapterError) {
    VASInlineWebAdapterErrorIncorrectState = 1,
    VASInlineWebAdapterErrorUnexpectedClass,
    VASInlineWebAdapterErrorMissingMetadata
};

NS_ASSUME_NONNULL_END
