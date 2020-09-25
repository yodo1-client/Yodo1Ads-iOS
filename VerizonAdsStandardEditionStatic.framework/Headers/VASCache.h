///
/// @file
/// @brief Definitions for VASCache.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

/**
 Implementations of a cache must conform to these protocols.
 */

/// Cache trimStrategy definition.
typedef NSInteger VASCacheTrimStrategy;

/**
 Protocol for interacting with an VASCache.
 */
@protocol VASCache <NSObject>

/**
 Add an item to the cache.
 
 @param item The object to add to the cache.
 */
- (void)add:(id)item;

/**
 Remove an item from the cache and return it to the caller.
 
 @return An object if the cache is not empty; otherwise null.
 */
- (id)remove;

/**
 Reduce the number of entries in the cache if the number of entries is greater than the maximum size.
 
 @param trimStrategy Remove extra entries from the cache, as specified by VASCacheTrimStrategy.
 @param maxSize The maximum number of entries in the cache. Specify 0 to clear the cache. If maxSize is greater than the current cache size, no entries are removed.
 */
- (void)trimUsingStrategy:(VASCacheTrimStrategy)trimStrategy maxSize:(NSUInteger)maxSize;

/**
 Returns the number of items in the cache.
 
 @return the number of items in the cache.
 */
@property (readonly) NSUInteger size;

@end


