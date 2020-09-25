///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallProviderKeys.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// keys, defined here: https://docs.google.com/spreadsheets/d/1jsDG3NRlmvek0EaFcU07yfHK-7iYDrkqBJEHtg0sVbs/edit#gid=473725698 1M Waterfall Request/Response API

extern NSString * const kVASPlaylistVersionKey;

// config
extern NSString * const kDomainVASAds;
extern NSString * const kDomainVASVerizonSSP;

extern NSString * const kVASExchangeRequestTimeoutKey;        // NSNumber<NSUInteger> milliseconds
extern NSString * const kVASServerMediationRequestTimeoutKey; // NSNumber<NSUInteger> milliseconds
extern NSString * const kVASWaterfallProviderBaseUrlKey;
extern NSString * const kVASBidExpirationTimeoutKey;           // NSNumber<NSUInteger> milliseconds

extern NSString * const kVASVerizonSSPConfigWinURLTimeoutKey;  // NSNumber<NSUInteger> milliseconds
extern NSString * const kVASEditionNameKey;
extern NSString * const kVASEditionVersionKey;

// appInfo
extern NSString * const kVASAppInfoKey;
extern NSString * const kVASAppIdKey;
extern NSString * const kVASDisplayNameKey;
extern NSString * const kVASAppVersionKey;      // NSString (Info.plist CFBundleVersion)
extern NSString * const kVASCoppaKey;

// sdkInfo
extern NSString * const kVASSDKCoreVersionKey;
extern NSString * const kVASSDKEditionIdKey;

// environmentInfo
extern NSString * const kVASEnvInfoKey;
extern NSString * const kVASOSTypeKey;
extern NSString * const kVASOSVersionKey;
extern NSString * const kVASOSBuildKey;         // NSString
extern NSString * const kVASModelKey;
extern NSString * const kVASModelNameKey;       // NSString
extern NSString * const kVASModelManufacturerKey;   // NSString
extern NSString * const kVASUAKey;
extern NSString * const kVASIPKey;
extern NSString * const kVASAdvertisingIdKey;
extern NSString * const kVASLimitAdTrackingKey;
extern NSString * const kVASLanguageKey;
extern NSString * const kVASCountryKey;
extern NSString * const kVASSDKInfoKey;
extern NSString * const kVASSDKVersionKey;
extern NSString * const kVASScreenWidthKey;
extern NSString * const kVASScreenHeightKey;
extern NSString * const kVASScreenScaleKey;
extern NSString * const kVASNaturalOrientationKey;
extern NSString * const kVASBatteryChargingKey;
extern NSString * const kVASBatteryLevelKey;
extern NSString * const kVASAvailableStorageKey;
extern NSString * const kVASConnectionTypeKey;
extern NSString * const kVASNetworkCarrierKey;
extern NSString * const kVASMCCKey;
extern NSString * const kVASMNCKey;
extern NSString * const kVASSecureContentKey;

// CoreLocation
// Location attributes within EnvironmentInfo kVASEnvInfoKey waterfall request metadata.
extern NSString * const kVASLocationKey;                 // NSDictionary<NSString, id>
extern NSString * const kVASLocationTimeStampKey;        // NSDate
extern NSString * const kVASLocationHorizAccKey;         // Double
extern NSString * const kVASLocationVertAccKey;          // Double
extern NSString * const kVASLocationLatKey;              // Double
extern NSString * const kVASLocationLongKey;             // Double
extern NSString * const kVASLocationSpeedKey;            // Double
extern NSString * const kVASLocationAltitudeKey;         // Double
extern NSString * const kVASLocationBearingKey;          // Double
extern NSString * const kVASLocationSourceKey;           // kVASLocationSourceCoreLocation

// requestInfo
extern NSString * const kVASReqInfoKey;
extern NSString * const kVASReqInfoCoppaKey;
extern NSString * const kVASCoppaKey;
extern NSString * const kVASCurrentOrientationKey;
extern NSString * const kVASReqInfoDOBKey;
extern NSString * const kVASKeywordsKey;
extern NSString * const kVASMediatorKey;

extern NSString * const kVASPlacementIdKey;
extern NSString * const kVASPlacementTypeKey;
extern NSString * const kVASPlacementTypeAttributesKey;
extern NSString * const kVASPlacementAdSizesKey;
extern NSString * const kVASPlacementWidthKey;
extern NSString * const kVASPlacementHeightKey;
extern NSString * const kVASPlacementNativeTypeKey;

extern NSString * const kVASDCNKey;

extern NSString * const kVASSupportedAdOrientationsKey;
extern NSString * const kVASPlacementRefreshKey;
extern NSString * const kVASImpressionGroupKey;
extern NSString * const kVASTargetingKey;
extern NSString * const kVASGDPRKey;
extern NSString * const kVASCCPAKey;
extern NSString * const kVASConsentDataKey;
extern NSString * const kVASCPrivacyMapKey;
extern NSString * const kVASCConsentMapKey;
extern NSString * const kVASCCPAKey;
extern NSString * const kVASUSPrivacyDataKey;

// Device Features
extern NSString * const kVASDeviceFeaturesKey;
extern NSString * const kVASSupportsCameraFrontKey;
extern NSString * const kVASSupportsCameraRearKey;
extern NSString * const kVASSupportsMicKey;
extern NSString * const kVASSupportsGPSKey;
extern NSString * const kVASSupportsBluetoothKey;

extern NSString * const kVASHeadphonesPluggedKey;
extern NSString * const kVASDeviceVolumeKey;
extern NSString * const kVASAccessPointMacKey;
extern NSString * const kVASSDKPlugInsKey;

extern NSString * const kVASPlugInOpenGLBeta;
extern NSString * const kVASPlugInNativeBeta;
extern NSString * const kVASPlugInSupaVastBeta;

extern NSString * const kVASSupportedAdFormatWeb;
extern NSString * const kVASSupportedAdFormatNative;
extern NSString * const kVASSupportedAdFormatWeb;

// Ad formats
extern NSString * const kVASAdFormatTypeWeb;
extern NSString * const kVASAdFormatTypeNative;

// User data
extern NSString * const kVASUserInfoKey;

// Super Auction
extern NSString * const VASDemandSourceClientDemandType;
extern NSString * const VASDemandSourceServerDemandType;
extern NSString * const VASDemandSourceContentType;

// Plugins
extern NSString * const VASPluginNameKey;
extern NSString * const VASPluginVersionKey;
extern NSString * const VASPluginAuthorKey;
extern NSString * const VASPluginMinAPILevelKey;
extern NSString * const VASPluginEmailKey;
extern NSString * const VASPluginWebsiteKey;
extern NSString * const VASPluginEnabledKey;

// Testing keys
extern NSString * const kVASTestingKey;

NS_ASSUME_NONNULL_END
