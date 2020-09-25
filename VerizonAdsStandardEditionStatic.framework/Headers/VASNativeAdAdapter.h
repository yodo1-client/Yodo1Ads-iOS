///
/// @file
/// @brief Definitions for VASNativeAdAdapter.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VASNativeComponentBundle.h>

NS_ASSUME_NONNULL_BEGIN

/// Completion handler for loadComponents.
typedef void (^VASNativeLoadComponentsCompletionHandler)(VASErrorInfo * _Nullable error);

#pragma mark - VASNativeAdAdapterDelegate protocol

/**
 Protocol for receiving notifications from the `VASNativeAdAdapter`.
 */
@protocol VASNativeAdAdapterDelegate <NSObject>

/**
 Called when an action causes the ad to be closed.
 */
- (void)nativeAdapterDidClose;

/**
 Called when a component has been clicked.
 
 @param component The VASComponent that was clicked.
 */
- (void)nativeAdapterClickedWithComponent:(id<VASComponent>)component;

/**
 Called when an action causes the user to leave the application.
 */
- (void)nativeAdapterDidLeaveApplication;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen experiences.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen experiences. Returning nil will result in no fullscreen experience being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)nativeAdapterPresentingViewController;

/**
 This callback is used to surface additional events to the placement.
 
 @param eventId   The event identifier.
 @param source    The identifier of the event source.
 @param arguments An optional dictionary of key/value pairs of arguments related to the event.
 */
- (void)nativeAdapterEvent:(NSString *)eventId
                    source:(NSString *)source
                 arguments:(nullable NSDictionary<NSString *, id> *)arguments;

@end

#pragma mark - VASNativeAdAdapter protocol

/**
 Native ad adapters must conform to this protocol.
 */
@protocol VASNativeAdAdapter <VASAdAdapter>

/**
 Load the components defined in the content. Implementations of this method must be asynchronous.
 
 @param componentsTimeout The time in seconds the caller is willing to wait for components to load.
 @param skipAssets        Set to YES if the adapter should not download any of the component assets (i.e. images and videos).
 @param handler           An implementation of `VASNativeLoadComponentsCompletionHandler` that will be called upon component load completion.
 */
- (void)loadComponentsWithTimeout:(NSTimeInterval)componentsTimeout
                       skipAssets:(BOOL)skipAssets
                completionHandler:(VASNativeLoadComponentsCompletionHandler)handler;

/**
 Abort loadComponents if it is still active.
 */
- (void)abortLoadComponents;

/**
 Get a component for the specified component identifier. May be called from background threads.
 
 @param nativeComponentBundle   The VASNativeComponentBundle for creating the specified componentId.
 @param componentId             The identifier of the component.
 @return a VASComponent object if the component exists; otherwise nil.
 */
- (nullable id<VASComponent>)component:(VASNativeComponentBundle *)nativeComponentBundle
                           componentId:(NSString *)componentId;

/**
 Gets a set of strings representing the components of the VASNativeComponentBundle. The actual components are instances of type: VASComponent including VASNativeComponentBundle.
 
 @param nativeComponentBundle   The VASNativeComponentBundle for getting the component IDs.
 @return the set of components, if available; otherwise an empty set.
 */
- (NSSet<NSString *> *)componentIds:(VASNativeComponentBundle *)nativeComponentBundle;

/**
 Creates the root bundle of this ad instance.
 Android parity: `public NativeComponentBundle getRootBundle()`

 @param nativeAd    The native used to create the root bundle.
 @return the root bundle or nil if no ad was loaded.
 */
- (nullable VASNativeComponentBundle *)createRootBundleWithNativeAd:(VASNativeAd *)nativeAd;

/**
 Perform any actions associated with an ad impression. For example, fire impression trackers.
 */
- (void)fireImpression;

/**
 Perform the default action for the ad.
 */
- (void)invokeDefaultAction;

/**
 Release the components loaded for the ad. This is called automatically when the ad is destroyed.
 */
- (void)releaseResources;

/**
 A sanitized copy of the native ad JSON for the current component and its descendants that can be queried for things like ad properties and metadata.
 
 @param nativeComponentBundle The NativeComponentBundle for retrieving the JSON.
 @return a copy of the JSON for the current component.
 */
- (nullable NSDictionary <NSString *, id> *)JSON:(nullable VASNativeComponentBundle *)nativeComponentBundle;

/**
 A sanitized copy of the native ad JSON for the specified child component and its descendants that can be queried for things like ad properties and metadata. Returns nil if the component is not available.
 
 @param nativeComponentBundle   The NativeComponentBundle for retrieving the JSON.
 @param componentId             The NativeAd component that should be returned.
 @return a copy of the JSON for the component, if available; otherwise nil.
 */
- (nullable NSDictionary <NSString *, id> *)JSON:(nullable VASNativeComponentBundle *)nativeComponentBundle componentId:(NSString *)componentId;

/**
 The object implementing the `VASNativeAdAdapterDelegate` protocol to receive ad adapter event callbacks.
 */
@property (weak, nullable) id<VASNativeAdAdapterDelegate> delegate;

/**
 The type of the ad content.
 */
@property (readonly, nullable) NSString *adType;

/**
 Gets a set of strings representing the required components for the current ad response, if available, otherwise an empty set.
 */
@property (readonly) NSSet<NSString *> *requiredComponentIds;

/**
 Register a view for tracking using the Open Measurement SDK.
 This view should contain all required component views for the native ad.  This method must be called on the main thread.
 
 @param containerView The UIView containing the native ad's component views.
 @return YES if the Open Measurement SDK started tracking the containerView successfully, otherwise NO.
 */
- (BOOL)registerContainerView:(UIView *)containerView;

@end

NS_ASSUME_NONNULL_END
