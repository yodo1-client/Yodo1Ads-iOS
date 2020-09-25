///
/// @file
/// @brief Definitions for VASAds.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASLogger.h>
#import <VerizonAdsStandardEditionStatic/VASAdSession.h>
#import <VerizonAdsStandardEditionStatic/VASBid.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>
#import <VerizonAdsStandardEditionStatic/VASSDKInfo.h>
#import <VerizonAdsStandardEditionStatic/VASConfiguration.h>
#import <VerizonAdsStandardEditionStatic/VASConfigurationProvider.h>
#import <VerizonAdsStandardEditionStatic/VASEvents.h>
#import <VerizonAdsStandardEditionStatic/VASEnvironmentInfo.h>
#import <VerizonAdsStandardEditionStatic/VASAdContent.h>
#import <VerizonAdsStandardEditionStatic/VASContentFilter.h>
#import <VerizonAdsStandardEditionStatic/VASRequestMetadata.h>
#import <VerizonAdsStandardEditionStatic/VASPlugin.h>
#import <AvailabilityMacros.h>

NS_ASSUME_NONNULL_BEGIN


/// Completion handler for ad requests.
typedef void (^VASAdRequestCompletionHandler)(VASErrorInfo * _Nullable errorInfo);

/// Handler by the SDK Core before an ad request is made to the waterfall provider. Use this to add properties required by each ad session object in the ad request. Executed on an arbitrary background thread and should be processed synchronously and completed before returning from the handler.
typedef void (^VASAdSessionPrepareHandler)(VASAdSession * _Nullable adSession);

/// Handler called on an arbitrary background thread by the SDK Core when each ad request is complete. If a request failed, adSession will be nil and the errorInfo will identify the reason. Called repeatedly until `completed` is YES indicating no more callbacks will occur for the initial ad request. Note that the number of times called will not necessarily equal the number of ads initially requested due to errors, no ads, etc.
typedef void (^VASAdRequestRepeatHandler)(BOOL completed, VASAdSession * _Nullable adSession, VASErrorInfo * _Nullable errorInfo);

/// Completion handler for bid requests.
typedef void (^VASBidRequestCompletionHandler)(VASBid * _Nullable bid, VASErrorInfo * _Nullable errorInfo);


#pragma mark - VASAds Initialization

/**
 @nosubgrouping
 Contains APIs for interacting with core functionality of the SDK, such as setting location, enabling COPPA and initializing the SDK.
 */
@interface VASAds : NSObject

/**
 @name VASAds API
 The **%API** refers to the portion of this interface that is exposed for the purpose of integrating ad monetization into the application.
 */
/// @{

#pragma mark - Publisher API - General

/// A shared instance of the Core SDK.
@property (class, nonatomic, readonly) VASAds *sharedInstance;

/// @cond
/// Basic SDK build info.
@property (class, nonatomic, readonly) VASSDKInfo *sdkInfo;
/// @endcond

/// Global log level.
@property (class, readwrite) VASLogLevel logLevel;

/// Site id that was used to initialize the Core SDK through the #initializeWithSiteId: method.
@property (readonly, copy) NSString *siteId;

/// Indicates that the core was initialized for use. Successfully call the #initializeWithSiteId: method to set this value to YES.
@property (readonly, getter=isInitialized) BOOL initialized;

/// The default request metadata that is used when no other is provided.
@property (readwrite, nullable) VASRequestMetadata *requestMetadata;

/**
 Initialize the Core for use with a specific site ID.
 This method must be called before using any other components of the API.
 This method must be called on the main thread.
 
 @param siteId The site ID.
 @return `YES` if initialized successfully, `NO` otherwise.
 */
- (BOOL)initializeWithSiteId:(NSString *)siteId;

/**
 Used to enable/disable location services within the VASAds SDK.
 
 When set to NO, SDK components must not access the user's location. Location information is only available and used, such as with ad requests, if location permissions are granted for the app and in accordance with the privacy settings such as GDPR requirements.
 Enabling this will NOT prompt the user for location authorization. Providing location data will help to serve more relevant ads to your users.
 
 Set to NO to explicitly disable sending location information with ad requests. Default is YES except when overridden by the anonymous setting of YES which will prevent location data being sent.
 */
@property (readwrite, getter=isLocationEnabled) BOOL locationEnabled;

/**
Use this method to retrieve a bidding token.

@param requestMetadata The request metadata that will be used as part of the bidding token.
 
@return The bidding token or `nil` if the waterfall provider doesn't support bidding.
*/
- (nullable NSString *)biddingTokenUsingMetadata:(nullable VASRequestMetadata *)requestMetadata;

#pragma mark - Publisher API - Privacy

/**
 Indicates whether the user's personal data should be collected. When YES is returned, components must not collect any personal user data. A NO indicates personal data may be collected and passed.
 
 @ifnot PUBLISHER_API
 This is a convenience accessor for the VASConfiguration key kVASConfigAnonymousUserKey which is evaluated from the current values of these keys: kVASCorePrivacyKeyCollectionModeKey in the consentData dictionary, kVASConfigUserConsentDataKey, and kVASConfigLocationRequiresConsentKey.
 @endif
 */
@property (readonly) BOOL isAnonymous;

/**
 This method is used to provide user privacy data.
 
 @param privacyData Dictionary that contains a mapping of a user privacy data identifier to the privacy data.
 */
- (void)setPrivacyData:(nullable NSDictionary<NSString *, id> *)privacyData;

/**
 The COPPA (Children’s Online Privacy Protection Act) setting for ads. Read/write value that should be set based on user settings, if available. Note that this is effectively a `BOOL` value that can also be `nil` when not specified.
 
 Set to `@(YES)` to indicate to ad buyers that COPPA restrictions need to be enforced for requests from this user. Set to `@(NO)` to not enforce restrictions. Defaults to `nil` which means the value will not be sent along with the request leaving it indeterminate for ad buyers.
 
 Note that changing this value will only take effect on future ad requests, not those currently be processed.
 */
@property (readwrite, nullable) NSNumber *COPPA;

/**
 Indicates whether a creative can access the user‘s advertiser ID. Set to YES to enable the advertiser ID being shared, NO to restrict it. Default is NO.
 
 Note that changing this value will only take effect on future ad requests, not those currently be processed.
 */
@property BOOL shareAdvertiserId;

/**
 Indicates whether a creative can access the application‘s bundle ID. Set to YES to enable the bundle ID being shared, NO to restrict it. Default is NO.
 
 Note that changing this value will only take effect on future ad requests, not those currently be processed.
 */
@property BOOL shareApplicationId;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/// @}
// end of doxygen named group: VASAds Publisher API


/// @cond (INTERNAL || PLUGIN_API)
/**
 @name VASAds Plugin API
 The **%Plugin API** refers to the portion of this interface that is exposed to plugin developers for the purpose of implementing custom components and is a superset of the Publisher API.
 */
/// @{

#pragma mark - Plugin API - General

/// API level of the SDK
@property (class, nonatomic, readonly) NSInteger API_LEVEL;

/// Used for VASAds configuration management.
@property (readonly) VASConfiguration *configuration;

/// Used to obtain environment information.
@property (readonly) VASEnvironmentInfo *environmentInfo;

/// Used for VASAds eventing management.
@property (readonly) VASEvents *events;

/// The current NSURLSession.
@property (readonly) NSURLSession *session;

/**
 Register an ad adapter for a specific adRequestor class.
 This adRequestor class will act as a key when searching for ad adapters that can handle ad content.
 
 @param adAdapterClass An ad adapter class that can be used to handle the ad content.
 @param adRequestorClass A class that is capable of handling the associated `adAdapterClass` and specific `contentFilter` instance. This represents placement classes, e.g. inlineAd, interstitialAd, etc.
 @param pluginId The id of the registered plugin.
 @param contentFilter An implementation of VASContentFilter that defines the content handled by the specified `adRequestorClass`.
 */
- (void)registerAdAdapterClass:(Class<VASAdAdapter>)adAdapterClass
              adRequestorClass:(Class)adRequestorClass
                      pluginId:(NSString *)pluginId
                 contentFilter:(id<VASContentFilter>)contentFilter;

/**
 Registers an VASConfigurationProvider for the plugin specified.
 
 @param pluginId                The id of the plugin that this configuration provider belongs to.
 @param configurationProvider   An instance of VASConfigurationProvider to register for the plugin.
 */
- (void)registerConfigurationProviderForPlugin:(NSString *)pluginId
                         configurationProvider:(id<VASConfigurationProvider>)configurationProvider;

/**
 Registers the specified content type with VASPEXFactory instance provided.

 @param factory The VASPEXFactory that creates handlers for this content type.
 @param type    The PEX content type for this factory.
 @return YES if the VASPEXFactory object was successfully registered, NO if already registered or does not conform to the VASPEXFactory protocol.
 */
- (BOOL)registerPEXFactory:(id<VASPEXFactory>)factory forType:(NSString *)type;


#pragma mark - Plugin API - Ad / Bid Requests

/**
 Request a number of ads. `numberOfAds` can be `1` to get a single ad or more to get a batch.
 
 Do not assume the response will contain `numberOfAds` because less may be available.
 
 The response will be in the completion handler, called once per ad received, and called repeatedly from different arbitrary queues until the request is filled and the `completed` flag is YES. Therefore ensure thread safety within the completion block code, typically by dispatching to your own queue. Note that a nil ad response may occur which will include an error.
 
 @param adRequestorClass A placement class that has been registered with the ad adapter registry.
 @param requestMetadata Additional metadata to consider when making the ad request.
 @param numberOfAds Number of ads to request in one operation.
 @param timeout Time limit for the ad request in NSTimeInterval seconds.
 @param prepareHandler Called with an ad session object before the request is made to the waterfall provider.
 @param receiveHandler Block that is called repeatedly for each received ad as soon as available. If the returned ad is nil, a VASErrorInfo will also be returned. Once the completed flag returns YES, the handler will no longer be called. This ad handler block will be called on an arbitrary background queue.
 */
- (void)requestAdsForRequestorClass:(Class)adRequestorClass
                    requestMetadata:(nullable VASRequestMetadata *)requestMetadata
               requestedNumberOfAds:(NSUInteger)numberOfAds
                        withTimeout:(NSTimeInterval)timeout
                     prepareHandler:(nullable VASAdSessionPrepareHandler)prepareHandler
                     receiveHandler:(VASAdRequestRepeatHandler)receiveHandler;

/**
 Request a bid.
 The response will be in the VASBidRequestCompletionHandler completion handler.
 
 @param requestMetadata Additional metadata to consider when making the bid request.
 @param timeout Time limit for the bid request in NSTimeInterval seconds.
 @param completion Block that handles the completion of the bid request. If the returned bid is nil, a VASErrorInfo will also be returned. This completion block will be called on an arbitrary background queue.
 */
- (void)requestBidUsingMetadata:(nullable VASRequestMetadata *)requestMetadata
                    withTimeout:(NSTimeInterval)timeout
                     completion:(VASBidRequestCompletionHandler)completion;

/**
 Request ad from a bid.
 The response will be in the completion handler, but be sure to check for errors as well.
 
 @param bid The bid to use for requesting an ad.
 @param adRequestorClass A placement class that has been registered with the ad adapter registry.
 @param timeout Time limit for the bid request in NSTimeInterval seconds.
 @param completion Block that handles the completion of the ad request. If the returned ad is nil, a VASErrorInfo will also be returned. This completion block will be called on an arbitrary background queue.
 */
- (void)requestAdFromBid:(VASBid *)bid
     forAdRequestorClass:(Class)adRequestorClass
             withTimeout:(NSTimeInterval)timeout
              completion:(VASAdRequestRepeatHandler)completion;

// NOTE: Plugin methods moved to the Plugin API (per request) until more docs work is done.
#pragma mark - TBD Publisher API - Plugins

/**
 An array of registered plugins.
 */
@property (readonly) NSArray<VASPlugin *> *registeredPlugins;

/**
 Register a plugin with the core.
 Note that `registerPlugin` and the subsequent `prepare` are executing on the main thread and should not perform functions that potentially block for an extended time.
 
 @param plugin Plugin to register.
 @param enabled `YES` if need to enable the plugin right after registraion or `NO` if need to disable the plugin.
 @return `YES` if registered successfully, `NO` otherwise.
 */
- (BOOL)registerPlugin:(VASPlugin *)plugin enabled:(BOOL)enabled;

/**
 Enables the specified plugin if it's registered.
 
 @param pluginId The id of the plugin to enable.
 @return `YES` if the plugin was enabled, `NO` otherwise.
 */
- (BOOL)enablePluginWithId:(NSString *)pluginId;

/**
 Disables the specified plugin if it's registered.
 
 @param pluginId The id of the plugin to disable.
 @return `YES` if the plugin was disabled, `NO` otherwise.
 */
- (BOOL)disablePluginWithId:(NSString *)pluginId;

/**
 Returns `YES` if the plugin is registered and enabled, `NO` otherwise.
 
 @param pluginId The id of the registered plugin.
 @return `YES` if the plugin is registered and enabled, `NO` otherwise.
 */
- (BOOL)isPluginEnabled:(NSString *)pluginId;

/// @}
// end of named block: VASAds Plugin API
/// @endcond


@end

NS_ASSUME_NONNULL_END
