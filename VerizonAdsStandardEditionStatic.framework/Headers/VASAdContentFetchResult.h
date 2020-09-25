///
/// @file
/// @brief Definitions of VASAdContentFetchResult.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASAdContent;
@class VASErrorInfo;

/**
 Response object returned by the VASWaterfallItem fetchAdContent call.
 */
@interface VASAdContentFetchResult : NSObject

/**
 The content of the ad. Nil if an error occurs.
 */
@property (readonly) VASAdContent *adContent;

/**
 Error details related to the call to fetchAdContent. Nil if fetchAdContent succeeds.
 */
@property (readonly) VASErrorInfo *errorInfo;

/**
 Use to create a response with ad content.
 
 @param adContent The VASAdContent object for the request. If a failure occurs, pass nil.
 @return an instance of this class.
 */
- (instancetype)initWithAdContent:(nullable VASAdContent *)adContent NS_DESIGNATED_INITIALIZER;

/**
 Use to create a response with an error.
 
 @param errorInfo If VASAdContent could not be generated, return the appropriate error here.
 @return an instance of this class.
 */
- (instancetype)initWithErrorInfo:(nullable VASErrorInfo *)errorInfo NS_DESIGNATED_INITIALIZER;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
