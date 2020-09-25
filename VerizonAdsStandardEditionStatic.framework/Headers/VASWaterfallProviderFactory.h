///
/// @file
/// @brief Definitions for VASWaterfallProviderFactory.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASWaterfallProvider.h>

@interface VASWaterfallProviderFactory : NSObject

// Deprecated and unused. Now using VASComponentRegistry and createComponentForType.
+ (VASWaterfallProvider *)createInstanceForWaterfallProviderClassName:(NSString *)defaultWaterfallProviderClassName usingVASAds:(VASAds *)vasAds;

@end
