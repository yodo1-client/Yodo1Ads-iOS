///
/// @file
/// @internal
/// @brief Definitions for the UIView+VASAds.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>

@interface UIView (VASAds)

- (void)vas_setupGestureRecognizerWithTarget:(id)target selector:(SEL)selector;
- (void)vas_removeGestureRecognizer;

@end
