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

#define SOOMLA_TRACEBACK_VERSION    @"5.10.1"

static NSString *SOOMLA_AGENT_TAG = @"SoomlaSDK";

@protocol SoomlaTracebackDelegate <NSObject>

@required

@optional

- (void)adDisplayedForAdNetwork:(NSString*)adNetwork andAdType:(TracebackAdType)adType;
- (void)adClosedForAdNetwork:(NSString*)adNetwork andAdType:(TracebackAdType)adType;

@end

@protocol SoomlaConnectorStatusDelegate <NSObject>

@optional
- (void)statusReceived:(NSString*)status forAdNetwork:(NSString*)adNetwork withMessage:(NSString*)message;

@end

@protocol SoomlaAdsCustomData <NSObject>

@required
- (NSDictionary*)impressionCustomDataForAdNetwork:(NSString*)adNetwork withAdType:(TracebackAdType)adType andExtra:(NSDictionary*)extra;

@end

@interface SoomlaTraceback : NSObject

@property (nonatomic, weak) id<SoomlaTracebackDelegate> delegate;
@property (nonatomic, weak) id<SoomlaConnectorStatusDelegate> connectorStatusDelegate;
@property (nonatomic, weak) id<SoomlaAdsCustomData> adsCustomData;

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
- (void)overrideCountryCode:(NSString*)countryCode;
- (void)onInAppPurchaseCompletedOfItem:(NSString*)itemId withPrice:(NSNumber*)price andCurrency:(NSString*)currency;

- (void)onCrossPromotionAdDisplayed:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;
- (void)onCrossPromotionAdClicked:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;
- (void)onCrossPromotionAdClosed:(NSObject*)ad withAdType:(TracebackAdType)adType andAppStoreId:(NSString*)appStoreId;

- (void)onAdDisplayed:(NSString *)adNetwork withAdType:(TracebackAdType)adType andExtraFields:(NSDictionary *)extraFields;
- (void)onAdClicked:(NSString *)adNetwork withAdType:(TracebackAdType)adType andExtraFields:(NSDictionary *)extraFields;
- (void)onVideoCompleted:(NSString *)adNetwork withAdType:(TracebackAdType)adType andExtraFields:(NSDictionary *)extraFields;
- (void)onAdClosed:(NSString *)adNetwork withAdType:(TracebackAdType)adType andExtraFields:(NSDictionary *)extraFields;

@end
