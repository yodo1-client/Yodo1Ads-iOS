///
/// @file
/// @internal
/// @brief Definition for the VASVASTStaticResource.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTStaticResource : NSObject

@property (copy) NSURL *url;
@property (copy, nullable) NSString *creativeType;
@property (strong, nullable) UIColor *backgroundColor;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithCreativeType:(nullable NSString *)creativeType
                     backgroundColor:(nullable UIColor *)backgroundColor
                                 url:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
