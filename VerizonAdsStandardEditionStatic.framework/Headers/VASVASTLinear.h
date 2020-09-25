///
/// @file
/// @internal
/// @brief Definition for the VASVASTLinear.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASVASTTracking.h"
#import "VASVASTMediaFile.h"
#import "VASVASTVideoClicks.h"
#import "VASVASTIcon.h"

NS_ASSUME_NONNULL_BEGIN

@interface VASVASTLinear : NSObject

@property (strong, readonly, nullable) NSString *skipoffset;
@property (assign) NSTimeInterval duration;
@property (strong, nullable) NSArray <VASVASTMediaFile *> *mediaFiles;
@property (strong, nullable) NSArray <VASVASTTracking *> *trackingEvents;
@property (strong, nullable) VASVASTVideoClicks* videoClicks;
@property (strong, nullable) NSArray <VASVASTIcon *> *icons;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithSkipoffset:(nullable NSString *)skipoffset NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
