///
///  @file
///  @brief Definitions for VASNativeViewComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASNativeComponent.h>
#import <VerizonAdsStandardEditionStatic/VASViewComponent.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VASNativeViewComponent <VASNativeComponent, VASViewComponent>

/**
 Will return YES if the component view has been created and is currently a subview of the passed view. Will not create the view and returns NO if not created.
 
 @param view    The view to check descendancy of the view component's view.
 @return YES if the view component's view is a subview of view.
 */
- (BOOL)isDescendantOfView:(UIView *)view;

/**
 Prepares the view that the component should use (used when loading layouts where views have already been created)
 
 @param view  The view to use for the component.
 @return nil if successful; otherwise a non-nil VASErrorInfo.
 */
- (nullable VASErrorInfo *)prepareView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
