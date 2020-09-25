///
/// @file
/// @internal
/// @brief Definition for the VASVASTTracking.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTTracking : NSObject

@property (copy, readonly) NSString *event;
@property (copy, nullable) NSString *offset;
@property (copy, readonly) NSURL *url;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithEvent:(NSString *)event
                      offset:(nullable NSString *)offset
                         url:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
