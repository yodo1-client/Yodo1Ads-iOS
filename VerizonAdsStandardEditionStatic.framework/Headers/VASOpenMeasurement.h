///
/// @file
/// @brief Definitions of VASOpenMeasurement
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OMIDOathPartner;

/// The default setting for enabling the OpenMeasurement SDK when present.
extern BOOL const kOMSDKEnabledDefault;

/**
 Simple class to manage a couple Open Measurement SDK functions. The object `init` method must be called on the main thread.
 */
@interface VASOpenMeasurement : NSObject

/// The Verizon partner object to be used when creating OM sessions.
@property (readonly) OMIDOathPartner *partner;

/// OM SDK JS script to be used when creating OM sessions.
@property (readonly) NSString *omsdkjs;

/**
 Call this method before OM calls to ensure the initial activation has occurred and to check for current VASAds Configuration enabling, kVASConfigurationOpenMeasureDomain domain, kVASConfigOpenMeasureEnabledKey key.
 @param vasAds     The instance to use to check configuration status.
 @return YES if OM is enabled and activated for use. If NO, then no OM calls should be made.
 */
- (BOOL)activatedUsingVASAds:(VASAds *)vasAds;

/**
 Inject the Open Measurement JS into the specified `html`. If the OpenMeasurement SDK has not been activated or any error occurs, the original html will be returned unmodified.
 @param html The web page HTML that requires the OpenMeasurement JS.
 @param vasAds An instance of VASAds to use to verify configuration-enabled.
 @return an HTML string that has the injected OM JS.
 */
+ (NSString *)injectIntoHTML:(NSString *)html usingVASAds:(VASAds *)vasAds;

@end

NS_ASSUME_NONNULL_END
