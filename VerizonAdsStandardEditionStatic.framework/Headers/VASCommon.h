///
/// @internal
/// @file
/// @brief Common utility definitions and macros.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

/// Let's keep this file "clean" and only define macros that do not require any additional dependencies.
/// Excepting Foundation, we should use other (more specific) helpers if we need others that do pull in dependencies.

#import <Foundation/Foundation.h>

//////////
#pragma mark - Logic Helper Macros
//////////

// NULL_OR_VALUE(x)
#define NULL_OR_VALUE(x) ((x) ?: [NSNull null])

// VALUE_EXISTS_OF_TYPE(dict, key, type)
#define HAS_VALUE_OF_TYPE(dict, key, type) \
((dict)[(key)] && [(dict)[(key)] isKindOfClass:[type class]])

// Milliseconds per second define
#define MSEC_PER_SEC 1000.0

// Adapted from Wil Shipley's IsEmpty implementation: https://blog.wilshipley.com/2005/10/pimp-my-code-interlude-free-code.html
static inline BOOL VASIsEmpty(id thing) {
    return thing == nil
    || thing == [NSNull null]
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}

//////////
#pragma mark - System Versioning Preprocessor Macros
//////////

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//////////
#pragma mark - Conversion and String Helper Macros
//////////

#define BOOL_TO_NSSTRING(value) ((value) ? @"YES" : @"NO")


//////////
#pragma mark - Dispatch Helper Macros
//////////

// Nanosecond constants for dispatch time.
#define MAX_NSEC_SEC    ((UINT64_MAX / NSEC_PER_SEC) - 1)

#define DISPATCH_WALLTIME_SECONDS(seconds)  (dispatch_walltime(DISPATCH_TIME_NOW, (uint64_t)((seconds) * NSEC_PER_SEC)))
#define DISPATCH_TIME_SECONDS(seconds)  (dispatch_time(DISPATCH_TIME_NOW, (uint64_t)((seconds) * NSEC_PER_SEC)))
#define DISPATCH_TIME_MILLISECONDS(ms)  (dispatch_time(DISPATCH_TIME_NOW, (uint64_t)((ms) * NSEC_PER_MSEC)))

#define GLOBAL_QUEUE_DEFAULT            (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0))


//////////
#pragma mark - Warning Suppression Macros
//////////

// New iOS calls that should be wrapped in @available.
#define SUPPRESS_UNGUARDED_AVAILABILITY_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wunguarded-availability\"")

#define RESTORE_UNGUARDED_AVAILABILITY_WARNINGS \
_Pragma("clang diagnostic pop")

// Disable passing null to callee warnings
#define SUPPRESS_NONNULL_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wnonnull\"")

#define RESTORE_NONNULL_WARNINGS \
_Pragma("clang diagnostic pop")

// Disable incomplete implementation warnings
#define SUPPRESS_INCOMPLETE_IMPLEMENTATION_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wincomplete-implementation\"") _Pragma("clang diagnostic ignored \"-Wprotocol\"")

#define RESTORE_INCOMPLETE_IMPLEMENTATION_WARNINGS \
_Pragma("clang diagnostic pop")

// Disable category also implementing method warnings
#define SUPPRESS_CATEGORY_ALSO_IMPLEMENTING_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wobjc-protocol-method-implementation\"")

#define RESTORE_CATEGORY_ALSO_IMPLEMENTING_WARNINGS \
_Pragma("clang diagnostic pop")

// Disable category also implementing method warnings
#define SUPPRESS_FORMAT_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wformat\"")

#define RESTORE_FORMAT_WARNINGS \
_Pragma("clang diagnostic pop")

// New iOS calls that should be wrapped in @available.
#define SUPPRESS_UNDECLARED_SELECTOR_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wundeclared-selector\"")

#define RESTORE_UNDECLARED_SELECTOR_WARNINGS \
_Pragma("clang diagnostic pop")

// Disable multiple methods warnings (mainly when mocking in tests)
#define SUPPRESS_MULTIPLE_METHODS_WARNINGS \
_Pragma("clang diagnostic push") _Pragma("clang diagnostic ignored \"-Wstrict-selector-match\"")

#define RESTORE_MULTIPLE_METHODS_WARNINGS \
_Pragma("clang diagnostic pop")
