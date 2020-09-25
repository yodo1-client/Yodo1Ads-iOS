///
/// @file
/// @brief Definitions for VASCore VASEvents.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Protocol for enabling an object to receive VASEvents.
 */
@protocol VASEventReceiver <NSObject>
@required
/**
 Protocol method that receives VASAds events and associated data.
 This call is made on an arbitrary background queue and, if needed, should be dispatched to a known queue such as the main queue for UI processing.

 @param topic An event topic string. May not be nil.
 @param object Arbitrary data object defined by the event topic type. May be nil.
 */
- (void)event:(NSString *)topic data:(nullable id)object;
@end

/**
 Protocol for inspection of event data to determine if it should be accepted.
 */
@protocol VASEventMatcher <NSObject>
@required
/**
 Provides an opportunity to inspect the data prior to sending an event to any associated receivers.
 This call is made on an arbitrary background queue.
 
 @param topic An event topic string. May not be nil.
 @param object Arbitrary data object defined by the event topic type. May be nil.
 @returns `YES` if the specified topic event should proceed to the subscribed receivers.
 */
- (BOOL)matches:(NSString *)topic data:(nullable id)object;
@end

#pragma mark - VASEvents

/**
 The eventing system to subscribe and communicate events.
 */
@interface VASEvents : NSObject

/**
 Subscribe to an event topic to receive events to the specified receiver object.
 Calling subscribeReceiver multiple times with the same topic and eventMatcher will ignore the duplicate calls.
 Subscribing to both a specific topic and to all events (by specifying a nil topic) will yield double callbacks for the subscribed topic.
 \par
 NOTE: This class does not retain `strong` references to `receiver` nor `eventMatcher` so the caller must retain a `strong` reference or they will be released. This is generally not a problem because the most common use is for the caller to implement VASEventReceiver and/or VASEventMatcher and then pass `self` as the `receiver` and/or `eventMatcher` here. However, if a shared or separate instance is used instead, they must be retained elsewhere, because this class stores them as `weak` references.
 
 @param receiver An object that conforms to VASEventReceiver to receive VASEvents. May not be nil.
 @param topic An event topic string. May be nil to indicate receiving all event topics.
 @param eventMatcher Optional object that implements VASEventMatcher. May be nil.
 */
- (void)subscribeReceiver:(id<VASEventReceiver>)receiver
                 forTopic:(nullable NSString *)topic
                 matching:(nullable id<VASEventMatcher>)eventMatcher;

/**
 Unsubscribe from an event topic to stop receiving events to the specified receiver object.
 Once unsubscribed, further unsubscribeReceiver calls of a topic/eventMatcher pair will be ignored.
 \par
 NOTE: Unsubscribing is not strictly required because this class retains weak references to the `receiver` and cleans up the internal collections lazily (during subsequent subscribe/unsubscribe operations) when any receivers have become `nil`. However, unsubscribing is still useful (in general) to stop receiving events or to release resources more proactively.

 @param receiver An object that conforms to VASEventReceiver to receive VASEvents. May not be nil.
 @param topic An event topic string. May be nil to indicate receiving all event topics.
 @param eventMatcher Optional object that implements VASEventMatcher. May be nil.
 */
- (void)unsubscribeReceiver:(id<VASEventReceiver>)receiver
                   forTopic:(nullable NSString *)topic
                   matching:(nullable id<VASEventMatcher>)eventMatcher;

/**
 Send an event with the specified event topic along with relevant data, if appropriate.
 The event is sent asynchronously, returning immediately to the caller, with any listeners receiving the event notification on an arbitrary background queue.
 
 @param topic An event topic string. May not be nil.
 @param object Arbitrary data defined by the event topic type. May be nil.
 */
- (void)sendEvent:(NSString *)topic
             data:(nullable id)object;

/// @cond
- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
/// @endcond

@end

NS_ASSUME_NONNULL_END
