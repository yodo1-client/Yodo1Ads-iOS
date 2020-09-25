///
/// @file
/// @brief Definitions for VASSDKInfo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>


/**
 VASSDKInfo represents the basic SDK info.
 */
@interface VASSDKInfo : NSObject

/// SDK version.
@property (nonatomic, readonly, copy) NSString *version;

/// SDK build ID.
@property (nonatomic, readonly, copy) NSString *buildId;

/// SDK build hash.
@property (nonatomic, readonly, copy) NSString *buildHash;

/// SDK build type.
@property (nonatomic, readonly, copy) NSString *buildType;

/// SDK build time.
@property (nonatomic, readonly, copy) NSString *buildTime;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

