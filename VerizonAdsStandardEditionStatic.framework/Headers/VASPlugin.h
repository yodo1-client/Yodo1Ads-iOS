///
/// @file
/// @brief Definitions for VASPlugin.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASAdAdapter.h"
#import "VASContentFilter.h"
#import "VASConfigurationProvider.h"

@class VASAds;

NS_ASSUME_NONNULL_BEGIN

@protocol VASPEXFactory;

/**
 Plugin registration data.
 */
@interface VASPlugin : NSObject

@property(nonatomic, readonly) NSString *identifier;
@property(nonatomic, readonly) NSString *name;
@property(nonatomic, readonly) NSString *version;
@property(nonatomic, readonly) NSString *author;
@property(nonatomic, readonly, nullable) NSURL *email;
@property(nonatomic, readonly, nullable) NSURL *website;
@property(nonatomic, readonly) NSInteger minApiLevel;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Initialize with read-only properties.

 @param identifier plugin identifier
 @param name plugin name
 @param version plugin version
 @param author plugin author
 @param email plugin author email
 @param website plugin author website
 @param minApiLevel plugin min SDK API level required
 @return An initialized instance of this class.
 */
- (instancetype)initWithId:(NSString *)identifier
                      name:(NSString *)name
                   version:(NSString *)version
                    author:(NSString *)author
                     email:(nullable NSURL *)email
                   website:(nullable NSURL *)website
               minApiLevel:(NSInteger)minApiLevel NS_DESIGNATED_INITIALIZER;

/**
 This is called to allow plugins to prepare themselves (e.g., register their components).
 This method is called on the main thread and should not perform functions that potentially block for an extended time. Dispatch tasks to another queue that may require longer processing times such as network activity or loading resources.
 
 @param vasAds VASAds object to be used
 @return YES if the prepare method was successful and the plugin is ready, or expected to be ready following delayed tasks. If the plugin returns NO, then it will not be registered and no further attempts to prepare it will occur.
 */
- (BOOL)prepareWithVASAds:(VASAds *)vasAds;

/**
 This is called when the plugin was enabled.
 */
- (void)pluginEnabled;

/**
 This is called when the plugin was disabled.
 */
- (void)pluginDisabled;

@end

NS_ASSUME_NONNULL_END
