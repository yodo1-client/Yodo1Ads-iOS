/*
 * Copyright (C) 2012-2016 Soomla Inc. - All Rights Reserved
 *
 *   Unauthorized copying of this file, via any medium is strictly prohibited
 *   Proprietary and confidential
 *
 *   Written by Refael Dakar <refael@soom.la>
 */

#import <Foundation/Foundation.h>
#import "TracebackAdvertising.h"
#import "SoomlaConfig.h"

#define SOOMLA_TRACEBACK_VERSION    @"4.7.0"

@protocol SoomlaTracebackDelegate <NSObject>

@required

@optional

- (void)adDisplayedForAdNetwork:(NSString*)adNetwork andAdType:(TracebackAdType)adType;
- (void)adClosedForAdNetwork:(NSString*)adNetwork andAdType:(TracebackAdType)adType;

@end


@interface SoomlaTraceback : NSObject

@property (nonatomic, weak) id<SoomlaTracebackDelegate> delegate;

+ (SoomlaTraceback *)getInstance;

- (void)initializeWithAppKey:(NSString*)appKey;
- (void)initializeWithAppKey:(NSString*)appKey andConfig:(SoomlaConfig*)config;
- (void)setUserConsent:(BOOL)userConsent;
- (NSString*)getIdfaWithFallback;
- (void)shutdown;
- (void)changeUserId:(NSString*)userId;
- (void)addExtraUserId:(NSString *)userId;
- (void)addTags:(NSArray*)tags;
- (void)removeTags:(NSArray*)tags;
- (void)getUserAdActions:(void (^)(NSArray *adActions))success
                 failure:(void (^)(NSString *reason))failure;
- (void)overrideCountryCode:(NSString*)countryCode;
- (void)onInAppPurchaseCompletedOfItem:(NSString*)itemId withPrice:(NSNumber*)price andCurrency:(NSString*)currency;

- (void)onCrossPromotionAdDisplayed:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;
- (void)onCrossPromotionAdClicked:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;
- (void)onCrossPromotionAdClosed:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;

@end
