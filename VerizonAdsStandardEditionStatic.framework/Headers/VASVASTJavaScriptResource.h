///
/// @file
/// @internal
/// @brief Definition for the VASVASTJavaScriptResource.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTJavaScriptResource : NSObject

@property (nonatomic, readonly) NSString *apiFramework;
@property (nonatomic, readonly) BOOL browserOptional;
@property (nonatomic, readonly) NSString *uri;

- (instancetype)initWithApiFramework:(NSString *)apiFramework
                     browserOptional:(BOOL)browserOptional
                                 uri:(NSString *)uri;

@end

NS_ASSUME_NONNULL_END
