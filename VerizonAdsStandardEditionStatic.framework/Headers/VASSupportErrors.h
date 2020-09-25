///
/// @file
/// @brief Definitions for errors declared in this component.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

/// VASNativeAd error domain.
FOUNDATION_EXPORT NSErrorDomain const kVASSupportErrorDomain;

/// Error codes that are used by VASErrorInfo in the VAS Support error domain.
typedef NS_ENUM(NSInteger, VASSupportError) {
    /// The native ad has expired.
    VASSupportErrorTimeout = 1,
    /// Loading the resource data failed.
    VASSupportErrorLoadingResources,
    /// The resource loading was aborted.
    VASSupportErrorAbort,
};

// Error convenience methods.
VASErrorInfo * VASSupportErrorForTimeout(NSString *timeoutMsg);
VASErrorInfo * VASSupportLoadingResourcesError(NSString *reason, NSError * _Nullable underlyingError);
VASErrorInfo * VASSupportAbortError(NSString *feature);

NS_ASSUME_NONNULL_END
