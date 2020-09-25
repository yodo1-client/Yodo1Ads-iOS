///
/// @file
/// @brief Definitions of VASImpressionEvent.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdSessionEvent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A unique identifier used for sending event notifications whenever the ad reports an impression event. Subscribe a receiver using the VASEvents class with this identifier as the "topic" parameter. The event notifications will include the VASImpressionEvent object as the event data value.
 
 Event data type: VASImpressionEvent.
 */
extern NSString * const kVASImpressionEvent;

/**
 A class containing information regarding the display of an ad. Used as the data value of an VASEvent notification for the kVASCoreTopicDisplayEvent topic.
 */
@interface VASImpressionEvent : VASAdSessionEvent

/// The time when the ad was displayed.
@property (readonly) NSDate *impressionTime;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
