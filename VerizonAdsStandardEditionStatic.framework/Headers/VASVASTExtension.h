///
/// @file
/// @internal
/// @brief Definition for the VASVASTExtension.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

@interface VASVASTExtension : NSObject

@property (copy, readonly) NSString *content;
@property (copy, readonly) NSString *type;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithContent:(NSString *)content
                           type:(NSString *)type NS_DESIGNATED_INITIALIZER;

@end
