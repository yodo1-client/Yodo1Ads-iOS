///
///  @file
///  @brief Definitions for VASWebController.
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^VASWebControllerLoadCompletionHandler)(VASErrorInfo * _Nullable error);

/// Error codes that are used by VASErrorInfo in the core error domain.
typedef NS_ENUM(NSInteger, VASWebControllerError) {
    /// A timeout occurred.
    VASWebControllerErrorTimeout
};

/**
 Protocol for receiving notifications from the `VASWebControllerDelegate`.
 */
@protocol VASWebControllerDelegate <NSObject>

/**
 Called when the app was left from `VASWebController`.
 */
- (void)webControllerDidLeaveApplication;

/**
 Called when the `VASWebController` encounters an error.

 @param errorInfo The `VASErrorInfo` that was encountered.
 */
- (void)webControllerDidFailWithError:(VASErrorInfo *)errorInfo;

/**
 Called when the `VASWebController` closed.
 */
- (void)webControllerDidClose;

/**
 Called when the `VASWebController` expanded.
 */
- (void)webControllerDidExpand;

/**
 Called when the `VASWebController` resized.
 */
- (void)webControllerDidResize;

/**
 Called when the `VASWebController` was clicked.
 */
- (void)webControllerWasClicked;

/**
 Called when the `VASWebController` should unload.
 */
- (void)webControllerShouldUnload;

/**
 Called prior to presenting another view controller to use for displaying the fullscreen ad.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen ad. Returning nil will result in no fullscreen ad being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)webControllerPresentingViewController;

@end

/**
 VASWebController class. The controller handles the display of web ads.
 */
@interface VASWebController : VASForceOrientationViewController

/**
 The designated initializer for a web controller.
 
 @param vasAds         The VASAds object this instance will use.
 @return an instance of the VASWebController class.
 */
- (instancetype)initWithVASAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithOrientationProperties:(nullable VASForceOrientationProperties *)orientationProperties NS_UNAVAILABLE;

/**
 Set the ad content and prepare it for processing.
 
 @param adContent   A VASAdContent object specifying the ad content.
 @param adSession   The VASAdSession object representing this ad.
 @return nil if successful; otherwise a VASErrorInfo object describing the error.
 */
- (nullable VASErrorInfo *)prepareWithAdContent:(VASAdContent *)adContent
                                 usingAdSession:(VASAdSession *)adSession;

/**
 Load content for this controller.
 
 The VASErrorInfo response will be in the completion handler if an error occurs which may also contain an underlying error as well with more information about the cause of the error.
 
 @param timeout         Time limit for loading in `NSTimeInterval` seconds.
 @param interstitial    If the controller should be prepared for interstitial.
 @param handler         Block that is called when loading is complete. If successful, `error` will be nil. If loading fails, an VASErrorInfo object will be returned. If abortLoad is called, the operation is aborted and no completionHandler callback will occur. The completion handler block will be called on an arbitrary background queue.
 */
- (void)loadWithTimeout:(NSTimeInterval)timeout
           interstitial:(BOOL)interstitial
      completionHandler:(VASWebControllerLoadCompletionHandler)handler;

/**
 Abort the loading initiated by the loadWithTimeout:completionHandler: call.
 */
- (void)abortLoad;

/**
 Release resources.
 */
- (void)releaseResources;

/**
 Informs the object that an impression has occurred and been reported. The object can then perform any additional actions, if needed. May be called an arbitrary thread.
 */
- (void)fireImpression;

/**
 Specifies whether the ad should show or hide the status bar for a more complete full screen experience.
 */
@property (getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 Specifies whether the ad is expanded.
 */
@property (readonly) BOOL isExpanded;

/**
 Specifies whether the ad is resized.
 */
@property (readonly) BOOL isResized;

/**
 The object implementing the `VASWebControllerDelegate` protocol, to receive controller event callbacks.
 */
@property (readonly, nullable) UIView *mraidView;

/**
 The object implementing the `VASWebControllerDelegate` protocol, to receive controller event callbacks.
 */
@property (weak, nullable) id<VASWebControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
