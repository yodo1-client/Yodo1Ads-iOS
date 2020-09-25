///
/// @file
/// @brief Definitions for VASStandardEdition
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Contains APIs specific to the packaging of the Standard Edition, such as initializing the edition.
 */
@interface VASStandardEdition : NSObject

/**
 Initialize the SDK for use with a specific site ID.
 This method must be called before using any other components of the SDK.
 This method must be called on the main thread.

 @param siteId The site ID.
 @return `YES` if initialized successfully, `NO` otherwise.
 */
+ (BOOL)initializeWithSiteId:(NSString *)siteId;

@end

NS_ASSUME_NONNULL_END
