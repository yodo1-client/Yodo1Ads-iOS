///
/// @internal
/// @file
/// @brief Definitions for VASMRAIDWebView+Private.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASMRAIDWebView.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kVASMRAIDEnvVersionKey;
extern NSString * const kVASMRAIDEnvVersion;
extern NSString * const kVASMRAIDEnvSDKVersionKey;
extern NSString * const kVASMRAIDEnvSDKNameKey;
extern NSString * const kVASMRAIDEnvSDKName;
extern NSString * const kVASMRAIDEnvAppIDKey;
extern NSString * const kVASMRAIDEnvIDForAdvertisersKey;
extern NSString * const kVASMRAIDEnvLimitAdTrackingKey;
extern NSString * const kVASMRAIDEnvCoppaKey;

extern NSString * const kVASMRAIDOrientationKey;
extern NSString * const kVASMRAIDOrientationLockedKey;

@interface VASMRAIDWebView (Private)

CGRect VASScreenBounds(void);
UIInterfaceOrientation VASInterfaceOrientation(void);
CGRect VASScreenBoundsForOrientation(UIInterfaceOrientation orientation);
CGRect VASXYWidthHeightRectSwap(CGRect rect);

@end

NS_ASSUME_NONNULL_END
