///
/// @file
/// @brief Definitions for VASCore VASConfiguration.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


#pragma mark - VASConfigurationChangeEvent

/**
 Object passed for VASEvents data when the Configuration class changes.
 */
@interface VASConfigurationChangeEvent : NSObject

/**
 The domain of the configuration item that changed.
 */
@property (readonly) NSString *domain;

/**
 The key of the configuration item that changed.
 */
@property (readonly) NSString *key;

/**
 The new value for the configuration item. Will be nil if the configuration item was removed.
 */
@property (readonly, nullable) id value;
@end


#pragma mark - VASConfiguration

/**
 Class for managing configuration settings shared amongst all components.
 
 All properties and methods are thread-safe for both reading and writing.
 */
@interface VASConfiguration : NSObject

/**
 A unique identifier of this object used for sending event notifications whenever data is updated. Subscribe a receiver using the VASEvents class with this identifier as the "topic" parameter. The event notifications will include in the data object an VASConfigurationChangeEvent object. Use of the VASEventMatcher matcher option targeting specific domain(s) and/or keys of interest by comparing the passed data object would be a natural filtering mechanism of events.
 */
@property (readonly) NSString *changesEventIdentifier;

/**
 Marks the specified domain as write-protected where data additions, updates, or removals must be done with the provided security key. Only one security key may be assigned to a domain. If a duplicate domain protection request occurs with a different security key, it will be ignored and NO returned.
 
 @param domain       The domain namespace being protected. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data. May not be nil.
 @return             YES if the domain was set as protected; NO if it was not.
 */
- (BOOL)protectDomain:(NSString *)domain withSecurityKey:(NSString *)securityKey;

/**
 Indicates whether a domain has been protected from writing by a security key.
 
 @param domain  The domain namespace being queried. May not be nil.
 @return        YES if the domain is protected by a security key and readonly, NO indicates writable.
 */
- (BOOL)isProtectedDomain:(NSString *)domain;

/**
 Provides the ability to determine if a specific setting exists in the configuration.
 
 @param domain  The configuration domain namespace. May not be nil.
 @param key     The key for the configuration item. May not be nil.
 @returns       YES if the data exists, NO if it is not present.
 */
- (BOOL)existsForDomain:(NSString *)domain key:(NSString *)key;

/**
 Generic accessor of data for a specified key within the specified domain.
 
 @param domain         The configuration domain namespace. May not be nil.
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultObject  The value to return if the specified item does not exist.
 @returns              The data object for the domain/key pair, or defaultObject if it is not present.
 */
- (nullable id)objectForDomain:(NSString *)domain
                           key:(NSString *)key
                   withDefault:(nullable id)defaultObject;

/**
 Convenience accessor of array data for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned.
 
 @param domain        The configuration domain namespace. May not be nil.
 @param key           The key of the data value being fetched. May not be nil.
 @param defaultArray  The value to return if the specified item does not exist.
 @returns             The array object for the domain/key pair, or defaultArray if it is not present.
 */
- (nullable NSArray<id> *)arrayForDomain:(NSString *)domain
                                     key:(NSString *)key
                             withDefault:(nullable NSArray *)defaultArray;

/**
 Convenience accessor of dictionary data for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned.
 
 @param domain             The configuration domain namespace. May not be nil.
 @param key                The key of the data value being fetched. May not be nil.
 @param defaultDictionary  The value to return if the specified item does not exist.
 @returns                  The dictionary object for the domain/key pair, or defaultDictionary if it is not present.
 */
- (nullable NSDictionary<NSString *, id> *)dictionaryForDomain:(NSString *)domain
                                                           key:(NSString *)key
                                                   withDefault:(nullable NSDictionary<NSString *, id> *)defaultDictionary;

/**
 Convenience accessor of string data for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned.
 
 @param domain         The configuration domain namespace. May not be nil.
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultString  The value to return if the specified item does not exist.
 @returns              The string for the domain/key pair, or defaultString if it is not present.
 */
- (nullable NSString *)stringForDomain:(NSString *)domain
                                   key:(NSString *)key
                           withDefault:(nullable NSString *)defaultString;

/**
 Convenience accessor of an integer for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber integerValue of that object regardless of the original content nubmer format.
 
 @param domain          The configuration domain namespace. May not be nil.
 @param key             The key of the data value being fetched. May not be nil.
 @param defaultInteger  The value to return if the specified item does not exist.
 @returns               The integer for the domain/key pair, or defaultInteger if it is not present.
 */
- (NSInteger)integerForDomain:(NSString *)domain
                          key:(NSString *)key
                  withDefault:(NSInteger)defaultInteger;

/**
 Convenience accessor of a double for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber doubleValue of that object regardless of the original content nubmer format.
 
 @param domain         The configuration domain namespace. May not be nil.
 @param key            The key of the data value being fetched. May not be nil.
 @param defaultDouble  The value to return if the specified item does not exist.
 @returns              The double for the domain/key pair, or defaultDouble if it is not present.
 */
- (double)doubleForDomain:(NSString *)domain
                      key:(NSString *)key
              withDefault:(double)defaultDouble;

/**
 Convenience accessor of a boolean for a specified key within the specified domain. If the data does not exist within the configuration then the default parameter will be returned. The data is stored as an NSNumber and this method will return the NSNumber boolValue of that object regardless of the original content nubmer format.
 
 @param domain          The configuration domain namespace. May not be nil.
 @param key             The key of the data value being fetched. May not be nil.
 @param defaultBoolean  The value to return if the specified item does not exist.
 @returns               The boolean for the domain/key pair, or defaultBoolean if it is not present.
 */
- (BOOL)booleanForDomain:(NSString *)domain
                     key:(NSString *)key
             withDefault:(BOOL)defaultBoolean;

/**
 Convenience method to set a boolean within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param boolean      The boolean value to be saved in the configuration.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setBoolean:(BOOL)boolean
         forDomain:(NSString *)domain
               key:(NSString *)key
          security:(nullable NSString *)securityKey;

/**
 Convenience method to set a double within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param dbl          The double value to be saved in the configuration.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setDouble:(double)dbl
        forDomain:(NSString *)domain
              key:(NSString *)key
         security:(nullable NSString *)securityKey;

/**
 Convenience method to set an integer within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered. Note that this method may not be used to remove an existing value due to the use of primitives for the value, use setObject: instead.
 
 @param integer      The integer value to be saved in the configuration.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setInteger:(NSInteger)integer
         forDomain:(NSString *)domain
               key:(NSString *)key
          security:(nullable NSString *)securityKey;

/**
 Convenience method to set a string within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param string       The NSString to be saved in the configuration. May be nil to remove an existing object.  The `copy` function will be executed on the string to insure an immutable copy is saved.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setString:(nullable NSString *)string
        forDomain:(NSString *)domain
              key:(NSString *)key
         security:(nullable NSString *)securityKey;

/**
 Convenience method to set an array within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param array        The NSArray to be saved in the configuration. May be nil to remove an existing object.  The `copy` function will be executed on the array to insure an immutable copy is saved.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setArray:(nullable NSArray *)array
       forDomain:(NSString *)domain
             key:(NSString *)key
        security:(nullable NSString *)securityKey;

/**
 Convenience method to set a dictionary within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param dictionary   The NSDictionary to be saved in the configuration. May be nil to remove an existing object.  The `copy` function will be executed on the dictionary to insure an immutable copy is saved.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setDictionary:(nullable NSDictionary *)dictionary
            forDomain:(NSString *)domain
                  key:(NSString *)key
             security:(nullable NSString *)securityKey;

/**
 Used to set an object within the existing storage. The domain security key is required if the domain is protected. If the object for the specified key exists, then it is replaced. If the value is different, then an event will be triggered.
 
 @param value        Represents any data object, but it is recommended that the object be an immutable object, otherwise it is incumbent upon the Configuration provider and consumers to use that object in safe ways when dealing with mutability and thread safety.
 @param domain       The configuration domain namespace. May not be nil.
 @param key          The key being set. May not be nil.
 @param securityKey  The security key for the specified domain that will be required to update data if the domain is protected. May be nil.
 */
- (void)setObject:(nullable id)value
        forDomain:(NSString *)domain
              key:(NSString *)key
         security:(nullable NSString *)securityKey;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
