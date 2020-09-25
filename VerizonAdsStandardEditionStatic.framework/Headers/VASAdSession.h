///
///  @file
///  @brief Definitions for VASAdSession.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASDataStore.h>

NS_ASSUME_NONNULL_BEGIN

@protocol VASAdAdapter;

/**
 A subclass of VASDataStore representing the ad session data throughout the ad lifecycle.
 */
@interface VASAdSession : VASDataStore

/// Time that the ad session was created.
@property (readonly) NSTimeInterval creationTime;

/// The unique identifier of this session.
@property (readonly) NSString *sessionId;

/// Ad adapter used for this session.
@property (readonly) id<VASAdAdapter> adAdapter;

/// Special version of `description` that formats the ad session, with contents. Use the standard `description` for the ad session without contents.
@property (readonly) NSString *longDescription;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
