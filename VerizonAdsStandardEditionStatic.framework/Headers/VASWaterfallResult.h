///
/// @file
/// @brief Definitions for VASCore VASWaterfallResult.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASBid;
@class VASErrorInfo;
@class VASWaterfallItemResult;

/**
 A unique identifier used for sending event notifications whenever processing of a waterfall completes. Subscribe a receiver using the VASEvents class with this identifier as the "topic" parameter. The event notifications will include the VASWaterfallResult object as the event data value.

 Event data type: VASWaterfallResult.
 */
extern NSString * const kVASCoreTopicWaterfallResult;

@interface VASWaterfallResult : NSObject

/// A unique identifier for this waterfall request and all subsequent waterfall and waterfall item associated with this event.
@property (readonly) NSUInteger eventId;

/// The time when the waterfall request was initiated.
@property (readonly) NSDate *startTime;

/// Retrieves the bid information for the waterfall result. Will be null if the waterfall is not super auction.
@property (readonly, nullable) VASBid *bid;

/// The amount of time required for the completion of the event.
@property (readonly) NSTimeInterval elapsedTime;

/// If an error occurred while executing the corresponding waterfall event.
@property (readonly, nullable) VASErrorInfo *errorInfo;

/// The initial metadata for the waterfall.
@property (readonly, nullable) NSDictionary<NSString *, id> *metadata;

/// An array of all waterfall items that have been processed.
@property (readonly, nullable) NSArray<VASWaterfallItemResult *> *waterfallItemResults;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
