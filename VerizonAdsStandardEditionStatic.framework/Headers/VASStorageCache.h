///
/// @file
/// @brief Definitions for VASStorageCache.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 VASStorageCache is the base class for local storage.
 */
@interface VASStorageCache : NSObject

/// Provides the root level storage location.
@property (class, readonly) NSURL *rootURL;

/// The class defining the subdirectory for the storage.
@property (nonatomic, readonly) Class ownerClass;

/// The full path to the location of the cached files.
@property (nullable, readonly) NSURL *resourcesDir;

/**
 Deletes the directory specified by url. Will only succeed for URLs representing subdirectories of the cache root
 
 @param url     The subdirectory of the cache directory.
 @return YES if the directory is deleted.
 */
+ (BOOL)deleteDirectoryAtURL:(NSURL *)url;
+ (void)deleteExpiredDirectoriesForClass:(Class)classType
                      expirationDuration:(NSTimeInterval)expirationDuration;

- (nullable instancetype)initForClass:(Class)classType NS_DESIGNATED_INITIALIZER;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Creates the subdirectory for this instance.
 
 @return status of the cache directory creation.
 */
- (BOOL)createInstanceDirectory;

/// Deletes the instance directory and its contents.
- (void)deleteDirectory;

@end

NS_ASSUME_NONNULL_END
