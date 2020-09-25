///
/// @file
/// @internal
/// @brief Definition for the VASVASTClicks.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTUrlWithId.h"

@interface VASVASTClicks : NSObject

@property (strong) VASVASTUrlWithId *clickThrough;
@property (strong) NSArray<VASVASTUrlWithId *> *clickTracking;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithClickThrough:(VASVASTUrlWithId *)clickThrough
                      clickTracking:(NSArray<VASVASTUrlWithId *> *)clickTracking NS_DESIGNATED_INITIALIZER;

@end
