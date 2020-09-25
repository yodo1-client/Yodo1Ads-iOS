///
/// @file
/// @brief Definitions for VASFileStorageCache.
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASStorageCache.h>
#import <VerizonAdsStandardEditionStatic/VASErrorInfo.h>

@class VASAds;

NS_ASSUME_NONNULL_BEGIN

typedef void(^VASFileStorageCacheCompletion)(NSURL *remoteURL, NSURL * _Nullable fileURL, VASErrorInfo * _Nullable errorInfo);

/**
 VASFileStorageCache provides a local caching of files downloaded from the network.
 */
@interface VASFileStorageCache : VASStorageCache

/// The number of files queued for download. This number will go to zero once downloadQueuedFiles is called but will represent any file requests added after that until the next call to downloadQueuedFiles.
@property (readonly) NSUInteger requests;

- (nullable instancetype)initForClass:(Class)classType
                          usingVASAds:(VASAds *)vasAds NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initForClass:(Class)classType NS_UNAVAILABLE;

/**
 Add a file to the download queue of requests. Must be called before downloadQueuedFiles is initiated.
 
 @param remoteURL   The origin URL of the resource to retrieve.
 @param contentType The content type of the resource to facilitate the file naming.
 @param completion  The optional callback executed once the resource has been downloaded to perform any post-download actions. It is called on the download background queue synchronously to allow any actions to block the fulfillment of the completion of the resource download. The remoteURL is always passed and fileURL will be non-nil unless an error has occurred which will then be in the errorInfo parameter.
 */
- (void)queueFileForDownload:(NSURL *)remoteURL
                 contentType:(NSString *)contentType
                  completion:(nullable VASFileStorageCacheCompletion)completion;

/**
 Request file downloads for all resources in the queue.
 
 @param timeout   Maximum amount of time to wait for each file to download.
 @param handler   Callback for each file download with lastFile YES for the final callback. Will always call a final callback even after an abort.
 */
- (void)downloadQueuedFiles:(NSTimeInterval)timeout
                    handler:(void(^)(NSURL *remoteURL, VASErrorInfo * _Nullable error, BOOL lastFile))handler;

/// Cancels all pending downloads and marks current download tasks as cancelled. The downloadQueuedFiles handler should be called with a final callback with its lastFile paramter set to YES.
- (void)stopAllDownloads;

/**
 Returns the downloaded cache file URL if it has been successfully retrieved and saved, or nil otherwise.
 
 @param remoteURL   The original source URL representing the resource.
 @return an NSURL represeting the file URL in the cache on disk.
 */
- (nullable NSURL *)fileURLForURL:(NSURL *)remoteURL;

@end

NS_ASSUME_NONNULL_END
