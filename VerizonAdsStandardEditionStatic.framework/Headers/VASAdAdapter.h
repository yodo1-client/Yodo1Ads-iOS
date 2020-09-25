///
/// @file
/// @brief Definitions for VASAdAdapter.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdContent.h>
#import <VerizonAdsStandardEditionStatic/VASAdSession.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol for interacting with an ad adapter.
 
 Note that the VASAdAdapter object is instantiated by the VASWaterfallProcessor. It requires that the concrete class implementation has one of these init methods in priority order:
 
 // If a network connection is required, the NSURLSession can be provided to allow for custom network handling such as mock NSURLSession objects for debugging/testing. This will be the NSURLSession object used to instantiate the current VASAds object, or if it was instantiated with nil, will use [NSURLSession sharedSession].
 - (instancetype)initWithSession:(NSURLSession *)session;
 
 // If more properties or functionality from the current VASAds object is needed, it can be provided in your initializer.
 - (instancetype)initWithVASAds:(VASAds *)vasAds;
 
 // The final init if the others are not implemented.
 - (instancetype)init;
 
 */
@protocol VASAdAdapter <NSObject>

/**
 Prepare an instance of an ad adapter. This is executed on an arbitrary background queue and may block for any necessary preparation but must be completed within the limits of the timeout set by the `VASAds.h requestAdsForRequestorClass` specified timeout. If that request timeout occurs, then the results of this call will be ignored.
 
 @param adContent   Ad content data.
 @param adSession   VASAdSession object associated with this ad content.
 @return a VASErrorInfo if an error occurred while preparing content, or nil if content was prepared successfully.
 */
- (nullable VASErrorInfo *)prepareWithAdContent:(VASAdContent *)adContent
                                 usingAdSession:(VASAdSession *)adSession;

/// The content used to prepare the ad.
@property (readonly, nullable) VASAdContent *adContent;

@end

NS_ASSUME_NONNULL_END
