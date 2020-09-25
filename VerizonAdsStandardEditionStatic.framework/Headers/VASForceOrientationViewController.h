///
/// @internal
/// @file
/// @brief Definitions for VASForceOrientationViewController.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import "VASForceOrientationProperties.h"

NS_ASSUME_NONNULL_BEGIN

/*
 Base class for view controllers that should have the ability to be forced to a specific orientation.
 */
@interface VASForceOrientationViewController : UIViewController

/*
 Create an instance of the class.
 
 @param orientationProperties   The details of the orientation with which the view controller is set up.
 */
- (instancetype)initWithOrientationProperties:(nullable VASForceOrientationProperties *)orientationProperties NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/*
 Forces the view controller into a different orientation.
 
 @param orientationProperties   The details of the orientation to which the view controller will be set.
 */
- (void)forceToOrientation:(VASForceOrientationProperties *)orientationProperties;

@end

NS_ASSUME_NONNULL_END
