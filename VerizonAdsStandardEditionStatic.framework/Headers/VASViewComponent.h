/////
/// @internal
/// @file
/// @brief Definitions for VASViewComponent
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import <VerizonAdsStandardEditionStatic/VASComponent.h>

NS_ASSUME_NONNULL_BEGIN

/// The fundamental protocol for all components that produce a viewable representation.
@protocol VASViewComponent <VASComponent>

/**
 The view representing the component, e.g. text, images, video, composite, etc. Will create the view if it has not yet been created. Will return nil if the view creation fails based on the requirements of the component.
 
 Access to the property must be on the main thread.
 */
@property (readonly, nullable) UIView *view;

@end

NS_ASSUME_NONNULL_END

