//
//  YODO1OnlineParameter.h
//
//  Created by yixian huang on 2017/7/24.
//
//  sdk version 1.0.4
//

#ifndef Yodo1OnlineParameter_h
#define Yodo1OnlineParameter_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXPORT NSString* const kYodo1OnlineConfigFinishedNotification;
FOUNDATION_EXPORT NSString* const kOPSDKVersion;

@interface Yodo1OnlineParameter:NSObject

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)initialize NS_UNAVAILABLE;

+ (void)initWithAppKey:(NSString *)appKey
                channel:(NSString *)channel;

+ (NSString *)stringParams:(NSString *)key defaultValue:(NSString *)defaultValue;

+ (BOOL)boolParams:(NSString *)key defaultValue:(BOOL) defaultValue;

+ (void)setDebugMode:(BOOL)enableDebugMode;

+ (BOOL)getDebug;

@end

NS_ASSUME_NONNULL_END
#endif /* Yodo1OnlineParameter_h */
