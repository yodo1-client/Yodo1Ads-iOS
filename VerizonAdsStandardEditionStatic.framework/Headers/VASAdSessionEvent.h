///
///  @file
///  @brief Definitions for VASAdSessionEvent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASAdSession;

/// A class containing information regarding the adSession. Used as the data value of a VASEvents notification for a VASAdSession.
@interface VASAdSessionEvent : NSObject

/**
 The VASAdSession instance that is responsible for this event notification.
 */
@property (readonly) VASAdSession *adSession;

- (instancetype)initWithAdSession:(VASAdSession *)adSession;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
