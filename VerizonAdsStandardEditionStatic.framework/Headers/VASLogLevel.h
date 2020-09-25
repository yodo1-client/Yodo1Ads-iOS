///
/// @file
/// @brief Defines the VASLogLevel enum.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

/**
 VASLogLevel logging levels.
 */
typedef NS_ENUM(NSUInteger, VASLogLevel)
{
    /// Used to indicate VERBOSE level logging.
    VASLogLevelVerbose,
    /// Used to indicate DEBUG level logging.
    VASLogLevelDebug,
    /// Used to indicate INFO level logging.
    VASLogLevelInfo,
    /// Used to indicate WARN level logging.
    VASLogLevelWarn,
    /// Used to indicate ERROR level logging.
    VASLogLevelError
};
