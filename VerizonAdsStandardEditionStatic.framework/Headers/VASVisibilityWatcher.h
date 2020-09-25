///
/// @file
/// @brief Definitions of VASVisibilityWatcher.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

@class VASScheduler;

NS_ASSUME_NONNULL_BEGIN

/// Use kVASViewAtLeastOnePixelViewable for the percent visible to specify at least one pixel is visible.
extern const NSInteger kVASViewAtLeastOnePixelViewable;


/*
 A utility function that returns the intersecting rect between the specified view and its parent window. Returns CGRectNull if the view is nil, hidden, or the app has backgrounded. This function does not check if the view is obscured by another view.
 
 @param view  The target view to calculate.
 @return the visible CGRect bounds.
 */
CGRect VASVisibleViewRect(UIView * _Nullable view);

/*
 A utility function that calculates the percent of subRect that is contained within masterRect.
 
 @param subRect     The rect percentage to calculate.
 @param masterRect  The parent rectangle to serve as the denominator of the percentage calculation.
 @return the percentage of subRect within masterRect represented as 0.0 - 1.0.
 */
CGFloat VASPercentRectVisible(CGRect subRect, CGRect masterRect);


#pragma mark - VASVisibilityWatcher

/*
 VASVisibilityWatcher provides the ability to be notified when a view becomes visible and invisible. Visibility is defined as a percentage of the view that is visible within its parent view and screen bounds.
 */
@interface VASVisibilityWatcher : NSObject

/// The view being watched as specified at initialization. Held under a weak reference which will automatically stop reporting visibility changes after the view is released. See initWithView for more information.
@property (readonly, weak, nullable) UIView *view;

/// Indicates that the view or an ancestor is hidden, including an opacity of 0 or if not within a window hierarchy. Does not account for the view being offscreen or covered by another view. This is independent of the target visibility percentage. Returns YES if the view has been released (see view property).
@property (readonly) BOOL isHidden;

/// Indicates that the view is visible according to the visibility percentage specified at initialization (see targetPercentage property). Calculates being offscreen but does not account for being covered by another view. Returns NO if the conditions of the isHidden property are true, or if the app state is not UIApplicationStateActive.
@property (readonly) BOOL isVisible;

/// The target percentage (0 - 100) defined in the initializer to declare a view as being visible. Zero percent will notify upon adding of the view within the window. The special identifier, kVASViewAtLeastOnePixelViewable, indicates notification should occur once at least one pixel of the view is visible. For any defined percentage, no notification will be sent if the view is hidden as defined by the isHidden property.
@property (readonly) NSInteger targetPercent;

/// Calculates the current percentage (0 - 100) visibility of the view within its parent but does not account for any overlapping views. If the view is hidden as defined by the isHidden property, then the value will be 0.
@property (readonly) NSInteger visibilityPercent;

/*
 Initialize an instance of the class to begin watching for visibility changes of the specified view for the target visibility percentage. If the view goes away, one final visibility change to NO will be reported only if it had previously reported a visible view. No more calls to the handler will be made after that.
 This method does not need to be called on the main thread. However, the visibilityChange handler will always be called on the main thread.
 
 @param view            The view to watch for visibility changes.
 @param scheduler       The VASScheduler to use for the watcher, typically the VASAds scheduler object.
 @param targetPercent   The target percentage (0-100) of the view to be visible to trigger a call to the handler. Specify the predefined value kVASViewAtLeastOnePixelViewable to indicate at least one pixel. A zero percentage does not require the view to be visible (see the targetPercentage property).
 @param handler         The callback handler called when the view achieves the desired visibility percentage or, having achieved visibility, falls below it and reports no longer visible. Will continue to report these visibility changes until stopWatching is called, the view goes away, or the object is released. Returns this instance in the `watcher` parameter for usage within the callback. The handler callback is always called on the main thread as part of the UI visibility checks.
 @return an instance of this class which will begin the view watching.
 */
- (instancetype)initWithView:(UIView *)view
                   scheduler:(VASScheduler *)scheduler
           visibilityPercent:(NSInteger)targetPercent
            visibilityChange:(void(^)(VASVisibilityWatcher *watcher, BOOL visible))handler;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/// Stops the view from being watched. No more events will be sent and this watcher cannot be restarted.
- (void)stopWatching;

@end

NS_ASSUME_NONNULL_END
