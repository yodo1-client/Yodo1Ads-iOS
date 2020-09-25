///
///  @file
///  @brief Definitions for VASAdSessionChangeEvent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdSessionEvent.h>

NS_ASSUME_NONNULL_BEGIN

/// The VASEvents eventId indicating a change occurred with the associated VASAdSession object. Check the adSession sessionId to identify the specific VASAdSession affected.
extern NSString * const kAdSessionChangesEventID;

/// A VASAdSessionEvent class that is sent as the `data` parameter of a VASEvents notification for any changes to the associated VASAdSession information.
@interface VASAdSessionChangeEvent : VASAdSessionEvent

/**
 The key of the ad session item that changed.
 */
@property (readonly) NSString *key;

/**
 The new value for the ad session item. Will be nil if the ad session item was removed.
 */
@property (readonly, nullable) id value;

/**
 The previous value for the ad session item that was replaced. Will be nil if the item did not previously exist.
 */
@property (readonly, nullable) id previousValue;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
