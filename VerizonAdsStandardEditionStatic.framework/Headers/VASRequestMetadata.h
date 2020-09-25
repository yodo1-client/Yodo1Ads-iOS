///
/// @file
/// @brief Definitions for VASRequestMetadata.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASRequestMetadata is the metadata that is included with an ad or bid request.
 Note that this class is an immutable container and its properties cannot be changed.
 To change metadata, simply create another instance with the new data, copying anything that hasn't changed.
 */
@interface VASRequestMetadata : NSObject <NSCopying>

/// Application metadata (e.g., mediator).
@property (readonly, copy, nullable) NSDictionary<NSString *, id> *appData;

/// User metadata (e.g., age, dob, gender).
@property (readonly, copy, nullable) NSDictionary<NSString *, id> *userData;

/// Placement metadata (e.g. placementId, adSize).
@property (readonly, copy, nullable) NSDictionary<NSString *, id> *placementData;

/// Extra metadata (e.g., impression groups).
@property (readonly, copy, nullable) NSDictionary<NSString *, id<NSCopying>> *extras;

/// Supported orientations.
@property (readonly, copy, nullable) NSArray<NSString *> *supportedOrientations;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Initialize with read-only properties. All properties are copied into immutable equivalents.
 
 @param appData                 Application metadata (e.g., mediator).
 @param userData                User metadata (e.g., age, dob, gender).
 @param placementData           Placement metadata (e.g. placementId, adSize).
 @param extras                  Extra metadata (e.g., impression groups).
 @param supportedOrientations   Supported orientations.
 @return An initialized instance of this class.
 */
- (instancetype)initWithAppData:(nullable NSDictionary<NSString *, id> *)appData
                       userData:(nullable NSDictionary<NSString *, id> *)userData
                  placementData:(nullable NSDictionary<NSString *, id> *)placementData
                         extras:(nullable NSDictionary<NSString *, id<NSCopying>> *)extras
          supportedOrientations:(nullable NSArray<NSString *> *)supportedOrientations NS_DESIGNATED_INITIALIZER;

/**
 Perform a deep copy.
 
 @param zone Zone to use for the copy.
 @return An immutable copy of this class.
 */
- (id)copyWithZone:(nullable NSZone *)zone;

/**
 Indicates whether the contents of the receiving `RequestMetadata` are equal to the contents of another given instance.
 
 @param otherRequestMetadata Other instance to test.
 @return `YES` if the contents of this instance is equal to the other, `NO` otherwise.
 */
- (BOOL)isEqualToRequestMetadata:(VASRequestMetadata *)otherRequestMetadata;

@end

NS_ASSUME_NONNULL_END

