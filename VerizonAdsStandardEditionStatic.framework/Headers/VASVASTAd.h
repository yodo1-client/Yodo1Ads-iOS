///
/// @file
/// @internal
/// @brief Definition for the VASVASTAd.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTAdSystem.h"
#import "VASVASTCreative.h"
#import "VASVASTExtension.h"

@class VASVASTExtensionAdVerifications;

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTAd : NSObject

@property (copy, readonly, nullable) NSString *identifier;
@property (assign, readonly) NSUInteger sequence;

@property (strong, nullable) VASVASTAdSystem *adSystem;
@property (strong, nullable) NSArray<VASVASTUrlWithId *> *impressions;
@property (strong) NSArray<VASVASTCreative *> *creatives;
@property (copy, nullable) NSURL *errorURL;
@property (strong, nullable) NSArray<VASVASTExtension *> *extensions;
@property (readonly, nullable) VASVASTExtensionAdVerifications *adVerifications;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithIdentifier:(nullable NSString *)identifier
                          sequence:(NSUInteger)sequence NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
