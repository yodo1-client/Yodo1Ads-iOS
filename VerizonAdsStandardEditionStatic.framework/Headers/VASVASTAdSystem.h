///
/// @file
/// @internal
/// @brief Definition for the VASVASTAdSystem.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTAdSystem : NSObject

@property (copy, readonly) NSString *name;
@property (copy, readonly) NSString *version;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithName:(NSString *)name
                     version:(NSString *)version NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
