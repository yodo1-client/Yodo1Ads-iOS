///
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallProviderErrors.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSErrorDomain const kVASVerizonSSPWaterfallProviderErrorDomain;

/// Error codes that are used in the VASVerizonSSPWaterfallProvider error domain. Check the underlying error for possible additional errors indicating the cause of the parsing error.
typedef NS_ENUM(NSInteger, VASVerizonSSPWaterfallProviderError) {
    /// An error was encountered while parsing the ad content.
    VASVerizonSSPWaterfallProviderErrorInvalidBid = 1,
    VASVerizonSSPWaterfallProviderErrorNoValidWaterfalls = 2,
    VASVerizonSSPWaterfallProviderErrorNoContentReturned = 3,
    VASVerizonSSPWaterfallProviderErrorBuildingPlaylistRequest = 4,
    VASVerizonSSPWaterfallProviderErrorNoDemandSources = 5,
    VASVerizonSSPWaterfallProviderErrorNoBids = 6,
    VASVerizonSSPWaterfallProviderErrorSerializingRequest = 7,
    VASVerizonSSPWaterfallProviderErrorBidExpired = 8,
    VASVerizonSSPWaterfallProviderErrorAdRequestFailed = 9
};

// Error convenience methods.
VASErrorInfo * VerizonSSPWaterfallProviderSerializingRequestError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderBidExpiredError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderInvalidBidError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderNoValidWaterfallsError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderNoContentReturnedError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderBuildingPlaylistRequestError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderNoDemandSourcesError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderNoBidsError(NSError * _Nullable underlying);
VASErrorInfo * VerizonSSPWaterfallProviderAdRequestFailed(void);
NS_ASSUME_NONNULL_END
