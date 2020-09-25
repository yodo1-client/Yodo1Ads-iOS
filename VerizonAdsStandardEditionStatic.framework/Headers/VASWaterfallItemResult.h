///
/// @file
/// @brief Implementation of VASCore VASWaterfallItemResult.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASWaterfallResult;
@class VASErrorInfo;

@interface VASWaterfallItemResult : NSObject

/// The time when the waterfall item request was initiated.
@property (readonly) NSDate *startTime;

/// The amount of time required for the completion of the event.
@property (readonly) NSTimeInterval elapsedTime;

/// If an error occurred while executing the corresponding waterfall event.
@property (readonly, nullable) VASErrorInfo *errorInfo;

/// The initial metadata from the waterfall item.
@property (readonly, copy, nullable) NSDictionary<NSString *, id> *metadata;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
