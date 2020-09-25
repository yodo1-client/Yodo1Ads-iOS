///
///  @file
///  @brief Definitions for VASInlineAdAdapter
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Completion handler for load.
 */
typedef void (^VASInlineLoadCompletionHandler)(VASErrorInfo * _Nullable error);

/**
 Protocol for receiving notifications from the VASInlineAdAdapter.
 */
@protocol VASInlineAdAdapterDelegate <NSObject>

/**
 Called when the ad failed with error.
 
 @param errorInfo   The VASErrorInfo that describes the error that occured.
 */
- (void)inlineAdapterDidFailWithError:(VASErrorInfo *)errorInfo;

/**
 Called when an action causes the ad to expand.
*/
- (void)inlineAdapterDidExpand;

/**
 Called when an action causes the ad to collapse.
*/
- (void)inlineAdapterDidCollapse;

/**
 Called when the ad has been clicked.
 */
- (void)inlineAdapterWasClicked;

/**
 Called when an action causes the user to leave the application.
 */
- (void)inlineAdapterDidLeaveApplication;

/**
 Called when an action causes the ad to resize.
 */
- (void)inlineAdapterDidResize;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen ad.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen ad. Returning nil will result in no fullscreen ad being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)inlineAdapterPresentingViewController;

@end

/**
 VASInlineAdView adapters must conform to this protocol including ensuring all properties are thread-safe as indicated by the attributes.
 */
@protocol VASInlineAdAdapter <VASAdAdapter>

/**
 Load the inline view. Implementations of this method must be asynchronous.
 
 @param timeout     The time in seconds the caller is willing to wait for the ad to load.
 @param handler     An implementation of VASInlineLoadCompletionHandler that will be called when the ad finishes loading.
 */
- (void)loadWithTimeout:(NSTimeInterval)timeout
      completionHandler:(VASInlineLoadCompletionHandler)handler;

/**
 Abort load if it is still active.
 */
- (void)abortLoad;

/**
 Release the resources loaded for the ad.
 */
- (void)releaseResources;

/**
 Informs the delegate that an impression has occurred and been reported. The delegate can then perform any additional actions, if needed. May be called an arbitrary thread.
 */
- (void)fireImpression;

/**
 The object implementing the VASInlineAdAdapterDelegate protocol to receive ad adapter event callbacks.
 */
@property (weak, nullable) id<VASInlineAdAdapterDelegate> delegate;

/**
 Specifies whether the ad should be immersive.
 */
@property (getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 The ad size for the VASInlineAdView, or nil if the ad has been destroyed.
 */
@property (readonly, nullable) VASInlineAdSize *adSize;

/**
 Used to determine if the ad is currently resized.
 */
@property (readonly) BOOL isResized;

/**
 Used to determine if the ad is currently expanded.
 */
@property (readonly) BOOL isExpanded;

/**
 Once the view has been loaded, returns the actual ad view to be attached to the frame layout.
 
 @return the creative view.
 */
@property (readonly, nullable) UIView *adView;

@end

NS_ASSUME_NONNULL_END
