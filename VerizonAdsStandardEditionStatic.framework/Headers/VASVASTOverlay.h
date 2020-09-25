///
/// @file
/// @internal
/// @brief Definition for the VASVASTOverlay.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTOverlay : NSObject

@property (copy) NSURL *url;
@property (assign) BOOL hideButtons;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithUrl:(NSURL *)url hideButtons:(BOOL)hideButtons;

@end

NS_ASSUME_NONNULL_END
