///
/// @file
/// @brief Defines VASVerizonVideoView functionality.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import <VerizonAdsStandardEditionStatic/VASVideoPlayer.h>
#import <VerizonAdsStandardEditionStatic/VASComponent.h>
#import <VerizonAdsStandardEditionStatic/VASComponentFactory.h>

NS_ASSUME_NONNULL_BEGIN

/// The domain for Verizon Video Player errors.
FOUNDATION_EXPORT NSErrorDomain const kVASVideoPlayerErrorDomain;

FOUNDATION_EXTERN const NSInteger kVASVideoPlayerValueUnavailable;
FOUNDATION_EXTERN const float kVASVideoPlayerDefaultVolumeValue;
FOUNDATION_EXTERN const NSTimeInterval kVASVideoPlayerDefaultProgressUpdateValue;

@interface VASVerizonVideoViewFactory : NSObject <VASComponentFactory>

@end

/**
 VASVerizonVideoView class, a UIView which implements the `VASVideoPlayer`
 protocol and plays supported media URLs.

 Please note that the callback blocks, such as for the `played`, `paused`
 and `completed` properties, may be called on any thread. Users of this
 class are responsible for ensuring that their callback code is prepared
 to be invoked on any thread.
 */
@interface VASVerizonVideoView : UIView <VASVideoPlayer>

@end

NS_ASSUME_NONNULL_END
