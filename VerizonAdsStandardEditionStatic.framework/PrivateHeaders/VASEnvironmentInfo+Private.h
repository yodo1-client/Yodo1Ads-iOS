///
/// @internal
/// @file VASEnvironmentInfo+Private.h
/// @brief Private definitions for VASCore VASEnvirontmentInfo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASEnvironmentInfo.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASEnvironmentInfo (Private)

/**
 Determines if the network is currently available and reachable.
 DO NOT use this to collect information that may be restricted (in anonymous mode).
 The main VASEnvironmentInfo class is better to use for that purpose.
 
 @return `YES` if the network is available and reachable, `NO` otherwise.
 */
+ (BOOL)isNetworkAvailable;

@end

NS_ASSUME_NONNULL_END

