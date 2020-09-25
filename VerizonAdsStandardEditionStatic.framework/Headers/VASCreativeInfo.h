///
/// @file
/// @brief Definitions for VASCreativeInfo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASCreativeInfo represents creative info.
 */
@interface VASCreativeInfo : NSObject <NSCopying>

/// The id of the creative.
@property (nonatomic, readonly, copy, nullable) NSString *creativeId;

/// The demand source for the creative.
@property (nonatomic, readonly, copy, nullable) NSString *demandSource;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Initialize with read-only properties.
 
 @param creativeId      The id of the creative.
 @param demandSource    The demand source for the creative.
 @return An initialized instance of this class.
 */
- (instancetype)initWithCreativeId:(nullable NSString *)creativeId
                      demandSource:(nullable NSString *)demandSource NS_DESIGNATED_INITIALIZER;

/**
 Perform a deep copy.
 
 @param zone Zone to use for the copy.
 @return An immutable copy of this class.
 */
- (id)copyWithZone:(nullable NSZone *)zone;

@end

NS_ASSUME_NONNULL_END
