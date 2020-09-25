///
/// @file
/// @brief Definitions for VASAdAdapterRegistration.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASContentFilter.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASAdAdapterRegistration represents an ad adapter registration.
 */
@interface VASAdAdapterRegistration : NSObject

/// id of the adapter owner plugin
@property (nonatomic, strong, readonly) NSString *pluginId;

/// the registered class
@property (nonatomic, strong, readonly) Class adRequestorClass;

/// the adapter class
@property (nonatomic, strong, readonly) Class adAdapterClass;

/// the content filter
@property (nonatomic, strong, readonly) id<VASContentFilter> contentFilter;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Initialize the read-only properties.

 @param pluginId The id of adapter owner plugin.
 @param adRequestorClass The placement class to register.
 @param adAdapterClass An ad adapter class.
 @param contentFilter A concrete VASContentFilter implementation.
 @return An instance of VASAdAdapterRegistration or nil.
 */
- (instancetype)initWithPluginId:(NSString *)pluginId
                adRequestorClass:(Class)adRequestorClass
                  adAdapterClass:(Class<VASAdAdapter>)adAdapterClass
                   contentFilter:(id<VASContentFilter>)contentFilter NS_DESIGNATED_INITIALIZER;

/**
 Tests if the candidate class and content match this registration.
 
 @param adRequestorClass A registered placement class.
 @param adContent Ad content data to evaluate.
 @return `YES` if the registration matches the candidates, `NO` otherwise.
 */
- (BOOL)matchesAdRequestorClass:(Class)adRequestorClass
                      adContent:(VASAdContent *)adContent;

@end

NS_ASSUME_NONNULL_END
