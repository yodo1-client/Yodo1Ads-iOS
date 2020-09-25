///
/// @internal
/// @file
/// @brief Definitions for VASBrowserViewController.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsSupport.h>

NS_ASSUME_NONNULL_BEGIN

@class VASBrowserViewController;

@protocol VASBrowserViewControllerDelegate <NSObject>
@required
- (void)browserDidClose:(VASBrowserViewController *)browser;
- (void)adDidLeaveApplication;
@end

@interface VASBrowserViewController : VASForceOrientationViewController <WKNavigationDelegate>

- (instancetype)initWithOrientationProperties:(nullable VASForceOrientationProperties *)orientationProperties delegate:(id<VASBrowserViewControllerDelegate>)delegate;

/**
 The URL to be loaded by the web view.
 If this is set when the view appears, it will automatically be loaded.
 You can also set `URL` after the view has loaded and manually call `load`.
 */
@property (nonatomic, nullable) NSURL *URL;

/**
 The class that presented this browser instance.
 We must handle viewable state for this web component when the browser is presented and dismissed. This browser also inherits its orientation properties from the `presentingWebComponent`.
 */
@property (nonatomic, weak, nullable) id<VASBrowserViewControllerDelegate> delegate;

/**
 Specifies whether the ad should show or hide the status bar for a more complete full screen experience. Must be read/set on the main thread.
 */
@property (nonatomic, getter=isImmersiveEnabled) BOOL immersiveEnabled;

/**
 Loads the `URL` in the web view.
 Called automatically when the view appears if a `URL` exists,
 */
- (void)load;

/**
 Call to close a presented instance of this class.
 */
- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
