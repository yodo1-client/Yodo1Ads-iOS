///
///  @file
///  @brief Definitions for VASNativeComponent.
///
///  @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <VerizonAdsStandardEditionStatic/VASComponent.h>
#import <VerizonAdsStandardEditionStatic/VASFileStorageCache.h>

NS_ASSUME_NONNULL_BEGIN

/**
 All Native components must conform to this protocol for accessing native components.
 */
@protocol VASNativeComponent <VASComponent>

/// The type of the component.
@property (readonly) NSString *type;

/**
 When called, a component should queue all files for download that it requires using the passed VASFileStorageCache and calling queueFileForDownload. The parent component will then initiate the download of collected files.
 
 Always executed on a background queue.
 
 @param fileCache   File cache for loading files.
 */
- (void)queueFilesForDownloadWithCache:(VASFileStorageCache *)fileCache;

@end

NS_ASSUME_NONNULL_END
