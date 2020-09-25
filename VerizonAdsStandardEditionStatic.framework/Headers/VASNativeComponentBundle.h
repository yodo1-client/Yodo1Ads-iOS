///
/// @file
/// @brief Definitions for VASNativeComponentBundle
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASCommon.h>
#import <VerizonAdsStandardEditionStatic/VASComponent.h>

NS_ASSUME_NONNULL_BEGIN

@class VASNativeAd;

/**
 A component bundle represents a potentially nested collection of native components.
 */
@interface VASNativeComponentBundle : NSObject <VASComponent>

/// The VASNativeAd associated with this bundle.
@property (weak, nonatomic, readonly, nullable) VASNativeAd *nativeAd;

/// The VASNativeComponentBundle that is the parent of this bundle.
@property (weak, nonatomic, readonly, nullable) VASNativeComponentBundle *parentBundle;

/// A sanitized copy of the native ad JSON for the current component and its descendants that can be queried for things like ad properties and metadata.
@property (readonly, copy, nullable) NSDictionary <NSString *, id> *JSON;

/**
 The set of strings representing the components of the VASNativeComponentBundle. The actual components are instances of type: id<VASComponent> or VASNativeComponentBundle. If no component IDs exist or the ad has been released, an empty set is returned.
 
 Must be called on the main thread or an empty set is returned.
 */
@property (readonly) NSSet<NSString *> *componentIds;

@property (readonly) id<VASComponent> bundleComponent;

/// A dictionary of currently-loaded components.
@property (readonly, nullable) NSDictionary<NSString *, id<VASComponent>> *loadedComponents;

/**
 Creates a VASNativeComponentBundle based on the parent VASNativeComponentBundle.
 
 @param parentBundle    The parent VASNativeComponentBundle for this newly-created bundle or nil if it is the root bundle.
 @param nativeAd        The native ad associated with this bundle.
 @param bundleComponent The bundle component associated with this instance.
 @return a new VASNativeComponentBundle.
 */
- (instancetype)initWithParentBundle:(nullable VASNativeComponentBundle *)parentBundle
                            nativeAd:(VASNativeAd *)nativeAd
                     bundleComponent:(id<VASComponent>)bundleComponent;

/**
 Gets a VASComponent object for the specified component. Use this method for retrieving components of a native ad such as image, text, and/or video. Returns nil if the component is not available.
 This method must be called on the main thread.

 @param componentId The component that should be returned.
 @return The VASComponent for the component, if available; otherwise nil.
 */
- (nullable id<VASComponent>)component:(NSString *)componentId;

/**
 A sanitized copy of the native ad JSON for the specified component and its descendants that can be queried for things like ad
 properties and metadata. Returns nil if the component is not available.
 
 @param componentId The native ad component that should be returned.
 @return A copy of the JSON for the component, if available; otherwise nil.
 */
- (nullable NSDictionary <NSString *, id> *)JSON:(NSString *)componentId;


- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
