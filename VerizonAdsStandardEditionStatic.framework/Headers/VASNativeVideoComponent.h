///
///  @file
///  @brief Definitions for VASNativeVideoComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASNativeViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 API definition for native video components.
 */
@protocol VASNativeVideoComponent <VASNativeViewComponent>

/// The current playback state of the video asset within this component, YES if playing, NO otherwise.
@property (readonly) BOOL isPlaying;

/// Set the percentage at which video playback pauses or resumes playback. Percentage is represented between 0 - 100 or the special identifier, kVASViewAtLeastOnePixelViewable (-1).
@property (readwrite) NSInteger autoplayThresholdPercentage;

/// The "natural" height of the video in points. Returns 0 if the video is not available.
@property (readonly) CGFloat height;

/// The "natural" width of the video in points which may take into account non-square pixel aspect ratios. Returns 0 if the video is not available.
@property (readonly) CGFloat width;

/// Starts playback of the video asset within this component.
- (void)play;

/// Pauses the playback of the video asset within this component.
- (void)pause;

/// Replays the video asset within this component.
- (void)replay;

/// Mutes the audio of this component.
- (void)mute;

/// Unmutes the audio of this component.
- (void)unmute;

@end

NS_ASSUME_NONNULL_END
