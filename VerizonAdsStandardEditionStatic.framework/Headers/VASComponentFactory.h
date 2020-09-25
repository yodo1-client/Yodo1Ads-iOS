///
/// @internal
/// @file
/// @brief Definitions for VASComponentFactory
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASAds;

@protocol VASComponentFactory <NSObject>

/**
 Create a component based on the component info (native JSON).
 
 May be called on background threads.
 
 @param componentInfo   The JSON data used to construct a new component of the class that implements this protocol.
 @param args            An optional dictionary of arguments that can be customized for each class implementing this protocol. See specific components for guidance on the arguments needed.
 @param vasAds          The VASAds instance being used.
 @return The VASComponent of the class implementing the protocol, or nil if it cannot be created with the data passed.
 */
- (nullable id<VASComponent>)newInstanceFromComponentInfo:(NSDictionary<NSString *, id> *)componentInfo
                                                     args:(nullable NSDictionary<NSString *, id> *)args
                                                   VASAds:(VASAds *)vasAds;

@end

NS_ASSUME_NONNULL_END
