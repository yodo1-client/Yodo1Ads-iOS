///
///  @file
///  @brief Definitions for VASDataStore.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASDataStore provides thread-safe data storage.
 */
@interface VASDataStore : NSObject

/// Count of entries at the root level.
@property (readonly) NSUInteger count;

/// Set of all keys at the root of the data store.
@property (readonly) NSSet<NSString *> *keys;

/**
 Remove the object with the specified key from the data store.
 
 @param key     The key of the data value being fetched. May not be nil.
 @returns       The data object that was being stored for the specified key, or nil if it did not exist.
 */
- (nullable id)removeObjectForKey:(NSString *)key;

/// Removes all of the key-values from the data store.
- (void)removeAll;

/**
 Provides the ability to determine if a specific setting exists in the data store.
 
 @param key     The key for the data store item. May not be nil.
 @returns       YES if the data exists, NO if it is not present.
 */
- (BOOL)containsKey:(NSString *)key;

/**
 Convenience accessor of a boolean for a specified key. If the data does not exist within the data store then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber boolValue of that object regardless of the original content number format.
 
 @param key             The key of the data value being fetched. May not be nil.
 @param defaultBoolean  The value to return if the specified item does not exist.
 @returns               The boolean for the specified key, or defaultBoolean if it is not present.
 */
- (BOOL)booleanForKey:(NSString *)key
          withDefault:(BOOL)defaultBoolean;

/**
 Convenience accessor of an integer for a specified key. If the data does not exist within the data store then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber integerValue of that object regardless of the original content number format.
 
 @param key             The key of the data value being fetched. May not be nil.
 @param defaultInteger  The value to return if the specified item does not exist.
 @returns               The integer for the specified key, or defaultInteger if it is not present.
 */
- (NSInteger)integerForKey:(NSString *)key
               withDefault:(NSInteger)defaultInteger;

/**
 Convenience accessor of a double for a specified key. If the data does not exist within the data store then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber doubleValue of that object regardless of the original content number format.
 
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultDouble  The value to return if the specified item does not exist.
 @returns              The double for the specified key, or defaultDouble if it is not present.
 */
- (double)doubleForKey:(NSString *)key
           withDefault:(double)defaultDouble;

/**
 Convenience accessor of string data for a specified key. If the data does not exist within the data store then the default parameter will be returned.
 
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultString  The value to return if the specified item does not exist.
 @returns              The string for the specified key, or defaultString if it is not present.
 */
- (nullable NSString *)stringForKey:(NSString *)key
                        withDefault:(nullable NSString *)defaultString;

/**
 Convenience accessor of array data for a specified key. If the data does not exist within the data store then the default parameter will be returned.
 
 @param key           The key of the data value being fetched. May not be nil.
 @param defaultArray  The value to return if the specified item does not exist.
 @returns             The array object for the specified key, or defaultArray if it is not present.
 */
- (nullable NSArray<id> *)arrayForKey:(NSString *)key
                          withDefault:(nullable NSArray *)defaultArray;

/**
 Convenience accessor of dictionary data for a specified key. If the data does not exist within the data store then the default parameter will be returned.
 
 @param key                The key of the data value being fetched. May not be nil.
 @param defaultDictionary  The value to return if the specified item does not exist.
 @returns                  The dictionary object for the specified key, or defaultDictionary if it is not present.
 */
- (nullable NSDictionary<NSString *, id> *)dictionaryForKey:(NSString *)key
                                                withDefault:(nullable NSDictionary<NSString *, id> *)defaultDictionary;

/**
 Generic accessor of data for a specified key. This method returns the raw object from the data store, including any mutable objects saved through setObject:forKey:, and should typically only be used for private data requiring complete considerations of thread-safety and mutability. Improper usage can easily result in data corruption and crashes. Using the other data accessors is preferred as they return immutable copies of objects.
 
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultObject  The value to return if the specified item does not exist.
 @returns              The data object for the specified key, or defaultObject if it is not present.
 */
- (nullable id)objectForKey:(NSString *)key
                withDefault:(nullable id)defaultObject;

/**
 This method is identical to objectForKey:withDefault: with the added check to ensure that the returned object is of the expected class, or returns defaultObject.
 
 @param key             The key of the data value being fetched. May not be nil.
 @param expectedClass   Verifies the returned object is of the expected class or returns nil.
 @param defaultObject   The value to return if the specified item does not exist or was not the expected type.
 @returns               The data object for the specified key, or defaultObject if it is not present or of the wrong expected class.
 */
- (nullable id)objectForKey:(NSString *)key
              expectedClass:(Class)expectedClass
                withDefault:(nullable id)defaultObject;

/**
 Convenience method to set a boolean within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param boolean     The boolean value to be saved in the data store.
 @param key         The key being set. May not be nil.
 @return            The previously stored NSNumber boolean value for `key` if it existed, or NO if didn't exist or was not an NSNumber. Use containsKey or objectForKey if more clarity is needed about an existing object.
 */
- (BOOL)setBoolean:(BOOL)boolean
            forKey:(NSString *)key;

/**
 Convenience method to set a double within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param dbl     The double value to be saved in the data store.
 @param key     The key being set. May not be nil.
 @return        The previously stored NSNumber double value for `key` if it existed, or 0.0 if didn't exist or was not an NSNumber. Use containsKey or objectForKey if more clarity is needed about an existing object.
*/
- (double)setDouble:(double)dbl
             forKey:(NSString *)key;

/**
 Convenience method to set an integer within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param integer     The integer value to be saved in the data store.
 @param key         The key being set. May not be nil.
 @return            The previously stored NSNumber integer value for `key` if it existed, or 0 if doesn't exist or was not an NSNumber. Use containsKey or objectForKey if more clarity is needed about an existing object.
 */
- (NSInteger)setInteger:(NSInteger)integer
                 forKey:(NSString *)key;

/**
 Convenience method to set a string within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param string  The NSString to be saved in the data store. May be nil to remove an existing object.  The `copy` function will be executed on the string to insure an immutable copy is saved.
 @param key     The key being set. May not be nil.
 @return        The previously stored NSString value for `key` if it existed, or nil if it didn't exist or was not an NSString. Use containsKey or objectForKey if more clarity is needed about an existing object.
 */
- (nullable NSString *)setString:(nullable NSString *)string
                          forKey:(NSString *)key;

/**
 Convenience method to set an array within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param array   The NSArray to be saved in the data store. May be nil to remove an existing object. The `copy` function will be executed on the array to insure an immutable copy is saved.
 @param key     The key being set. May not be nil.
 @return        The previously stored NSArray value for `key` if it existed, or nil if it didn't exist or was not an NSArray.  Use containsKey or objectForKey if more clarity is needed about an existing object.
 */
- (nullable NSArray *)setArray:(nullable NSArray *)array
                        forKey:(NSString *)key;

/**
 Convenience method to set a dictionary within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param dictionary  The NSDictionary to be saved in the data store. May be nil to remove an existing object.  The `copy` function will be executed on the dictionary to insure an immutable copy is saved.
 @param key         The key being set. May not be nil.
 @return            The previously stored NSDictionary value for `key` if it existed, or nil if it didn't exist or was not an NSDictionary. Use containsKey or objectForKey if more clarity is needed about an existing object.
 */
- (nullable NSDictionary *)setDictionary:(nullable NSDictionary *)dictionary
                                  forKey:(NSString *)key;

/**
 Used to set an object within the existing storage. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param object      Represents any data object, but it is recommended to only use this method for private objects and that the object be immutable, otherwise it is incumbent upon the object owner and consumers to use that object properly when dealing with mutability and thread safety to avoid data corruption of the VASDataStore object and potential crashes.
 
 Calling this method with a nil object is a convenience that simply calls removeObjectForKey:. If any removal logic is required by a subclass, it can be consolidated within the remove call.
 
 @param key         The key being set. May not be nil.
 @returns           The previous value stored in the location `key` being replaced by `object`, or nil if it didn't exist previously.
 */
- (nullable id)setObject:(nullable id)object
                  forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
