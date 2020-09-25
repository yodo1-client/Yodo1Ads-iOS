///
/// @internal
/// @file
/// @brief Definitions for VASForceOrientationProperties.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Possible orientation options.
typedef NS_ENUM(NSInteger, VASForceOrientation) {
    VASForceOrientationNone,
    VASForceOrientationPortrait,
    VASForceOrientationLandscape
};

/// The detail needed in order to force a view controller to the specified orientation.
@interface VASForceOrientationProperties : NSObject

/// Indicates that the orientation should be allowed to change.
@property (nonatomic) BOOL allowOrientationChange;

/// The orientation that we should force onto a view controller.
@property (nonatomic) VASForceOrientation forceOrientation;

@end

NS_ASSUME_NONNULL_END
