///
/// @file
/// @brief Defines VASLogger interface and VASLogLevel enum.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>
#import "VASLogLevel.h"

extern const VASLogLevel kVASDefaultLogLevel;

/**
 Core logging class.
 */
@interface VASLogger : NSObject

/// @cond (!PUBLISHER_API)

/**
 Create an instance of a logger for use by a class implementation.

 @param class Identifies the class where the log call occurs.
 @return An VASLogger for the specified class.
 */
+ (instancetype)loggerForClass:(Class)class;

/**
 Get the log level used by the SDK when logging.

 @return The log level.
 */
+ (VASLogLevel)logLevel;

/**
 Determine if a specified log level is enabled.

 @param level The log level to test.
 @return `YES` if the log level is enabled, NO otherwise.
 */
+ (BOOL)isLogLevelEnabled:(VASLogLevel)level;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

/**
 Send a verbose log message.

 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)verbose:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Send a debug log message.

 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)debug:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Send an info log message.

 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)info:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Send a warning log message.

 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)warn:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Send an error log message.

 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)error:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);

/**
 Send a log message with the specified log level. This is useful for cases where the log level may be dynamic or configurable.
 
 @param level The level to use when emitting this log.
 @param format A format string to use for output.
 @param ... A comma-separated list of arguments to substitute into format.
 */
- (void)logWithLevel:(VASLogLevel)level format:(NSString *)format, ... NS_FORMAT_FUNCTION(2,3);

@end

/// @endcond
