///
/// @internal
/// @file
/// @brief Definitions for VASAds+Private.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAds.h>

NS_ASSUME_NONNULL_BEGIN

@class VASScheduler;
@class VASPEXRegistry;
@class VASComponentRegistry;
@class VASVerizonSSPReporter;

#pragma mark - VASAdSession keys

/// VASAdSession key to retrieve the factory weak reference container object. There is no current common interface for factories, so the weak reference is to an id.
/// Type: VASWeakRef id
extern NSString * const kVASRequestFactoryRefKey;

/// VASAdSession key to retrieve the placement weak reference container object. Note that VASPlacement is defined in Support.
/// Type: VASWeakRef id<VASPlacement>
extern NSString * const kVASRequestPlacementRefKey;

/// VASAdSession key for the request metadata.
/// Type: VASRequestMetadata
extern NSString * const kVASRequestMetadataKey;

/// VASAdSession key containing the requesting class name.
/// Type: id (class)
extern NSString * const kVASRequestRequestorClassKey;

/// VASAdSession key containing the response waterfall.
/// Type: id<VASWaterfall>
extern NSString * const kVASResponseWaterfallKey;

/// VASAdSession key containing the response waterfall item.
/// Type: id<VASWaterfallItem>
extern NSString * const kVASResponseWaterfallItemKey;

#pragma mark - VASComponentFactory keys

/// VASComponentFactory `args` key
/// Type: VASAdSession
extern NSString * const kVASComponentArgsAdSessionKey;

#pragma mark - Miscellaneous keys

/// Configuration domain used for VASAds core configuration values from a ConfigProvider
extern NSString * const kDomainVASCore;

/// Key for the amount of time between configuration provider refresh updates.
/// Configuration data is an NSNumber object containing the milliseconds between checks.
extern NSString * const kVASConfigProviderRefreshIntervalKey;  // NSNumber<NSUInteger> milliseconds

/// Key for the amount of time between checks for the current IP address being in a region governed by privacy regulation.
/// Configuration data is an NSNumber object containing the milliseconds between checks.
extern NSString * const kVASLocationRequiresConsentTtlKey;  // NSNumber<NSUInteger> milliseconds

/// Key for the URL of the geographic IP check function.
/// Configuration data is an NSString object containing the URL string.
extern NSString * const kVASGeoIpCheckURLKey;  // NSString

/// Key for reading and setting Core configuration value that turns on or
/// off the configuration provider.
extern NSString * const kVASConfigProviderEnabledKey;

#pragma mark - VASWeakRef

/// Wrapper container object for a weak reference to allow storage within VASDataStore or any other collection class object (NSDictionary, NSArray, ...)
@interface VASWeakRef : NSObject

/// A weak reference to an arbitrary NSObject. Will be nil once the object is released.
@property (readonly, weak, nullable) id<NSObject> object;

/**
Create an instance of the wrapper object containing the actual object to be weakly-referenced.

@param object   NSObject to be weakly stored.
@return an instance of the container.
*/
- (instancetype)initWithObject:(id<NSObject>)object NS_DESIGNATED_INITIALIZER;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

#pragma mark - VASAds

@interface VASAds (Private)

- (instancetype)initWithSession:(nullable NSURLSession *)session;

/**
 Returns an VASAdAdapter for the specified `adRequestorClass` and `content` pair if one is registered with `registerAdAdapterClass:withAdRequestorClass:contentFilter:`.
 If no matching registration is found, `nil` is returned.
 
 @param adRequestorClass A placement class registered for handling content.
 @param adContent The ad content.
 @return An `VASAdAdapter` instance of a class registered to handle the specified content, otherwise `nil`.
 */
- (nullable id<VASAdAdapter>)adAdapterForAdRequestorClass:(Class)adRequestorClass
                                                adContent:(VASAdContent *)adContent;

/// Used to schedule timed tasks.
@property (readonly) VASScheduler *scheduler;

/// Accessor to the Post Experience-registered factories.
@property (readonly) VASPEXRegistry *PEXRegistry;

/// Accessor to the Component factories.
@property (readonly) VASComponentRegistry *componentRegistry;

/// Accessor to the SSP Reporter.
@property (readonly) VASVerizonSSPReporter *verizonSSPReporter;

/**
 To retrieve the specified plugin by class. Will be nil if the plugin has not been registered. pluginClass is nullable to allow calls with weakly-linked classes, e.g. "[... pluginOfClass:[VASOMSDKPlugin class]]" where the VASOMSDKPlugin might not be available and would equal nil.
 
 Note that the plugin may be disabled and it should be queried using VASAds isPluginEnabled:[VASPlugin identifier] to determine its current state before using.

 @param pluginClass  The class of plugin to retrieve.
 @return the currently registered plugin of the specified type, nil otherwise.
 */
- (nullable VASPlugin *)pluginOfClass:(nullable Class)pluginClass;

@end

NS_ASSUME_NONNULL_END
