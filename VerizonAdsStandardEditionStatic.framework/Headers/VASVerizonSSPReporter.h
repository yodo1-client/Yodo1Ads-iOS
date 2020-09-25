///
/// @file
/// @brief Definitions for VASVerizonSSPReporter.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class VASAds;

/**
 A placeholder for our reporting object.
 */
@interface VASVerizonSSPReporter : NSObject

/**
 Initialize a new SSP reporter instance.
 @param vasAds The VASAds instance for this object to use.
 @return An initialized instance of this class.
 */
- (instancetype)initWithVASAds:(VASAds *)vasAds;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

/**
 Start the reporter.
 
 @return YES if successful and the reporter has started. If it returns NO, then it will not be started.
 */
- (BOOL)startReporter;

/**
 Clear the reporting events.
 */
- (void)clearReporter;

@end

NS_ASSUME_NONNULL_END
