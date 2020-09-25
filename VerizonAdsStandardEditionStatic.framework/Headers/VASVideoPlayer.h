///
/// @file
/// @brief Definitions for VASVideoPlayer protocol
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASViewComponent.h"

NS_ASSUME_NONNULL_BEGIN
/**
 Possible states of Video Player
 */
typedef NS_ENUM(NSUInteger, VASVideoPlayerState) {
    /// Default state, indicates that Video player was created and initialized, but media is not loaded yet.
    VASVideoPlayerStateIdle = 0,
    /// Indicates that Video player is loading media.
    VASVideoPlayerStateLoading,
    /// Indicates that Video player successfully loaded media.
    VASVideoPlayerStateLoaded,
    /// Indicates that Video player is ready for playing media.
    VASVideoPlayerStateReady,
    /// Indicates that Video player is playing video.
    VASVideoPlayerStatePlaying,
    /// Indicates that Video player paused playback.
    VASVideoPlayerStatePaused,
    /// Indicates that Video player completed playing.
    VASVideoPlayerStateCompleted,
    /// Indicates that an error has occurred.
    VASVideoPlayerStateError
};

/**
 Possible error codes of Video Player
 */
typedef NS_ENUM(NSUInteger, VASVideoPlayerErrorCode) {
    /// Performing operations when the current state does not allow this.
    VASVideoPlayerErrorCodeWrongState = 1,
    /// Unsupported media format, or encrypted.
    VASVideoPlayerErrorCodeUnsupportedFormat,
    /// AVPlayer internal error.
    VASVideoPlayerErrorCodeInternal,
};

/**
 A video player protocol so multiple video players can conform to
 a common API.
 */
@protocol VASVideoPlayer <VASViewComponent>

/// The played url
@property (readonly, nullable) NSURL *url;

/// State of the player
@property (readonly) VASVideoPlayerState state;

#pragma mark - Loading

/**
 Load video content, transitions from current state to VASVideoPlayerStateLoading.
 Only valid for states that can transition to VASVideoPlayerStateLoading.
 @param url The URL of video file that should be played.
 */
- (void)loadURL:(NSURL *)url;

/**
 Stops playback, unloads video content from memory and detaches the video drawing view.
 Transitions to the VASVideoPlayerStateIdle state.
 */
- (void)unload;

#pragma mark - Playing

/// Returns the current playback position.
@property (readonly) NSTimeInterval currentPosition;

/// Returns the duration of video or kVASValueUnavailable if the duration is unknown.
@property (readonly) NSTimeInterval duration;

/**
 Moves the playback to new position.

 @param newPosition New playback position.
 */
- (void)seekToPosition:(NSTimeInterval)newPosition;

/// Set playback progress notification interval (in seconds).
@property (nonatomic, readwrite) NSTimeInterval progressUpdateInterval;

/**
 Play video only if player is in VASVideoPlayerStateReady state.
 */
- (void)play;

/**
 Pause video. Valid only in the VASVideoPlayerStatePlaying state.
 */
- (void)pause;

#pragma mark - Playback Controls

/**
 Use this method to set whether the mute/unmute toggle should be visible.

 @param enabled YES if the mute/unmute toggle should be visible.
 */
- (void)setMuteToggleEnabled:(BOOL)enabled;

/**
 Use this method to set whether the replay button should be visible.
 Note that the video player implementation will still have
 logic to determine when the replay button should be visible even when enabled.

 @param enabled YES if the replay button should be visible upon video completion.
 */
- (void)setReplayButtonEnabled:(BOOL)enabled;

/**
 Use this method to set whether the play button should be visible.
 Note that the video player implementation will still have
 logic to determine when the play button should be visible even when enabled.
 Play button is generally only needed if autoplay is disabled.

 @param enabled YES if the play button should be visible.
 */
- (void)setPlayButtonEnabled:(BOOL)enabled;

#pragma mark - Volume

/// Adjust the volume of the player alone, without modifying the system volume. DEFAULT VALUE: System volume
@property (nonatomic, readwrite) float volume;

#pragma mark - Events

/// Called when the video player loaded the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^loaded)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player is ready to play the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^ready)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player unloaded the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^unloaded)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player began playing the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^played)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player paused the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^paused)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player completed playing the media. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^completed)(id<VASVideoPlayer> videoPlayer);

/// Called when the video player completed seek to specific time. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^seekCompleted)(id<VASVideoPlayer> videoPlayer);

/// Called when an error occurred. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^errorOccurred)(id<VASVideoPlayer> videoPlayer, NSError *error);

/// Video heartbeat callback. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^progress)(id<VASVideoPlayer> videoPlayer, NSTimeInterval seconds);

/// Called when the volume was changed. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^volumeChanged)(id<VASVideoPlayer> videoPlayer, float volume);

/// Called when the video player was clicked. Implementers of
/// this protocol should address in their own documentation whether
/// this callback is invoked on a particular thread or not.
@property (copy) void(^clicked)(id<VASVideoPlayer> videoPlayer);

@end

NS_ASSUME_NONNULL_END
