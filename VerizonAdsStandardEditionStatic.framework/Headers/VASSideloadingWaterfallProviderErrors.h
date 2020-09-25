///
/// @file
/// @brief Definitions for VASSideloadingWaterfallProviderErrors.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVASSideloadingWaterfallProviderErrorDomain;

/// Error codes that are used in the VASSideloadingWaterfallProvider error domain. Check the underlying error for possible additional errors indicating the cause of the parsing error.
typedef NS_ENUM(NSInteger, VASSideloadingWaterfallProviderError) {
    /// An error was encountered while requesting the ad.
    VASSideloadingWaterfallProviderErrorAdRequestFailed = 1
};

// Error convenience methods.
VASErrorInfo * SideloadingWaterfallProviderAdRequestFailed(NSString *description);

NS_ASSUME_NONNULL_END
