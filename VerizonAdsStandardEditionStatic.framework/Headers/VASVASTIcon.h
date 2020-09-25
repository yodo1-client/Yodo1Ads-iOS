///
/// @file
/// @internal
/// @brief Definition for the VASVASTIcon.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "VASVASTStaticResource.h"
#import "VASVASTUrlWithId.h"
#import "VASVASTClicks.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTIcon : NSObject

@property (copy, readonly) NSString *program;
@property (assign, readonly) CGSize size;
@property (copy, readonly) NSString *xPosition;
@property (copy, readonly) NSString *yPosition;
@property (assign, readonly) NSTimeInterval offset;
@property (assign, readonly) NSTimeInterval duration;
@property (copy, readonly, nullable) NSString *apiFramework;

@property (strong, nullable) VASVASTStaticResource *staticResource;

@property (strong, nullable) VASVASTClicks *iconClicks;
@property (strong, nullable) NSArray<NSURL *> *viewTrackingURLs;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithAttributesProgram:(NSString *)program
                                     size:(CGSize)size
                                xPosition:(nullable NSString *)xPosition
                                yPosition:(nullable NSString *)yPosition
                                   offset:(NSTimeInterval)offset
                                 duration:(NSTimeInterval)duration
                             apiFramework:(nullable NSString *)apiFramework NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
