///
/// @file
/// @internal
/// @brief Definition for the VASVASTUrlWithId.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTUrlWithId : NSObject

@property (copy, readonly, nullable) NSString *identifier;
@property (copy, readonly) NSURL *url;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithIdentifier:(nullable NSString *)identifier
                              url:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
