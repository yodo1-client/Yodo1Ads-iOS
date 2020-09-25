///
/// @file
/// @brief Error code definitions.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

/// The domain for VASAds core errors.
FOUNDATION_EXPORT NSErrorDomain const kVASCoreErrorDomain;

/// Error codes that are used by VASErrorInfo in the core error domain.
typedef NS_ENUM(NSInteger, VASCoreError) {
    /// A feature is not yet implemented.
    VASCoreErrorNotImplemented = 1,
    /// An ad adapter was not found.
    VASCoreErrorAdAdapterNotFound,
    /// No ads were available.
    VASCoreErrorAdNotAvailable,
    /// Unable to fetch the content for an ad.
    VASCoreErrorAdFetchFailure,
    /// Unable to prepare an ad for use.
    VASCoreErrorAdPrepareFailure,
    /// An unexpected waterfall failure occurred.
    VASCoreErrorWaterfallFailure,
    /// No bids were available.
    VASCoreErrorBidsNotAvailable,
    /// A timeout occurred.
    VASCoreErrorTimeout,
    /// An unexpected server error occurred.
    VASCoreErrorUnexpectedServerError,
    /// A server returned a bad response.
    VASCoreErrorBadServerResponseCode,
    /// A plugin was not enabled when it was expected to be.
    VASCoreErrorPluginNotEnabled
};

