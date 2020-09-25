///
///  @file
///  @brief Definitions for VASNativeImageComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASNativeViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 API definition for native image components.
 */
@protocol VASNativeImageComponent <VASNativeViewComponent>

/// The URL of the image asset used by this component.
@property (readonly) NSURL *URL;

/// The background color of the component.
@property (nonatomic, nullable) UIColor *backgroundColor;

/// The tint color of the component.
@property (nonatomic, nullable) UIColor *tintColor;

/// The alpha of the component.
@property (readonly) CGFloat alpha;

/// The height (points) of the component. Returns zero if the image is not available.
@property (readonly) CGFloat height;

/// The width (points) of the component. Returns zero if the image is not available.
@property (readonly) CGFloat width;

@end

NS_ASSUME_NONNULL_END
