//
//  SoomlaConfig.h
//  SoomlaTraceback
//
//  Created by Boris Spektor on 25/10/2018.
//  Copyright © 2018 SOOMLA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TB_LOG_LEVEL_NONE       = 0,
    TB_LOG_LEVEL_ERROR      = 1,
    TB_LOG_LEVEL_WARNING    = 2,
    TB_LOG_LEVEL_INFO       = 3,
    TB_LOG_LEVEL_DEBUG      = 4,
    TB_LOG_LEVEL_VERBOSE    = 5
} TracebackLogLevel;

@protocol SoomlaInitDelegate <NSObject>
- (void)initFinishedSuccessfully:(BOOL)success;
@end

@protocol SoomlaSdkConfigDelegate <NSObject>
- (void)onSdkConfigured;
@end

@interface SoomlaConfig : NSObject

@property (nonatomic) NSString *userId;
@property (nonatomic) BOOL testMode;
@property (nonatomic) BOOL collectIdfa;
@property (nonatomic) BOOL validateVersions;
@property (nonatomic) BOOL sendAttributionData;
@property (nonatomic) BOOL loadConnectorsAfterConfig;
@property (nonatomic) TracebackLogLevel logLevel;
@property (nonatomic, weak) id<SoomlaInitDelegate> initDelegate;
@property (nonatomic, weak) id<SoomlaSdkConfigDelegate> sdkConfigDelegate;
@property (nonatomic) BOOL liveEventsLogEnabled;

+ (SoomlaConfig*)config;

@end
