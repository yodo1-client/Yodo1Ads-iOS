///
/// @file
/// @brief Definitions for VASCore VASCoreEventTopics.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <Foundation/Foundation.h>

/**
 VASEvents topic sent when the app goes to background.
 
 Event data is the current UIApplication object.
 */
FOUNDATION_EXPORT NSString * const kVASCoreEventTopicAppBackground;

/**
 VASEvents topic sent when the app returns to foreground.
 
 Event data is the current UIApplication object.
 */
FOUNDATION_EXPORT NSString * const kVASCoreEventTopicAppForeground;

/**
 VASEvents topic sent when the system audio volume changes.
 
 The volume passed is the result of evaluating the AVAudioSession category, AVAudioSessionRouteDescription, and their interactions with the ringer/silent switch.  AVAudioSessionCategoryRecord mode (volume output not allowed in record mode) will return 0.0 or if the volume is indeterminate due to the ringer/silent switch, an ambient category, and the built-in speaker, nil is returned.
 
 The data parameter is an NSNumber float value that will range from 0.0 to 1.0 or nil if the volume is indeterminate as described above.
 */
FOUNDATION_EXPORT NSString * const kVASCoreEventTopicVolumeChanged;

/**
 VASEvents topic sent when the app's user interface orientation changed.
 
 Event data is the notification object.
 */
FOUNDATION_EXPORT NSString * const kVASCoreEventTopicOrientationChanged;
