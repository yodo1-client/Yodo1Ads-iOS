///
/// @file
/// @brief Definitions of VASSupport VASClickEvent.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdSessionEvent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A unique identifier used for sending event notifications whenever the ad reports a click event. Subscribe a receiver using the VASEvents class with this identifier as the "topic" parameter. The event notifications will include the VASClickEvent object as the event data value.
 
 Event data type: VASClickEvent.
 */
extern NSString * const kVASClickEvent;

/**
 A class containing information regarding the clicking of an ad. Used as the data value of an VASEvent notification for the kVASClickEvent topic.
 */
@interface VASClickEvent : VASAdSessionEvent

/// The time when the ad was clicked.
@property (readonly) NSDate *clickTime;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
