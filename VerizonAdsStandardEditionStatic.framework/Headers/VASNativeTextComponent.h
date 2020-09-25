///
///  @file
///  @brief Definitions for VASNativeTextComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASNativeViewComponent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 API definition for native text components.
 
 This protocol extends the VASNativeViewComponent protocol with readwrite accessors to some aspects of the text and its properties. All access to these properties must be performed on the main thread, as with all UI activity.
 
 Note that the `view` property defined on VASNativeViewComponent is returned as a UILabel in the case of components that conform to this protocol if access to other properties such as textAlignment are required.
 */
@protocol VASNativeTextComponent <VASNativeViewComponent>

/// The current text value of the component.
@property (nonatomic, readonly) NSString *text;

/// The font of the compnent.
@property (nonatomic, nullable) UIFont *font;

/// The text color of the component.
@property (nonatomic, nullable) UIColor *textColor;

/// The background color of the component.
@property (nonatomic, nullable) UIColor *backgroundColor;

@end

NS_ASSUME_NONNULL_END
