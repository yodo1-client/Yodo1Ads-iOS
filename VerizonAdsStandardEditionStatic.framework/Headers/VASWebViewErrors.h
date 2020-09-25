///
/// @file
/// @brief WebView Error code definitions.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

/// The domain for VASWebView errors.
FOUNDATION_EXPORT NSErrorDomain const kVASWebViewErrorDomain;

/// Error codes that are used by VASErrorInfo in the VASWebView error domain.
typedef NS_ENUM(NSInteger, VASWebViewError) {
    /// The provided HTML string was nil.
    VASWebViewErrorNilHTMLString = 1,
    /// The provided data was nil.
    VASWebViewErrorNilData,
    /// The returned data was invalid.
    VASWebViewErrorInvalidData,
    /// The method requires iOS 9+.
    VASWebViewErrorRequiresiOS9,
    /// An error during loading occurred.
    VASWebViewErrorLoading,
    /// An error during navigation (clicks, etc) occurred.
    VASWebViewErrorNavigation,
};

