///
/// @file
/// @brief Definitions for VASStandardEdition
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASAds.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Contains APIs specific to the packaging of the Standard Edition, such as initializing the edition.
 */
@interface VASStandardEdition (Private)

// The logger class used.
+ (VASLogger *)logger;

/**
Initialize the SDK for use with a  specific site ID and VASAds.
This method must be called before using any other components of the SDK.
This method must be called on the main thread.

@param siteId The site ID.
@param vasAds The VASAds object to be used.
@return `YES` if initialized successfully, `NO` otherwise.
*/
+ (BOOL)initializeWithSiteId:(NSString *)siteId VASAds:(VASAds *)vasAds;

/**
Initialize the Flurry Anlaytics.

@param vasAds The VASAds object to be used.
@return `YES` if initialized successfully, `NO` otherwise.
*/
+ (BOOL)initializeFlurryAnalyticsWithVASAds:(VASAds *)vasAds;

/**
Get the Flurry Analytics API key from the VASAds Configuration.

@param vasAds The VASAds object to be used.
@return Flurry Analytics API key.
*/
+ (nullable NSString *)flurryAPIKeyFromVASAds:(VASAds *)vasAds;

/**
Get the Flurry Analytics GDPR scope from the VASAds Configuration.

@param vasAds The VASAds object to be used.
@return GDPR scope.
*/
+ (nullable NSNumber *)isGDPRScopeFromVASAds:(VASAds *)vasAds;

/**
Get the GDPR consent map from the VASAds Configuration.

@param vasAds The VASAds object to be used.
@return GDPR consent map.
*/
+ (nullable NSDictionary<NSString *, NSString *> *)gdprConsentMapFromVASAds:(VASAds *)vasAds;

/**
Get the Flurry Analytics data sale opt out value from VASAds Configuration .

@param vasAds The VASAds object to be used.
@return Data sale opt out value.
*/
+ (BOOL)dataSaleOptOutFromVASAds:(VASAds *)vasAds;

@end

NS_ASSUME_NONNULL_END
