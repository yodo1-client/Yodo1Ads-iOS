///
/// @file
/// @brief Definitions for VASContentFilter.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASAdContent.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol for ad content filtering.
 */
@protocol VASContentFilter <NSObject>
/**
 Indicate if the ad content can be handled.
 
 @param adContent ad content data
 @returns BOOL `YES` if the content can be handled `NO` otherwise.
 */
- (BOOL)accepts:(VASAdContent *)adContent;
@end

NS_ASSUME_NONNULL_END
