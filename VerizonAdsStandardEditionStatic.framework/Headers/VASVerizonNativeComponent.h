///
///  @file
///  @brief Definitions for VASVerizonNativeComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import <VerizonAdsStandardEditionStatic/VASAds.h>
#import <VerizonAdsStandardEditionStatic/VASAdSession.h>
#import <VerizonAdsStandardEditionStatic/VASNativeComponent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASComponentFactory args keys.
 */
/// Key for the VASVerizonNativeComponentDelegate-conforming object that responds to the component interaction.
extern NSString * const kVASNativeComponentDelegateKey;  // id<VASVerizonNativeComponentDelegate>

/// Key for the component identifier string.
extern NSString * const kVASNativeComponentIdKey;  // NSString

#pragma mark - VASVerizonNativeComponentDelegate

/**
 Protocol for receiving notifications from the VASVerizonNativeAd.
 */
@protocol VASVerizonNativeComponentDelegate <NSObject>

/**
 Called when a component has been clicked.
 
 @param nativeComponent The VASNativeComponent that was clicked.
 */
- (void)verizonNativeAdClickedWithComponent:(id<VASNativeComponent>)nativeComponent;

/**
 Called when an action causes the user to leave the application.
 */
- (void)verizonNativeAdDidLeaveApplication;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen experiences.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen experiences. Returning nil will result in no fullscreen experience being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)verizonNativeAdPresentingViewController;

/**
 This callback is used to surface additional events to the placement.
 
 @param eventId   The event identifier.
 @param source    The identifier of the event source.
 @param arguments An optional dictionary of key/value pairs of arguments related to the event.
 */
- (void)verizonNativeEvent:(NSString *)eventId
                    source:(NSString *)source
                 arguments:(nullable NSDictionary<NSString *, id> *)arguments;

@end

#pragma mark - VASVerizonNativeComponent

@protocol VASPEXHandlerDelegate;
@class VASVerizonNativeComponentBundle; // Forward declaration to avoid circular dependency.

typedef void (^VASNativeLoadResourcesCompletionHandler)(VASErrorInfo * _Nullable error);

@interface VASVerizonNativeComponent : NSObject <VASNativeComponent>

@property (readwrite, nullable, weak) VASVerizonNativeComponentBundle *parentBundle;

/// The content type of this component bundle.
@property (readonly) NSString *contentType;

/// The component id of this component, if provided.
@property (readonly, nullable) NSString *componentId;

/// The JSON dictionary used to construct this instance.
@property (readonly) NSDictionary<NSString *, id> *componentInfo;

/// Object responsible for responding to these delegate methods.
@property (readonly, weak) id<VASVerizonNativeComponentDelegate> delegate;

/// VASAds object passed into the component.
@property (readonly) VASAds *vasAds;

/// VASAdSession object passed into the component.
@property (readonly, weak) VASAdSession *adSession;

- (instancetype)initWithAdSession:(VASAdSession *)adSession
                      componentId:(nullable NSString *)componentId
                      contentType:(NSString *)contentType
                    componentInfo:(NSDictionary<NSString *, id> *)componentInfo
                         delegate:(nullable id<VASVerizonNativeComponentDelegate>)delegate
                           VASAds:(VASAds *)vasAds;

- (void)registerTapRecognizerForView:(nonnull UIView *)view;

/**
 Subclasses should override this if they can provide a PEX handler for the specified id. This typically would occur following a successful completion of the loadResourcesWithTimeout call.
 
 @param pexId   The PEX id to search for a loaded PEX handler.
 @return a PEX handler, an instance of VASPEXHandlerDelegate.
 */
- (nullable id<VASPEXHandlerDelegate>)PEXHandlerForId:(NSString *)pexId;

/**
 Returns the action information associated with the specified event. If the parentBundle is specified, then default actions will be returned if the component does not specify any.
 
 Android: JSONArray getActionsForEvent(final VerizonNativeComponentBundle parentBundle, final JSONObject componentInfo, final String eventName)
 
 @param eventName The event name.
 @param componentInfo The component JSON dictionary.
 @param parentBundle The optional parent bundle used to retrieve default actions if the component does not specify any.
 @return the actions dictionary or nil if it doesn't exist.
 */
- (nullable NSArray<NSDictionary<NSString *, id> *> *)actionsForEvent:(nonnull NSString *)eventName
                                                    fromComponentInfo:(nonnull NSDictionary<NSString *, id> *)componentInfo
                                                      componentBundle:(nullable VASVerizonNativeComponentBundle *)parentBundle;

/**
 Invoke actions such as PEX, display, touch, video events, etc. as specified by the array of passed actions.
 
 @param actions     The actionsForEvent dictionary for the component event.
 @param actionData  Optional data associated with the actions.
 */
- (void)performActions:(NSArray<NSDictionary<NSString *, id> *> *)actions
            actionData:(nullable NSDictionary<NSString *, id> *)actionData;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
