///
/// @file
/// @brief Definitions for VASTapRecognizer.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 Utility method to create a UITapGestureRecognizer, attach to a view, and be notified for each tap.
 */
@interface VASTapRecognizer : NSObject

/// The view to which the tap gesture recognizer has been attached. Weak attribute will reset the view to nil if it is released.
@property (readonly, weak, nullable) UIView *view;

/*
 Create an instance of the class that installs a gesture recognizer.
 
 @param view        The view to which the gesture recognizer will be attached.
 @param tapHandler  The block callback called for each tap.
 @return an instance of this class with an active gesture recognizer.
 */
// DEPRECATED 0.5.0-SNAPSHOT, use allowSimultaneous version.
- (instancetype)initForView:(UIView *)view
                withHandler:(void(^)(UITapGestureRecognizer *recognizer))tapHandler;

/*
 Create an instance of the class that installs a gesture recognizer.
 
 @param view        The view to which the gesture recognizer will be attached.
 @param allowSimultaneous   Facilitate web views by allowing the simultaneous recognition of other tap gesture recognizers.
 @param tapHandler  The block callback called for each tap.
 @return an instance of this class with an active gesture recognizer.
 */
- (instancetype)initForView:(UIView *)view
          allowSimultaneous:(BOOL)allowSimultaneous
                withHandler:(void(^)(UITapGestureRecognizer *recognizer))tapHandler NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// Permanently remove the tap gesture recognizer from the view.
- (void)removeTapRecognizer;

@end

NS_ASSUME_NONNULL_END
