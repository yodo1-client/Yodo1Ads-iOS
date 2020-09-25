///
///  @file
///  @brief Definitions for VASVerizonNativeComponentBundle.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASVerizonNativeComponent.h>
#import <VerizonAdsStandardEditionStatic/VASComponentFactory.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - VASVerizonNativeAdFactory

/// Factory used to create new instances of VASVerizonNativeComponentBundle.
@interface VASVerizonNativeComponentBundleFactory : NSObject <VASComponentFactory>

/**
 Create a new component bundle.
 
 Required args: kVASNativeComponentIdKey, kVASNativeComponentDelegateKey
 
 @param componentInfo   The JSON used to construct the component bundle.
 @param args            The additional arguments needed for the construction.
 @param vasAds          The VASAds instance being used.
 @return the VASComponent bundle.
 */
- (nullable id<VASComponent>)newInstanceFromComponentInfo:(NSDictionary<NSString *,id> *)componentInfo
                                                     args:(nullable NSDictionary<NSString *, id> *)args
                                                   VASAds:(VASAds *)vasAds;

@end

#pragma mark - VASVerizonNativeComponentBundle

/// A VASNativeComponent bundle object that contains other components.
@interface VASVerizonNativeComponentBundle : VASVerizonNativeComponent

/// A set of strings representing the components found within this bundle, if loaded and available, otherwise an empty set.
@property (readonly) NSSet<NSString *> *componentIds;

/// Loaded components. Will be nil if the components have not yet been created or empty if no components were able to be created.
@property (readonly, nullable) NSDictionary<NSString *, id<VASNativeComponent>> *components;

/**
 Instantiate an instance of this class.
 
 @param adSession       The VASAdSession representing this ad.
 @param componentId     The id for the component being created. Required for some classes.
 @param contentType     The content type for this component bundle.
 @param componentInfo   The JSON dictionary used to construct the component.
 @param delegate        The object that will respond to the VASVerizonNativeComponentDelegate protocol calls.
 @param vasAds          The VASAds object used for this session.
 @return a new instance of this class.
 */
- (instancetype)initWithAdSession:(VASAdSession *)adSession
                      componentId:(nullable NSString *)componentId
                      contentType:(NSString *)contentType
                    componentInfo:(NSDictionary<NSString *, id> *)componentInfo
                         delegate:(nullable id<VASVerizonNativeComponentDelegate>)delegate
                           VASAds:(VASAds *)vasAds;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Create or return an existing VASComponent for the passed componentId.
 
 Android: public Component getComponent(final Context context, final String componentId, Object... args)
 
 @param componentId The specific component to retrieve.
 @return the VASComponent associated with the componentId.
 */
- (nullable id<VASComponent>)componentForComponentId:(NSString *)componentId;

/**
 Returns the raw JSON dictionary associated with the specified componentId.
 
 Android: public JSONObject getComponentJSON(final String componentId)
 
 @param componentId The specific component to retrieve.
 @return the JSON dictionary or nil if it doesn't exist.
 */
- (nullable NSDictionary<NSString *, id> *)componentJSONForComponentId:(NSString *)componentId;

@end

NS_ASSUME_NONNULL_END
