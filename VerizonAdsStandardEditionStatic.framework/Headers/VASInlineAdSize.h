///
///  @file
///  @brief Definitions for VASInlineAdSize
///
///  Copyright © 2018 Verizon. All rights reserved.
///
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * Ad size properties.
 */
@interface VASInlineAdSize : NSObject<NSCopying>

/// The width of the ad.
@property (readonly) NSUInteger width;

/// The height of the ad.
@property (readonly) NSUInteger height;

/**
 Initialize the ad with a size.
 
 @param width    The width of the ad size.
 @param height   The height of the ad size.
 @return An initialized instance of this class.
 */
- (instancetype)initWithWidth:(NSUInteger)width height:(NSUInteger)height NS_DESIGNATED_INITIALIZER;

/**
 Perform a deep copy.
 
 @param zone Zone to use for the copy.
 @return An immutable copy of this class.
 */
- (id)copyWithZone:(nullable NSZone *)zone;

// NOTE: We don't want to expose this in docs until Android implements object equality.
/// @cond
/**
 Indicates whether one size is equal to another by comparing their dimensions.
 
 @param otherAdSize Other instance to test.
 @return `YES` if the size is equal to the other, `NO` otherwise.
 */
- (BOOL)isEqualToAdSize:(VASInlineAdSize *)otherAdSize;
/// @endcond

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
