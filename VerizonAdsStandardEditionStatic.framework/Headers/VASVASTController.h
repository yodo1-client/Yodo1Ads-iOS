///
///  @file
///  @brief Definitions for VASVASTController
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>

NS_ASSUME_NONNULL_BEGIN

@class VASVASTController;

typedef void (^VASVastLoadCompletionHandler)(VASErrorInfo * _Nullable error);

/// Error codes that are used by VASErrorInfo in the core error domain.
typedef NS_ENUM(NSInteger, VASVastControllerError) {
    /// Unable to prepare an ad for use.
    VASVastControllerPrepareFailure = 1,
    /// A timeout occurred.
    VASVastControllerErrorTimeout,
    /// VAST document parsing error.
    VASVASTControllerParsingFailure,
    /// VAST Media file downloading error.
    VASVASTControllerMediaFileDownloadingFailure,
    /// No Video Player has been registered.
    VASVASTControllerNoVideoPlayerError,
    /// Registered Video Player does not return a view.
    VASVASTControllerNoVideoViewError
};

/**
 * Protocol for receiving notifications from the `VASVastController`.
 */
@protocol VASVastControllerDelegate <NSObject>

/**
 * Called when the `VASVASTController` should close.
 */
- (void)VASTControllerShouldClose;

/**
 * Called when the app was left from `VASVASTController`.
 */
- (void)VASTControllerDidLeaveApplication;

/**
 * Called when the `VASVASTController` was clicked.
 */
- (void)VASTControllerWasClicked;

/**
 * Called when the `VASVASTController` encounters an error.
 *
 * @param error The `VASErrorInfo` that was encountered.
 */
- (void)VASTControllerFailedWithError:(VASErrorInfo *)error;

/**
 * Called when video completed playing.
 */
- (void)VASTControllerVideoDidComplete;

@end

/**
 *VASVASTController class. The controller handles the display of VAST ads.
 */
@interface VASVASTController : UIViewController

///
/**
 Initializer for a new VASVASTController view controller.
 
 @param vasAds   The VASAds instance to use for this controller.
 @return an instance of this view controller.
 */
- (instancetype)initWithVASAds:(VASAds *)vasAds;

/**
 Set the ad content and prepare it for processing.
 
  @param adContent   A VASAdContent object specifying the ad content.
  @param adSession   The VASAdSession object representing this ad.
  @return nil if successful; otherwise a VASErrorInfo object describing the error.
  */
 - (nullable VASErrorInfo *)prepareWithAdContent:(VASAdContent *)adContent
                                  usingAdSession:(VASAdSession *)adSession;

/**
 * Load the ad. Implementations of this method must be asynchronous.
 *
 * @param timeout       The time in seconds the caller is willing to wait for the ad to load.
 * @param handler       An implementation of `VASInterstitialLoadCompletionHandler` that will be called when the ad finished loading.
 */
- (void)loadWithTimeout:(NSTimeInterval)timeout completionHandler:(VASVastLoadCompletionHandler)handler;

/**
 * Release the resources loaded for the ad.
 */
- (void)releaseResources;

/**
 * Abort load if it is still active.
 */
- (void)abortLoad;

/**
 * Specifies whether the ad should show or hide the status bar for a more complete full screen experience.
 */
@property (getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 * The object implementing the `VASVastControllerDelegate` protocol, to receive controller event callbacks.
 */
@property (weak, nullable) id<VASVastControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
