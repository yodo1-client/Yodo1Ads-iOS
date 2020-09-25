///
/// @file
/// @brief Implementation for VASVerizonNativeVideoView.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VerizonAdsOMSDK.h>
#import <VerizonAdsStandardEditionStatic/VASVideoPlayer.h>

NS_ASSUME_NONNULL_BEGIN

@class VASVerizonNativeVideoView;
typedef void(^VASVerizonVideoViewEventHandler)(VASVerizonNativeVideoView * _Nonnull videoView, NSString * _Nonnull eventId, NSDictionary<NSString *,id> * _Nullable eventArgs);

/**
 Represents a Verizon native video media view. Incorporates the VASVideoPlayer.
 
 Based on UIView, all calls must be made on the main queue unless otherwise stated.
 */
@interface VASVerizonNativeVideoView : UIView

/// The VASVideoPlayer object associated with the view.
@property (readonly) id<VASVideoPlayer> videoPlayer;

/// OMSDK video events object.
@property (nullable) OMIDOathVideoEvents *omVideoEvents;

/// The target percentage (0 - 100) for the view being defined as visible. The special identifier, kVASViewAtLeastOnePixelViewable, indicates notification should occur once at least one pixel of the view is visible.
@property (readwrite) NSInteger viewabilityPercent;

/**
 Create a new instance of this class ready to be added to a view.
 
 @param width       Specify the width of the resulting view. This is typically passed in from the server JSON response.
 @param height      Specify the height of the resulting view. This is typically passed in from the server JSON response.
 @param autoplay    Specify whether the video should autoplay. This is typically passed in from the server JSON response.
 @param autoplayThreshold   The viewability percent at which the playback will begin. Pass kVASViewAtLeastOnePixelViewable for at least one pixel or 0 (zero) to not check for a percentage.
 @param vasAds      The VASAds object to use.
 @param eventHandler    An optional block handler to receive any events this object generates.
 @return an instance of the class.
 */
- (instancetype)initWithWidth:(CGFloat)width
                       height:(CGFloat)height
                     autoplay:(BOOL)autoplay
          autoplayViewPercent:(NSInteger)autoplayThreshold
                       VASAds:(VASAds *)vasAds
                 eventHandler:(_Nullable VASVerizonVideoViewEventHandler)eventHandler NS_DESIGNATED_INITIALIZER;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)decoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
 Begin the load of the video asset, whether local or remote, which will begin playing once completely loaded and the viewability meets the minimum amount. Loading will occur asynchronously on another thread.
 
 @param url     An NSURL object specifying the location of the media to load.
 */
- (void)loadAsset:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
