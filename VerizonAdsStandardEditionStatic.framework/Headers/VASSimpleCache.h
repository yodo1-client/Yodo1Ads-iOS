///
/// @file
/// @brief Definitions for VASSimpleCache.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import <VerizonAdsStandardEditionStatic/VerizonAdsCore.h>
#import "VASCache.h"

/**
 Trim strategy for removing extra entries from the front or back of the cache.
 */
typedef NS_ENUM(VASCacheTrimStrategy, VASSimpleCacheTrimStrategy) {
    /// Remove oldest items from the cache.
    VASSimpleCacheTrimStrategyTrimFromFront = 1,
    /// Remove newest items from the cache.
    VASSimpleCacheTrimStrategyTrimFromBack,
};

/**
 A simple cache that implements a FIFO queue.
 Thread safety is acheived by executing all internal operations synchronously on a serial queue.
 */
@interface VASSimpleCache : NSObject <VASCache>

/**
 Add an item to the end of the cache.
 
 @param item The object to add to the cache.
 */
- (void)add:(id)item;

/**
 Remove the next available item from the beginning of the cache and return it to the caller.
 
 @return An object if the cache is not empty; otherwise null.
 */
- (id)remove;

/**
 Reduce the number of entries in the cache if the number of entries is greater than the maximum size.
 
 @param trimStrategy Remove extra entries from the front or the back, as specified by VASSimpleCacheTrimStrategy.
 @param maxSize The maximum number of entries in the cache. Specify 0 to clear the cache. If maxSize is greater than or equal to the current cache size, no entries are removed.
 */
- (void)trimUsingStrategy:(VASSimpleCacheTrimStrategy)trimStrategy maxSize:(NSUInteger)maxSize;

/**
 Returns the number of items in the cache
 */
@property (readonly) NSUInteger size;

@end
