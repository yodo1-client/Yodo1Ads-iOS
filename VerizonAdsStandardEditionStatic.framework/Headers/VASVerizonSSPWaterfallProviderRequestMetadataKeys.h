///
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallProviderRequestMetadataKeys.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// Keys used in VASRequestMetadata userData dictionary

#pragma mark - User Data Keys

/// Key for age.
extern NSString * const kVASUserAgeKey;

/// Key for number of children.
extern NSString * const kVASUserChildrenKey;

/// Key for user's country.
extern NSString * const kVASUserCountryKey;

/// Key for dma.
extern NSString * const kVASUserDMAKey;

/// Key for date of birth.
extern NSString * const kVASUserDOBKey;

/// Key for income.
extern NSString * const kVASUserIncomeKey;

/// Key for education.
extern NSString * const kVASUserEducationKey;

/// Key for ethnicity.
extern NSString * const kVASUserEthnicityKey;

/// Key for gender.
extern NSString * const kVASUserGenderKey;

/// Key for marital status.
extern NSString * const kVASUserMaritalKey;

/// Key for political affiliation.
extern NSString * const kVASUserPoliticsKey;

/// Key for user's state.
extern NSString * const kVASUserStateKey;

/// Key for user's zip code.
extern NSString * const kVASUserZipCodeKey;

/// Key for user keywords.
extern NSString * const kVASUserKeywordsKey;


#pragma mark - Placement Data Keys

/// Key for placement id.
extern NSString * const kVASRequestInfoPlacementIdKey;

/// Key for placement refresh rate.
extern NSString * const kVASRequestInfoPlacementRefreshKey;

/// Key for native types supported, value is an array (e.g., @[@"100", @"101"]).
extern NSString * const kVASRequestInfoNativeTypesKey;   // NSArray<NSString *>

/// Key for placement type.
extern NSString * const kVASRequestInfoPlacementTypeKey;
/// Placement type value for Inline placement.
extern NSString * const kVASPlacementTypeInline;
/// Placement type value for Interstitial placement.
extern NSString * const kVASPlacementTypeInterstitial;
/// Placement type value for Native placement.
extern NSString * const kVASPlacementTypeNative;

/// Key for array of dictionaries of ad sizes being requested.
extern NSString * const kVASRequestInfoInlineAdPlacementAdSizesKey;
/// Key for ad size width.
extern NSString * const kVASInlineAdPlacementAdSizeWidthKey;
/// Key for ad size height.
extern NSString * const kVASInlineAdPlacementAdSizeHeightKey;

#pragma mark - Extras Keys

/// Key for test bidder ID.
extern NSString * const kVASBidderKey;

/// Key for test creative ID.
extern NSString * const kVASCreativeIdKey;

/// Key for placement impression group.
extern NSString * const kVASRequestInfoImpressionGroupKey;

/// Key for GPDR consent data.
extern NSString * const kVASRequestInfoConsentDataKey;

NS_ASSUME_NONNULL_END
