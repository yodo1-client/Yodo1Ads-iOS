///
/// @file
/// @internal
/// @brief Definition for the VASVASTVideoClicks.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTClicks.h"
#import "VASVASTUrlWithId.h"

@interface VASVASTVideoClicks : VASVASTClicks

@property (copy) NSString *identifier;
@property (strong) NSArray<VASVASTUrlWithId *> *customClick;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithIdentifier:(NSString *)identifier
                     clickThrough:(VASVASTUrlWithId *)clickThrough
                    clickTracking:(NSArray<VASVASTUrlWithId *> *)clickTracking
                      customClick:(NSArray<VASVASTUrlWithId *> *)customClick;

@end
