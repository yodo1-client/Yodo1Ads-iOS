///
/// @file
/// @brief Definitions for VASErrorInfo.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

/// The user info key for the `who` property.
FOUNDATION_EXPORT NSErrorUserInfoKey const VASErrorInfoWhoKey;

/**
 VASErrorInfo contains info about errors.
 */
@interface VASErrorInfo : NSError

/// Indicates the source of the error.
@property (readonly, copy) NSString *who;

/**
 Get an error instance using the most commonly used fields. Note that you can also use the underlying `errorWithDomain` implemented by `NSError` but you must create the `userInfo` and add the key/value pairs for these common fields.
 
 @param domain      The error domain. This can be one of the predefined `NSError` domains, or an arbitrary string describing a custom domain. This parameter must not be `nil`.
 @param code        The error code for the error.
 @param who         Who caused or generated the error. This parameter may be `nil`.
 @param description A brief description of the error. This parameter may be `nil`.
 @param underlying  An underlying error that is the cause of the error. This parameter may be `nil`.
 @return An initialized instance of this class.
 */
+ (instancetype)errorWithDomain:(NSErrorDomain)domain
                           code:(NSInteger)code
                            who:(NSString *)who
                    description:(NSString *)description
                     underlying:(NSError *)underlying;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

