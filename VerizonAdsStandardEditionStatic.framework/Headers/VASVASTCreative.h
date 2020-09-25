///
/// @file
/// @internal
/// @brief Definition for the VASVASTCreative.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTLinear.h"
#import "VASVASTTracking.h"
#import "VASVASTCompanion.h"
#import "VASVASTExtension.h"

@interface VASVASTCreative : NSObject

@property (copy, readonly) NSString *identifier;
@property (copy, readonly) NSString *adIdentifier;
@property (assign, readonly) NSUInteger sequence;
@property (copy, readonly) NSString *apiFramework;

@property (strong) VASVASTLinear *linear;
@property (strong) NSArray<VASVASTCompanion *> *companionAds;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithIdentifier:(NSString *)identifier
                      adIdentifier:(NSString *)adIdentifier
                          sequence:(NSUInteger)sequence
                      apiFramework:(NSString *)apiFramework NS_DESIGNATED_INITIALIZER;

@end
