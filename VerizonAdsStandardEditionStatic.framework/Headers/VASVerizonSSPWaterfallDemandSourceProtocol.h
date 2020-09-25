///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallDemandSourceProtocol.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

@protocol VASVerizonSSPWaterfallDemandSourceProtocol <NSObject>
@required
@property (nullable, readonly, copy) NSString *price;
@property (nullable, readonly, copy) NSString *buyer;
@end
