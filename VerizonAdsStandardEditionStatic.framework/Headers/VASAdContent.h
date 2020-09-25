///
/// @file
/// @brief Definitions for VASAdContent.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASAdContent represents content and metadata that is returned from the waterfall provider.
 Note that this class is an immutable container that cannot be changed once created.
 */
@interface VASAdContent : NSObject <NSCopying>

/// Ad content.
@property (readonly, copy) NSString *content;

/// Ad response metadata.
@property (readonly, copy, nullable) NSDictionary<NSString *, id<NSCopying>> *metadata;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Initialize with read-only properties. All properties are copied into immutable equivalents.
 
 @param content     Ad content.
 @param metadata    Ad response metadata.
 @return An initialized instance of this class.
 */
- (instancetype)initWithContent:(NSString *)content
                       metadata:(nullable NSDictionary<NSString *, id<NSCopying>> *)metadata NS_DESIGNATED_INITIALIZER;

/**
 Perform a deep copy.
 
 @param zone Zone to use for the copy.
 @return An immutable copy of this class.
 */
- (id)copyWithZone:(nullable NSZone *)zone;

/**
 Indicates whether the contents of the receiving instance are equal to the contents of another given instance.
 
 @param otherAdContent Other instance to test.
 @return `YES` if the contents of this instance is equal to the other, `NO` otherwise.
 */
- (BOOL)isEqualToAdContent:(VASAdContent *)otherAdContent;

@end

NS_ASSUME_NONNULL_END

