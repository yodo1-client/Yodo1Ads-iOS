/*
 * Copyright (C) 2012-2015 Soomla Inc. - All Rights Reserved
 *
 *   Unauthorized copying of this file, via any medium is strictly prohibited
 *   Proprietary and confidential
 *
 *   Written by Refael Dakar <refael@soom.la>
 */

/**
 an Enumaration listing all the ads available
 */
typedef enum {
    TB_UNKNOWN_AD_TYPE  = -1,
    TB_RICH_MEDIA		= 0,
    TB_INTERSTITIAL 	= 1,
    TB_APP_WALL         = 2,
    TB_VIDEO			= 3,
    TB_REWARDED_VIDEO	= 4,
    TB_NATIVE			= 5,
    TB_BANNER			= 6,
    TB_OFFER_WALL       = 7,
    TB_NATIVE_HTML      = 8,
    TB_EXTERNAL         = 9,
    TB_REWARDED         = 10,
    TB_INTERACTIVE      = 11
} TracebackAdType;

typedef enum {
    TB_UNKNOWN_ADVIT    = -1,
    TB_DOMAIN           = 0,
    TB_PACKAGE_NAME     = 1,
    TB_AMAZON_ID        = 2,
    TB_ITUNES_ID        = 3,
    TB_APP_NAME         = 4,
    TB_DIRECT           = 5,
    TB_BRAND_NAME       = 6,
    TB_BUNDLE_ID        = 7
} TracebackAdvertiserIdType;

typedef enum {
    TB_CREATIVE_UNKNOWN     = -1,
    TB_CREATIVE_IMAGE       = 0,
    TB_CREATIVE_HTML        = 1,
    TB_CREATIVE_VIDEO       = 2,
    TB_CREATIVE_PLAYABLE    = 3,
    TB_CREATIVE_WEBPAGE     = 4,
    TB_CREATIVE_STATIC      = 5, // static native
    TB_CREATIVE_CAROUSEL    = 6
} TracebackCreativeType;

typedef enum {
    TB_UNKNOWN_ERROR        = -1,
    TB_NO_FILL              = 0,
    TB_AD_NETWORK_ERROR     = 1,
    TB_INTEGRATION_ERROR    = 2,
    TB_DEVICE_ERROR         = 3
} TracebackAdError;

@interface TracebackAdvertising : NSObject

+ (NSString *)adTypeEnumToString:(TracebackAdType)adType;

@end
