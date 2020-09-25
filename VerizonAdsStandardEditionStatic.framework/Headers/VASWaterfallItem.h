///
/// @file
/// @brief Definitions for VASWaterfallItem.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdContent.h>
#import <VerizonAdsStandardEditionStatic/VASAdContentFetchResult.h>
#import <VerizonAdsStandardEditionStatic/VASAdSession.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol for providing waterfall item content.
 */
@protocol VASWaterfallItem <NSObject>

/// The waterfall item metadata returned from the server.
@property (readonly) NSDictionary<NSString *, id> *metadata;

/**
 Called by the SDK core when the waterfall item should return its ad content.
 Returns an VASAdContentFetchResult object that contains the VASAdContent if successful, or nil if not, along with an VASErrorInfo object.
 This is a synchronous call that will block until ad content is retrieved. It should not be called on the main thread.
 
 @param adSession   The VASAdSession associated with this waterfall item.
 @return an VASAdContentFetchResult object.
 */
- (VASAdContentFetchResult *)fetchAdContentUsingAdSession:(VASAdSession *)adSession;

@end

NS_ASSUME_NONNULL_END
