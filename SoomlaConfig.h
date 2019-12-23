//
//  SoomlaConfig.h
//  SoomlaTraceback
//
//  Created by Boris Spektor on 25/10/2018.
//  Copyright © 2018 SOOMLA. All rights reserved.
//

#import <Foundation/Foundation.h>

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
@property (nonatomic, weak) id<SoomlaInitDelegate> initDelegate;
@property (nonatomic, weak) id<SoomlaSdkConfigDelegate> sdkConfigDelegate;

+ (SoomlaConfig*)config;

@end
