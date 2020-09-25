///
/// @file
/// @brief Definitions for VASComponent
///
/// @copyright Copyright (c) 2019 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// The fundamental protocol for all components.
@protocol VASComponent <NSObject>

/// The release method is a convenience method called by destroy and should provide any cleanup for the component such as removing a view, deleting cached files, etc. All implementations of releaseResources should also be accomplished via normal ARC release mechanisms whether by dealloc or otherwise.
- (void)releaseResources;

@end

NS_ASSUME_NONNULL_END
