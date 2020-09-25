///
/// @file
/// @brief Definitions for VASVerizonNativeController.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASVerizonNativeAd.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import <VerizonAdsStandardEditionStatic/VASVerizonNativeComponentBundle.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VAS Verizon Native Controller.
 */
@interface VASVerizonNativeController : NSObject

/// The VASVerizonNativeAd created once prepareWithAdContent is successfully executed, nil otherwise.
@property (readonly, nullable) VASVerizonNativeAd *verizonNativeAd;

/**
 Initialize the object specifying the delegate and VASAds instance to use.
 
 @param delegate The VASVerizonNativeComponentDelegate.
 @param vasAds The VASAds instance for this object to use.
 @return An initialized instance of the class.
 */
- (instancetype)initWithDelegate:(id<VASVerizonNativeComponentDelegate>)delegate
                          VASAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;

/**
 This method should return true if the adContent provided is a valid Verizon Native format.
 
 @param adContent The VASAdContent object
 @return true if the format is a valid Verizon format; false otherwise.
 */
+ (BOOL)accepts:(VASAdContent *)adContent;

/**
 Set the ad content and prepare it for processing.
 
 @param adContent   A VASAdContent object specifying the ad content.
 @param adSession   The VASAdSession object representing this ad.
 @return nil if successful; otherwise a VASErrorInfo object describing the error.
 */
- (nullable VASErrorInfo *)prepareWithAdContent:(VASAdContent *)adContent
                                 usingAdSession:(VASAdSession *)adSession;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
