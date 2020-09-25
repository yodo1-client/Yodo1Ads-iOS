///
/// @file
/// @brief Definitions for VASBid.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASWaterfallProvider.h"

NS_ASSUME_NONNULL_BEGIN

/**
 Base class for all Super Auction bids.
 */
@interface VASBid : NSObject

/// A general purpose value associated with the bid.
@property (readonly) NSString *value;

/// The VASAdSession associated with this bid.
@property (readonly) VASAdSession *adSession;

/**
 Initialize a new Bid object.
 
 @param adSession   The VASAdSession associated with this bid.
 @param value       A general purpose value associated with the bid.
 @return an initialized instance of this class.
 */
- (instancetype)initWithAdSession:(VASAdSession *)adSession
                            value:(NSString *)value NS_REQUIRES_SUPER NS_DESIGNATED_INITIALIZER;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
