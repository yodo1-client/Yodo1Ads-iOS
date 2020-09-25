///
/// @file
/// @internal
/// @brief Definition for the VASVASTBackground.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTStaticResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTBackground : NSObject

@property (assign) BOOL hideButtons;
@property (strong, nullable) VASVASTStaticResource *staticResource;
@property (copy, nullable) NSURL *webResource;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithHideButtons:(BOOL)hideButtons NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
