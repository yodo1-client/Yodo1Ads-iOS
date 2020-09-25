///
/// @internal
/// @file
/// @brief Defintions for VASVerizonSSPConfigProviderKeys.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// These are the config keys used when writing to Core vasAds.configuration
// Mapping bewteen SSP Response keys and these config keys is defined here: https://docs.google.com/spreadsheets/d/1yqgQOv0KndzLG4apd-vCpSIws4Ij5_JYUp_3GQh-onE/edit#gid=2106295321

// Config Keys
FOUNDATION_EXPORT NSString * const kVASWaterfallProviderClassKey;
FOUNDATION_EXPORT NSString * const kVASHandshakeBaseUrlKey;
FOUNDATION_EXPORT NSString * const kVASReportingBaseUrlKey;
FOUNDATION_EXPORT NSString * const kVASGeoIpCheckUrlKey;
FOUNDATION_EXPORT NSString * const kVASLocationRequiresConsentKey;

FOUNDATION_EXPORT NSString * const kVASSdkEnabledKey;
FOUNDATION_EXPORT NSString * const kVASVersionKey;
FOUNDATION_EXPORT NSString * const kVASInlineAdExpirationTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASInterstitialAdExpirationTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASNativeAdExpirationTimeoutKey;

FOUNDATION_EXPORT NSString * const kVASMinInlineRefreshIntervalKey;
FOUNDATION_EXPORT NSString * const kVASMinImpressionViewabilityPercentKey;
FOUNDATION_EXPORT NSString * const kVASMinImpressionDurationKey;
FOUNDATION_EXPORT NSString * const kVASReportingBatchFrequencyKey;
FOUNDATION_EXPORT NSString * const kVASReportingBatchSizeKey;

FOUNDATION_EXPORT NSString * const kVASInlineAdRequestTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASInterstitialAdRequestTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASNativeAdRequestTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASClientMediationRequestTimeoutKey;

FOUNDATION_EXPORT NSString * const kVASStoreKitOpenTimeoutKey;

FOUNDATION_EXPORT NSString * const kVASVastSkipRuleKey;
FOUNDATION_EXPORT NSString * const kVASVastSkipOffsetMaxKey;
FOUNDATION_EXPORT NSString * const kVASVastSkipOffsetMinKey;

FOUNDATION_EXPORT NSString * const kVASConfigKey;
FOUNDATION_EXPORT NSString * const kVASOmsdkEnabledKey;

FOUNDATION_EXPORT NSString * const kVASVpaidStartAdTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASVpaidSkipAdTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASVpaidAdUnitTimeoutKey;
FOUNDATION_EXPORT NSString * const kVASVpaidHtmlEndCardTimeoutKey;

FOUNDATION_EXPORT NSString * const kVASAutoPlayAudioEnabled;

NS_ASSUME_NONNULL_END
