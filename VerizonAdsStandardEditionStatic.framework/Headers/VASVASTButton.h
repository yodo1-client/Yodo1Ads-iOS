///
/// @file
/// @internal
/// @brief Definition for the VASVASTButton.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTStaticResource.h"
#import "VASVASTClicks.h"

@interface VASVASTButton : NSObject

@property (copy, readonly) NSString *name;
@property (assign, readonly) NSTimeInterval offset;
@property (assign, readonly) NSUInteger position;
@property (strong) VASVASTStaticResource *staticResource;
@property (strong) VASVASTClicks *buttonClicks;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

-(instancetype)initWithName:(NSString *)name
                     offset:(NSTimeInterval)offset
                   position:(NSUInteger)position NS_DESIGNATED_INITIALIZER;

@end
