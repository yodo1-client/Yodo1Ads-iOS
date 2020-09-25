///
///  @file
///  @brief Definitions for VASInterstitialAdAdapter.
///
///  @copyright Copyright © 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Completion handler for load.
typedef void (^VASInterstitialLoadCompletionHandler)(VASErrorInfo * _Nullable error);

/**
 Protocol for receiving notifications from the `VASInterstitialAdAdapter`.
 */
@protocol VASInterstitialAdAdapterDelegate <NSObject>

/**
 Called when there is an error in the ad adapter.
 
 @param error   The error that caused the adapter failure.
 */
- (void)interstitialAdapterFailedWithError:(VASErrorInfo *)error;

/**
 Called when the ad was shown.
 */
- (void)interstitialAdapterDidShow;

/**
 Called when an action causes the ad to be closed.
 */
- (void)interstitialAdapterDidClose;

/**
 Called when the ad has been clicked.
 */
- (void)interstitialAdapterClicked;

/**
 Called when an action causes the user to leave the application.
 */
- (void)interstitialAdapterDidLeaveApplication;

/**
 Call to pass additional adapter events.
 
 @param eventId        The event identifier.
 @param source         The identifier of the event source.
 @param arguments      A dictionary of key/value pairs of arguments related to the event.
 */
- (void)interstitialAdapterEvent:(NSString *)eventId
                          source:(NSString *)source
                       arguments:(nullable NSDictionary<NSString *, id> *)arguments;

@end

/**
 Interstitial ad adapters must conform to this protocol.
 */
@protocol VASInterstitialAdAdapter <VASAdAdapter>

/**
 Load the ad. Implementations of this method must be asynchronous.
 
 @param timeout       The time in seconds the caller is willing to wait for the ad to load.
 @param handler       An implementation of `VASInterstitialLoadCompletionHandler` that will be called when the ad finished loading.
 */
- (void)loadWithTimeout:(NSTimeInterval)timeout
      completionHandler:(VASInterstitialLoadCompletionHandler)handler;

/**
 Abort load if it is still active.
 */
- (void)abortLoad;

/**
 Show the ad.
 
 @param viewController        The view controller from which the ad must be shown.
 */
- (void)showFromViewController:(UIViewController *)viewController;

/**
 Release the resources loaded for the ad.
 */
- (void)releaseResources;

/**
 Informs the delegate that an impression has occurred and been reported. The delegate can then perform any additional actions, if needed. May be called an arbitrary thread.
 */
- (void)fireImpression;

/**
 The object implementing the `VASInterstitialAdAdapterDelegate` protocol to receive ad adapter event callbacks.
 */
@property (weak, nullable) id<VASInterstitialAdAdapterDelegate> delegate;

/**
 Specifies whether the ad should show or hide the status bar for a more complete full screen experience.
 */
@property (nonatomic, getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 Specifies the enter animation when the ad is shown.
 */
@property (nonatomic) NSInteger enterAnimationId;

/**
 Specifies the exit animation when the ad is closed.
 */
@property (nonatomic) NSInteger exitAnimationId;

@end

NS_ASSUME_NONNULL_END
