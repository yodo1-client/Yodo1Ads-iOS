///
/// @file
/// @internal
/// @brief Definition for the VASVASTCompanion.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "VASVASTTracking.h"
#import "VASVASTStaticResource.h"
#import "VASVASTClicks.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTCompanion : NSObject

@property (copy, nullable) NSString *identifier;
@property (assign) CGSize size;
@property (assign) CGSize assetSize;
@property (strong, nullable) VASVASTStaticResource *staticResource;
@property (copy, nullable) NSURL *iframeResource;
@property (copy, nullable) NSURL *htmlResource;
@property (strong, nullable) VASVASTClicks *companionClick;
@property (strong, nullable) NSArray <VASVASTTracking *> *trackingEvents;
@property (assign) BOOL hideButtons;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithIdentifier:(nullable NSString *)identifier
                              size:(CGSize)size
                         assetSize:(CGSize)assetSize
                       hideButtons:(BOOL)hideButtons NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
