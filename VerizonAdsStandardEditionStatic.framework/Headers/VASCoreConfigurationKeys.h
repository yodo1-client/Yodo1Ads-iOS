///
/// @file
/// @brief Definitions for VASCore VASCoreConfigurationKeys.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

/// Configuration domain used for VASAds core internal configuration values.
extern NSString * const kVASConfigurationCoreDomain;

/// `kVASConfigurationCoreDomain` Privacy Keys

/// Key for a boolean indicating if user privacy should remain anonymous. This value represents the evaluation of the combined keys: `kVASConfigUserConsentDataKey`, `kVASConfigLocationRequiresConsentKey`, and `kVASConfigUserRestrictedOriginKey`. Default is YES indicating that as an anonymous user, no personally-identifiable information will be sent.
/// Subscribing to this key through `VASEvents` `subscribeReceiver:` will allow changes in privacy to be immediately notified.
/// Configuration data is a boolean indicating the user anonymity as specified.
extern NSString * const kVASConfigAnonymousUserKey;  // BOOL

/// Key for a boolean indicating if the user resides in a country/region governed by privacy regulations. Will be NO if the user does not reside in such a region or a nil underlying object indicates it has not been specified and defaults to NO.
/// Configuration data is an NSNumber object containing a boolean value as specified.
extern NSString * const kVASConfigUserRestrictedOriginKey;  // NSNumber<BOOL>

/// Key for a dictionary of privacy data specified by the app via the `setPrivacyData:` method. Will be nil if not specified.
/// Configuration data is an NSDictionary object as specified.
extern NSString * const kVASConfigUserPrivacyDataKey;  // NSDictionary<NSString *, id>

/// Key for a boolean value indicating if the user's IP address resides within a region that is governed by privacy regulations. If the object is nil, then the location consent requirement has not yet been determined.
/// Configuration data is an NSNumber object containing a boolean value indicating consent as specified.
extern NSString * const kVASConfigLocationRequiresConsentKey;  // NSNumber<BOOL>

/// Key for specifying the IAB consent data.
/// Configuration data is an NSString object of the IAB consent text.
extern NSString * const kVASConfigIABConsentKey;   // NSString

/// Key for specifying the SDK Enabled.
/// Configuration data is a NSNumber object containing a boolean value indicating SDK is enabled.
extern NSString * const kVASConfigSdkEnabled;   // NSNumber<BOOL>

/// Key for default waterfall provider.
extern NSString * const kVASConfigDefaultWaterfallProviderKey; // NSString
