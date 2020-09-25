///
/// @file
/// @brief Definitions for VASWebView
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <WebKit/WebKit.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

@class VASWebView;

#pragma mark - VASWebViewDelegate

/**
 Protocol for receiving notifications from the VASWebView.
 */
@protocol VASWebViewDelegate <NSObject>
@required

/**
 Called when an error has occurred.
 
 @param webView     The calling VASWebView.
 @param errorInfo   An VASErrorInfo object containing details about the error.
 */
- (void)webView:(VASWebView *)webView didFailWithError:(VASErrorInfo *)errorInfo;

/**
 Called when the ad should be forced to a specific orientation.
 
 @param webView                 The calling VASWebView.
 @param orientationProperties   The orientation details to which the view should be forced too.
 */
- (void)webView:(VASWebView *)webView shouldForceToOrientation:(VASForceOrientationProperties *)orientationProperties;

/**
 Called when the VASWebView has been clicked.
 
 @param webView The calling VASWebView.
 */
- (void)clickedWebView:(VASWebView *)webView;

/**
 Called when the user taps the ad close button.
 
 @param webView The calling VASWebView being closed.
 */
- (void)closedWebView:(VASWebView *)webView;

/**
 Must be implemented for inline ad support only.
 
 Called when the ad requests it be unloaded.
 
 @param webView The calling VASWebView being unloaded.
 */
- (void)unloadWebView:(VASWebView *)webView;

/**
 Called in response to a tap to expand the ad.
 
 @param webView The calling VASWebView.
 */
- (void)expandedWebView:(VASWebView *)webView;

/**
 Called when the ad is resized.
 
 @param webView The calling VASWebView.
 */
- (void)resizedWebView:(VASWebView *)webView;

/**
 Called when the VASWebView ad content will leave the application.
 
 @param webView The calling VASWebView.
 */
- (void)adContentDidLeaveApplicationForWebView:(VASWebView *)webView;

/**
 Called prior to expanding an ad into a fullscreen view in response to a user ad tap. Also used for responding to some special features such as MRAID calendar event generation, photo saving, etc. to provide the UI for the system functionality.
 
 @return a UIViewController capable of presenting another view controller to use for displaying the fullscreen ad. Returning nil will result in no fullscreen ad being displayed and an error returned to the ad.
 */
- (nullable UIViewController *)adPresentingWebViewController;

@end

#pragma mark - VASWebView

/// Completion handler for VASWebView loadHTMLString: invocations. The handler's VASErrorInfo will be non-nil if an error occurred.
typedef void (^VASWebViewLoadCompletionHandler)(VASErrorInfo * _Nullable error);


/// A custom webView implementation containing SDK specific hooks.
@interface VASWebView : UIView <WKNavigationDelegate, WKUIDelegate>

/// The object implementing the VASWebViewDelegate protocol, to receive VASWebView event callbacks.
@property (weak, nullable) id<VASWebViewDelegate> delegate;

/// Returns the URL that is currently loaded into the VASWebView or nil if the VASWebView was destroyed.
@property (nonatomic, readonly, copy) NSURL *URL;

/// The VASAds object used in the initializer.
@property (readonly) VASAds *vasAds;

/// Indicates if the ad for this instance has been destroyed.
@property (readonly) BOOL isDestroyed;

/**
 Initialize a new VASWebView.
 
 @param frame       The frame for the VASWebView.
 @param delegate    The object that should receive VASWebViewDelegate callbacks.
 @param vasAds     The VASAds instance for this object to use.
 @return An initialized instance of this class.
 */
- (instancetype)initWithFrame:(CGRect)frame
                     delegate:(id<VASWebViewDelegate>)delegate
                      vasAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 This method loads the VASWebView with the provided HTML content. Subclasses should call the super at the end of their methods with an HTML string updated as needed with injected or modified HTML.
 
 @param string The HTML content string to load.
 @param baseURL The base URL to use when loading content.
 @param completion Block that is executed when the VASWebView load is complete.  The error parameter will be nil if the VASWebView loaded sucessfully.
 */
- (void)loadHTMLString:(NSString *)string
               baseURL:(nullable NSURL *)baseURL
            completion:(VASWebViewLoadCompletionHandler)completion NS_REQUIRES_SUPER;

/**
 This method loads the VASWebView with the provided HTML content.
 
 This method may be used on iOS 9+ only.
 
 @param data The data to load.
 @param MIMEType The MIMEType of the data, if nil, defaults to 'text/html'.
 @param characterEncodingName The data's character encoding name.
 @param baseURL The base URL to use when loading content.
 @param completion Block that is executed when the VASWebView load is complete.  The error parameter will be nil if the VASWebView loaded sucessfully.
 */
- (void)loadData:(NSData *)data
        MIMEType:(nullable NSString *)MIMEType
characterEncodingName:(NSString *)characterEncodingName
         baseURL:(nullable NSURL *)baseURL
      completion:(VASWebViewLoadCompletionHandler)completion API_AVAILABLE(ios(9.0));

/**
 This method releases the VASWebView resources by stopping all activity and destroying its internal state. After this method is called, the VASWebView is invalid and no more calls should be made to it.
 */
- (void)releaseResources NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
