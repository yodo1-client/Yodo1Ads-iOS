///
/// @file
/// @brief Definitions for VASRequestMetadataBuilder.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VASRequestMetadata.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASRequestMetadataBuilder uses the builder pattern to create instances of VASRequestMetadata.
 VASRequestMetadata is immutable once created but the builder can be used to create a copy and make changes.
 The builder can be initialized to be empty, or with an existing VASRequestMetadata instance, or with metadata maps.
 Note that the maps can be set directly and that there are some convenience setters that offer more direct access to some
 well known metadata properties. However, if both are provided (or inherited from the copy) the convenience setters will
 overwrite/replace any entries from the metadata maps when the instance builder method is invoked.
 <br/>
 Note that this builder does not support a "fluent" style interface (no chaining of setters) because they are awkward in
 Objective-C, but it is still useful to use the builder pattern here for several reasons. For example, it is useful when
 making a copy of VASRequestMetadata and only a couple properties need to change. It is also needed to employ the
 special overwrite logic we perform for the convenience setters before an instance is built by the builder.
 <br/>
 This class is not designed to be thread-safe. It is intended to be a lightweight helper for building instances of
 VASRequestMetadata (which is thread-safe and immutable). The normal use case is to use it as a helper and discard it.
 Do not share or reuse instances of VASRequestMetadataBuilder in a way that would cause concurrency problems.
 */
@interface VASRequestMetadataBuilder : NSObject

#pragma mark Metadata
/// Application Metadata (e.g., mediator).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id> *appData;

/// User Metadata (e.g., age, dob, gender).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id> *userData;

/// Placement Metadata (e.g. placementId, adSize).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id> *placementData;

/// Extra metadata (e.g., impression groups).
@property (nonatomic, nullable, copy) NSDictionary<NSString *, id<NSCopying>> *extras;

/// Supported orientations.
@property (nonatomic, nullable, copy) NSArray<NSString *> *supportedOrientations;

#pragma mark Convenience User Metadata Properties
/// User's age in years.
@property (nonatomic, readwrite, nullable, copy) NSNumber *userAge;
/// User's number of children.
@property (nonatomic, readwrite, nullable, copy) NSNumber *userChildren;
/// User's income level.
@property (nonatomic, readwrite, nullable, copy) NSNumber *userIncome;
/// User's education level.
@property (nonatomic, readwrite, nullable, copy) NSString *userEducation;
/// User's ethnicity.
@property (nonatomic, readwrite, nullable, copy) NSString *userEthnicity;
/// User's gender.
@property (nonatomic, readwrite, nullable, copy) NSString *userGender;
/// User's marital status.
@property (nonatomic, readwrite, nullable, copy) NSString *userMaritalStatus;
/// User's political affiliation.
@property (nonatomic, readwrite, nullable, copy) NSString *userPolitics;
/// User's date of birth.
@property (nonatomic, readwrite, nullable, copy) NSDate   *userDOB;
/// User's state.
@property (nonatomic, readwrite, nullable, copy) NSString *userState;
/// User's country.
@property (nonatomic, readwrite, nullable, copy) NSString *userCountry;
/// User's postal code.
@property (nonatomic, readwrite, nullable, copy) NSString *userPostalCode;
/// User's designated market area (DMA).
@property (nonatomic, readwrite, nullable, copy) NSString *userDMA;
/// User's additional keywords.
@property (nonatomic, readwrite, nullable, copy) NSArray<NSString *> *userKeywords;

#pragma mark Convenience App Metadata Properties
/// Mediator for the application. Mediator must include both the adapter name and version.
@property (nonatomic, readwrite, nullable, copy) NSString *mediator;

#pragma mark Convenience Placement Metadata Properties
/// Impression group ID for sites that are enabled to group traffic in this way.
@property (nonatomic, readwrite, nullable, copy) NSString *placementImpressionGroup;

#pragma mark Builder Initializers
/**
 Initialize an empty builder.
 
 @return An initialized instance of this class.
 */
- (instancetype)init;

/**
 Initialize a builder with an existing VASRequestMetadata. All metadata is copied into the builder.
 
 @param requestMetadata An existing request metadata to initialize the builder.
 @return An initialized instance of this class.
 */
- (instancetype)initWithRequestMetadata:(VASRequestMetadata *)requestMetadata;

/**
 Initialize a builder with existing metadata maps. All metadata is copied into the builder.
 
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
          supportedOrientations:(nullable NSArray<NSString *> *)supportedOrientations;

#pragma mark Build Method
/**
 Builds an immutable instance of VASRequestMetadata using the properties previously set on the builder.
 Note that any convenience setters will always overwrite any data that is set using the metadata maps.
 Convenience setters are tracked internally and then merged into their respective metadata maps and reset
 when an instance is built. This ensures that they always overwrite the main metadata maps.
 
 @return An immutable instance of VASRequestMetadata.
 */
- (VASRequestMetadata *)build;

@end

NS_ASSUME_NONNULL_END

