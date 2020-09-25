///
/// @file
/// @brief Definitions for VASHTTPUtil.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

/// The default timeout used by this class.
extern const NSTimeInterval kDefaultRequestTimeout;

/// Completion handler for HTTP async data requests.
typedef void (^VASHTTPDataCompletionHandler)(NSData * _Nullable data, NSURLResponse * _Nullable response, VASErrorInfo * _Nullable error);

/// Completion handler for HTTP async download requests.
typedef void (^VASHTTPDownloadCompletionHandler)(NSURL * _Nullable location, NSURLResponse * _Nullable response, VASErrorInfo * _Nullable error);

/// Completion handler for HTTP resolveURL.
typedef void (^VASHTTPResolveURLCompletionHandler)(NSURL * _Nullable resolvedURL, VASErrorInfo * _Nullable error);

/**
 HTTP utilities that provide a consistent implementation for some common HTTP needs.
 Aside from some simple helpers, the main methods wrap NSURLSession, adding a common approach to background task handling
 and transforming any server or response errors to their VASErrorInfo equivalent.
 */
@interface VASHTTPUtil : NSObject

/// The User Agent that would be returned from a web view. Will always be a string (empty if user agent could not be obtained).
@property (class, nonatomic, strong, readonly) NSString *userAgent;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Percent encode a string using the RFC 3986 specification. More specifically, this will encode anything that's not an unreserved character.
 Do not try to encode a string that was already encoded because that would result in double encoding.
 @param string String data to percent encode.
 @return An immutable percent encoded string.
 */
+ (nullable NSString *)stringByAddingPercentEncodingForRFC3986:(NSString *)string;

/**
 Percent encode a string using typical HTML form input encoding rules.
 Do not try to encode a string that was already encoded because that would result in double encoding.
 @param string          String data to percent encode.
 @param plusForSpace    Use plus for the space character instead of percent encoding.
 @return An immutable percent encoded string.
 */
+ (nullable NSString *)stringByAddingPercentEncodingForFormData:(NSString *)string usingPlusForSpace:(BOOL)plusForSpace;

/**
 Escape a body of text to be valid as a Javascript argument, e.g. quotes, tab, newlines, etc. "\t" -> "\\t". "\"" -> "\\\"", "'" -> "\'".
 @param string      String data to text encode.
 @return a new immutable, encoded string.
 */
+ (NSString *)javascriptEscapedString:(NSString *)string;

/**
 Create an `NSMutableURLRequest` that represents a POST request with the specified properties.
 This is for convenience when setting common properties, and can be further customized as required.
 @param url         URL for the POST request.
 @param body        Body of the POST request.
 @param contentType Content type of the POST request.
 @param timeout     Timeout for the POST request.
 @param cachePolicy Cache policy for the POST request.
 @return A mutable URL request that can be used to perform an HTTP POST request.
 */
+ (NSMutableURLRequest *)postURLRequestWithURL:(NSURL *)url
                                          body:(NSData *)body
                                   contentType:(NSString *)contentType
                                       timeout:(NSTimeInterval)timeout
                                   cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

/**
 Create an `NSMutableURLRequest` that represents a GET request with the specified properties.
 This is for convenience when setting common properties, and can be further customized as required.
 @param url         URL for the GET request.
 @param timeout     Timeout for the GET request.
 @param cachePolicy Cache policy for the GET request.
 @return A mutable URL request that can be used to perform an HTTP GET request.
 */
+ (NSMutableURLRequest *)getURLRequestWithURL:(NSURL *)url
                                      timeout:(NSTimeInterval)timeout
                                  cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

/**
 Create an `NSMutableURLRequest` that represents a GET request with the specified properties.
 This is for convenience when setting common properties, and can be further customized as required.
 This will percent encode the URL params and it will resolve ther URL against its base URL before parsing.
 @param url         URL for the GET request.
 @param queryItems  Query item array for the GET request. See `NSURLComponents` and `NSURLQueryItem` for more details.
 @param timeout     Timeout for the GET request.
 @param cachePolicy Cache policy for the GET request.
 @return A mutable URL request that can be used to perform an HTTP GET request.
 */
+ (NSMutableURLRequest *)getURLRequestWithURL:(NSURL *)url
                                   queryItems:(nullable NSArray<NSURLQueryItem *> *)queryItems
                                      timeout:(NSTimeInterval)timeout
                                  cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

/**
 Create an `NSMutableURLRequest` that represents a GET request with the specified properties.
 This is for convenience when setting common properties, and can be further customized as required.
 This will percent encode the URL params and it will resolve ther URL against its base URL before parsing.
 @param url         URL for the GET request.
 @param queryParams Query param dictionary for the GET request. A simple dictionary that represents query params. `NSString` objects are used directly, `NSDate` objects are converted using `timeIntervalSince1970`, anything else that supports NSValue uses `stringValue`, and finally the `description` is used as a last resort. If you need more control over this conversion, use the `queryItems` version of this call instead.
 @param timeout     Timeout for the GET request.
 @param cachePolicy Cache policy for the GET request.
 @return A mutable URL request that can be used to perform an HTTP GET request.
 */
+ (NSMutableURLRequest *)getURLRequestWithURL:(NSURL *)url
                                  queryParams:(nullable NSDictionary<NSString *, id> *)queryParams
                                      timeout:(NSTimeInterval)timeout
                                  cachePolicy:(NSURLRequestCachePolicy)cachePolicy;

/**
 Resolve a URL by following all redirects, using NSMutableURLRequest with HTTPMethod 'HEAD', using
 VASHTTPUtil's asyncDataTaskWithRequest:usingSession:completion.
 @param url         The URL to resolve.
 @param session     The session to use to make the request.
 @param completion  The completion handler to use when the request is complete. The handler is called on an arbitrary queue.
 */
+ (void)resolveURL:(NSURL *)url
      usingSession:(NSURLSession *)session
        completion:(VASHTTPResolveURLCompletionHandler)completion;

/**
 Perform a synchronous request, returning the data, reponse, and error code.
 This is a blocking call and will not return until the request is complete, a timeout occurs, or an error occurs.
 @param request     The URL request details.
 @param session     The session to use to make the request.
 @param response    The response of the request.
 @param error       The error or `nil` if no error occurred.
 @return The data that was returned after waiting for the request to complete or `nil` if an error occurred.
 */
+ (NSData *)syncDataTaskWithRequest:(NSURLRequest *)request
                       usingSession:(NSURLSession *)session
                       withResponse:(NSURLResponse * _Nullable __autoreleasing * _Nonnull)response
                              error:(VASErrorInfo * _Nullable __autoreleasing * _Nonnull)error;

/**
 Perform an asynchronous data request, returning the data task that was created, and resumed.
 @param request     The URL request details.
 @param session     The session to use to make the request.
 @param completion  The completion handler to use when the request is complete. The handler is called on an arbitrary queue.
 @return A data task that has already been resumed and is in progress.
 */
+ (NSURLSessionDataTask *)asyncDataTaskWithRequest:(NSURLRequest *)request
                                      usingSession:(NSURLSession *)session
                                        completion:(VASHTTPDataCompletionHandler)completion;

/**
 Perform an asynchronous download request, returning the download task that was created, and resumed.
 @param request     The URL request details.
 @param session     The session to use to make the request.
 @param completion  The completion handler to use when the request is complete. The handler is called on an arbitrary queue.
 @return A download task that has already been resumed and is in progress.
 */
+ (NSURLSessionDownloadTask *)downloadTaskWithRequest:(NSURLRequest *)request
                                         usingSession:(NSURLSession *)session
                                           completion:(VASHTTPDownloadCompletionHandler)completion;

@end

NS_ASSUME_NONNULL_END
