///
/// @file
/// @internal
/// @brief Definition for the VASVASTMediaFile.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "VASVASTUrlWithId.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTMediaFile : NSObject

@property (copy, readonly, nullable) NSString *identifier;
@property (copy, readonly) NSString *delivery;
@property (copy, readonly) NSString *type;
@property (assign, readonly) NSUInteger bitrate;
@property (assign, readonly) CGSize size;
@property (assign, readonly) BOOL scalable;
@property (assign, readonly) BOOL maintainAspectRatio;
@property (copy, readonly, nullable) NSString *apiFramework;
@property (copy, readonly) NSURL *url;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithId:(nullable NSString *)identifier
                  delivery:(NSString *)delivery
                      type:(NSString *)type
                   bitrate:(NSUInteger)bitrate
                      size:(CGSize)size
                  scalable:(BOOL)scalable
       maintainAspectRatio:(BOOL)maintainAspectRatio
              apiFramework:(nullable NSString *)apiFramework
                       url:(NSURL *)url NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
