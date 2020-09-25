///
/// @internal
/// @file
/// @brief Definitions for VASWebView+Private.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASWebView.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Utility function to find a tag without <>.

 @param tag The tag to find within the HTML.
 @param html The HTML to search.
 @return a NSRange of the tag.
 */
NSRange findTag(NSString *tag, NSString *html);


@interface VASWKWebView : WKWebView
@property (nonatomic, weak) VASWebView *vasAdsWebView;
@end

@interface VASWebView (Private)

/// The underlying WKWebView objct. Not protected, only access on the main thread.
@property (nonatomic) VASWKWebView *wkWebView;

/// Used internally to track the current navigation request and reconcile delegate callbacks with the current navigation operation (e.g., load->finish). Not protected, only set internally on load functions.
@property (nonatomic, nullable) WKNavigation *currentNavigation;

/// Read/write state of the view being tapped. Thread-safe.
@property BOOL viewTapped;

/// Read/write state of the modal being displayed. Thread-safe.
@property BOOL modalDisplayed;

/**
 Read/write. The base class defines loaded as arriving at the webView:didFinishNavigation: call. Subclasses may define it differently based on class-specific criteria like loading additional resources, executing scripts, etc.
 This value is KVO-compliant (by default) and could be observed to know when the view has completed loading or when resources released to no longer be loaded.
 */
@property BOOL loaded;

// Completion handling. Not protected, only access on the main thread.
@property (nonatomic) VASWebViewLoadCompletionHandler loadCompletionHandler;

/**
 The starting point to begin the process of calling subclassses to collect and inject meta and script tags as well as Verizon JSBridge files into the provided raw HTML. It will trigger calls to preprocessRawHTML, createScriptTagsToInject, and createMetaTagsToInject.
 @param rawHtml The initial HTML where the injected tags will go.
 @return a final string of the processed, tag-injected HTML.
 */
- (NSString *)injectJSBridgeUsingHTML:(NSString *)rawHtml NS_REQUIRES_SUPER;

/**
 Implement this to modify contents before handing it off to the main processor, e.g. removing the mraid.js tag.
 Subclasses should implement this method if they have any preprocessing needs and then return with a call to [super preprocessRawHTML:] with the modified HTML to allow base classes to do their preprocessing work.
 @param rawHtml The HTML to preprocess.
 @return a mutable string of the processed HTML.
 */
- (NSMutableString *)preprocessRawHTML:(NSMutableString *)rawHtml NS_REQUIRES_SUPER;

/**
 Returns the script tags into the VASWebView.
 Subclasses should implement this method if they have additional script tags to include and call [super createScriptTagsToInject] to retrieve base class tags and combine with subclass tags for return.

 @return an array of NSString script tags to inject.
 */
- (nullable NSArray<NSString *> *)createScriptTagsToInject NS_REQUIRES_SUPER;

/**
 Returns the meta tags into the VASWebView.
 Subclasses should implement this method if they have additional meta tags to include and call [super createMetaTagsToInject] to retrieve base class tags and combine with subclass tags for return.
 
 @return an array of NSString meta tags to inject.
 */
- (NSArray<NSString *> *)createMetaTagsToInject NS_REQUIRES_SUPER;

/**
 A wrapper for executeJavascript:withGenericCompletion: passing nil for the completion block.

 @param javascript The Javascript to execute via the WKWebView evaluateJavaScript command.
 */
- (void)executeJavascript:(NSString *)javascript;

/**
 Execute the passed javascript on this object's wkWebView object returning the result in the completion block. The command may be called from any queue as it is dispatched to the main tbread internally and the completion block is called on the main thread.
 
 See VASWebView+Test.h/.m for variants of this validating boolean and NSDictionary variants if needed.

 @param javascript The Javascript to execute via the WKWebView evaluateJavaScript command.
 @param completion The callback completion block after the javascript has been executed.
 */
- (void)executeJavascript:(NSString *)javascript withGenericCompletion:(nullable void (^)(id _Nullable result, NSError * _Nullable error))completion;

/**
 Informs the object that an impression has occurred and been reported. The object can then perform any additional actions, if needed.  May be called an arbitrary thread.
 */
- (void)fireImpression;

#pragma mark - Open Measurement / OMSDK

/**
 YES once the impression has been registered with OpenMeasurement SDK. Will only occur once per instance of this class. It is KVO-compliant and can be observed to know when an ad impression has occurred. (Should also correlate to VASEvents kVASImpressionEvent.)
 */
@property (readonly) BOOL omImpressionFired;

/**
 A support method for OpenMeasurement. All subclasses should call super and add their own UIView objects that overlay the WKWebView such as close buttons, AdChoices, video playback, etc. which should not be considered as obstructing the underlying view.
 @return an array of UIView that should not be considered to be obstructing. Returns nil if no obstructions exist.
 */
- (nullable NSArray<UIView *> *)omFriendlyObstructions NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
