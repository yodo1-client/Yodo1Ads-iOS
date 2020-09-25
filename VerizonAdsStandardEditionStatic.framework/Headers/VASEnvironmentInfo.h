///
/// @file
/// @brief Definitions for VASEnvironmentInfo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

@class VASAds;
@class CLLocation;
@class CLLocationManager;
@class CTCarrier;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kVASEnvInfoNetworkTypeUnavailable;
extern NSString * const kVASEnvInfoNetworkTypeUnreachable;
extern NSString * const kVASEnvInfoNetworkTypeWiFi;
extern NSString * const kVASEnvInfoNetworkTypeWWAN;

extern NSString * const kVASEnvInfoOrientationPortrait;
extern NSString * const kVASEnvInfoOrientationLandscape;

extern NSString * const kVASDeviceManufacturer; // @"Apple"

#pragma mark VASEnvironmentInfoBattery

/**
 A snapshot of battery state information.
 */
@interface VASEnvironmentInfoBattery : NSObject
/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/// Battery level (0.0 to 1.0).
@property (readonly) CGFloat level;

/// Battery charging state. `YES` when plugged in and charging or full, `NO` otherwise.
@property (readonly, getter=isCharging) BOOL charging;

@end


#pragma mark VASEnvironmentInfoNetwork

/**
 A snapshot of network connection state.
 */
@interface VASEnvironmentInfoNetwork : NSObject
/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Network connection type (e.g., kVASEnvInfoNetworkTypeWiFi, kVASEnvInfoNetworkTypeWWAN).
 May be `kVASEnvInfoNetworkTypeUnavailable` if unavailable or `kVASEnvInfoNetworkTypeUnreachable` if unreachable.
 */
@property (readonly) NSString *connectionType;

/**
 Radio technology such as GPRS, Edge, WCDMA, LTE. May be `nil` if device is not registered on any network.
 See `CTTelephonyNetworkInfo.currentRadioAccessTechnology` for more info.
 */
@property (readonly) NSString *radioAccessTechnology;

/**
 Network carrier that includes the `name`, `mobileCountryCode`, `mobileNetworkCode`, and a couple other properties.
 See `CTTelephonyNetworkInfo.subscriberCellularProvider` for more info.
 */
@property (readonly, nullable) CTCarrier *carrier;

@end


#pragma mark VASEnvironmentInfo

/**
 A utility that provides environment information. The main utility being provided is wrapping some calls that require some special treatment and
 respecting the privacy indicator (`isAnonymous`) by not returning values that are not allowed when anonymous mode is enabled.
 <br/>
 Note that some properties must be accessed on the main thread. Any properties subject to this include a comment indicating so.
 */
@interface VASEnvironmentInfo : NSObject
/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

#pragma mark Class Properties - Not Blocked in Anonymous Mode

/// The SDK version.
@property (class, readonly) NSString *sdkVersion;

/// The operating system version (e.g., "11.4"). Must be called on the main thread (see class comments).
@property (class, readonly) NSString *osVersion;

/// The OS build number (e.g., 17C54 representing the release build of iOS 13.3).
@property (class, readonly, nullable) NSString *osBuildNumber;

/// Specifies that returned content must use a secure transport (HTTPS).
@property (class, readonly, getter=isSecureTransportEnabled) BOOL secureTransportEnabled;

/// Web view (WebKit) user agent string.
@property (class, readonly) NSString *userAgent;

/// Indicates if ad tracking is limited or not. `YES` if tracking is limited, `NO` otherwise.
@property (class, readonly) BOOL limitAdTracking;

/// Device country locale code (ISO 3166-1).
@property (class, readonly) NSString *country;

/// Device preferred language code (ISO 639-1).
@property (class, readonly) NSString *language;

/// Screen size (including `width` and `height`). Must be called on the main thread (see class comments).
@property (class, readonly) CGSize screenSize;

/// Screen scale. Must be called on the main thread (see class comments).
@property (class, readonly) CGFloat screenScale;


#pragma mark Instance Properties - Blocked in Anonymous Mode

/// Natural orientation. Returns kVASEnvInfoOrientationPortrait for either `UIInterfaceOrientationPortrait` or `UIInterfaceOrientationPortraitUpsideDown` or returns kVASEnvInfoOrientationLandscape for either `UIInterfaceOrientationLandscapeLeft` or `UIInterfaceOrientationLandscapeRight`. Returns nil until the VASAds SDK is initialized via initializeWithSiteId.
@property (readonly, nullable) NSString *naturalOrientation;

/// Current orientation. Returns kVASEnvInfoOrientationPortrait for either `UIInterfaceOrientationPortrait` or `UIInterfaceOrientationPortraitUpsideDown` or returns kVASEnvInfoOrientationLandscape for either `UIInterfaceOrientationLandscapeLeft` or `UIInterfaceOrientationLandscapeRight`. Returns nil until the VASAds SDK is initialized via initializeWithSiteId.
@property (readonly, nullable) NSString *currentOrientation;

/// Returns kVASEnvInfoOrientationPortrait and/or kVASEnvInfoOrientationLandscape based on the values in the `UISupportedInterfaceOrientations` or `UISupportedInterfaceOrientations~ipad` entries in the main bundle Info.plist. Returns nil until the VASAds SDK is initialized via initializeWithSiteId.
@property (readonly, nullable) NSArray<NSString *> *supportedOrientations;

/**
 Current battery info (level and charging state). This is obtained in one call because monitoring has to be enabled to read battery state.
 Must be called on the main thread.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) VASEnvironmentInfoBattery *batteryInfo;

/**
 Current network info (connection type, radio technology, carrier info). This is obtained in one call because they use related system calls.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) VASEnvironmentInfoNetwork *networkInfo;

/**
 The most recent location info.
 May be `nil` if it has not yet been retrieved, location could not be determined, location services are disabled for the device or for the app, blocked while in anonymous mode, or explicitly disabled by the VASAds `locationEnabled` flag.
 */
@property (readonly, nullable) CLLocation *locationInfo;

/**
 Internal device model identifier (e.g. "iPhone10,3" represents an iPhone X).
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) NSString *model;

/**
 The device model name (e.g. "iPhone", "iPod touch", etc.).
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
*/
@property (readonly, nullable) NSString *modelName;

/**
 Device advertising ID. Note that in iOS 10.0 and later, the value of advertisingIdentifier is all zeroes when the user has enabled limited ad tracking.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) NSString *advertisingId;

/**
 Device IP address (IPv4 or IPv6).
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) NSString *ipAddress;

/**
 Available device storage (in bytes). This is the boxed value from `NSFileSystemFreeSize`.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable) NSNumber *availableStorage;

/**
 Global output volume (that can only be set by the user) with adjustments according to various factors such as category and audio route. Some categories cannot be determined when accounting for the ringer/silent switch and returns nil. This is a boxed `float` value from (0.0 to 1.0) or nil if the volume is indeterminate or while anonymous.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, indeterminate, or when blocked in anonymous mode.
 */
@property (readonly, nullable) NSNumber *outputVolume;

/**
 Indicates if headphones are present (plugged in). This is a boxed `BOOL` value.
 Blocked in anonymous mode. May be `nil` when blocked in anonymous mode.
 */
@property (readonly, nullable) NSNumber *headphonesArePresent;

/**
 Indicates if the Camera feature is available based on the current app camera authorization status. Accessing the property will not prompt the user for camera access permission. This is a boxed `BOOL` value.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable, getter=isCameraFeatureAllowed) NSNumber *cameraFeatureAllowed;

/**
 Indicates if the Front Camera feature is available based on the current app camera authorization status, the presence of the required NSCameraUsageDescription bundle usage string, and if the front camera is currently available. Accessing the property will not prompt the user for camera access permission. This is a boxed `BOOL` value.
 Must be called on the main thread (see class comments).
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable, getter=isFrontCameraFeatureAllowed) NSNumber *frontCameraFeatureAllowed;

/**
 Indicates if the Rear Camera feature is available based on the current app camera authorization status, the presence of the required NSCameraUsageDescription bundle usage string, and if the rear camera is currently available. Accessing the property will not prompt the user for camera access permission. This is a boxed `BOOL` value.
 Must be called on the main thread (see class comments).
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable, getter=isRearCameraFeatureAllowed) NSNumber *rearCameraFeatureAllowed;

/**
 Indicates if the Microphone feature is allowed based on the current recordPermission status. Accessing the property will not prompt the user for recording permission. This is a boxed `BOOL` value.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable, getter=isMicFeatureAllowed) NSNumber *micFeatureAllowed;

/**
 Indicates if the GPS feature is allowed based on the current authorization status of the CLLocationManager. Accessing the property will not prompt the user for location services permission. This is a boxed `BOOL` value.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 */
@property (readonly, nullable, getter=isGPSFeatureAllowed) NSNumber *gpsFeatureAllowed;

/**
 Indicates if the Bluetooth feature is allowed based on the current CoreBluetooth status. This is a boxed `BOOL` value.
 Blocked in anonymous mode. May be `nil` if unavailable, unknown, or when blocked in anonymous mode.
 <p>
 NOTE: Because obtaining the device’s Bluetooth state requires a usage description string, we have removed CoreBluetooth API usage and have changed this behavior to always return `nil` (unknown) for now.
 </p> */
@property (readonly, nullable, getter=isBluetoothFeatureAllowed) NSNumber *bluetoothFeatureAllowed;

/**
 Indicates if the Calendar feature is allowed based on the presence of the NSCalendarsUsageDescription bundle usage string. Checking the value will not prompt the user for permission to access the calendar.
 */
@property (readonly, getter=isCalendarFeatureAllowed) BOOL calendarFeatureAllowed;

/**
 Indicates if the Photo Library Access feature is allowed based on the presence of the NSPhotoLibraryUsageDescription bundle usage string. Checking the value will not prompt the user for permission to access the photo library.
 */
@property (readonly, getter=isPhotoAccessFeatureAllowed) BOOL photoAccessFeatureAllowed;

/**
 Indicates if the Photo Library Addition feature is allowed based on the presence of the NSPhotoLibraryAddUsageDescription bundle usage string. Checking the value will not prompt the user for permission to add to the photo library.
 */
@property (readonly, getter=isPhotoAdditionFeatureAllowed) BOOL photoAdditionFeatureAllowed;

@end

NS_ASSUME_NONNULL_END
