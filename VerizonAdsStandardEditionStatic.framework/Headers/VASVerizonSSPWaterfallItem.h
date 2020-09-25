///
/// @internal
/// @file
/// @brief Definitions for VASVerizonSSPWaterfallItem.
///
/// @copyright Copyright (c) 2018 Verizon. All rights reserved.
///

#import "VASVerizonSSPWaterfallProvider.h"
#import "VASVerizonSSPWaterfallDemandSourceProtocol.h"

#define VASServerResponseEntryItemIdKey                  @"item"
#define VASServerResponseEntryNetworkIdKey               @"adnet"
#define VASServerResponseEntryCreativeIDHeaderKey        @"cridHeaderField"
#define VASServerResponseEntryTypeKey                    @"type"
#define VASServerResponseEntryValueKey                   @"value"
#define VASServerResponseEntryRequestInfoKey             @"req"
#define VASServerResponseEntryenableEnhancedAdControlKey @"enableEnhancedAdControl"
#define VASServerResponseEntryCreativeIdKey              @"creativeid"
#define VASServerResponseEntryAdMetaDataKey              @"adMetaData"
#define VASServerResponseEntryAdSizeKey                  @"adSize"
#define VASServerResponseEntryAdSizeWidthKey             @"w"
#define VASServerResponseEntryAdSizeHeightKey            @"h"

#define VASServerResponseRequestInfoSiteIdKey        @"site"
#define VASServerResponseRequestInfoSpaceIdKey       @"posId"
#define VASServerResponseRequestInfoURLKey           @"url"
#define VASServerResponseRequestInfoPostParamsKey    @"postBody"
#define VASServerResponseRequestInfoPostContentType  @"postType"
#define VASServerResponseRequestInfoValidateRegexKey @"validRegex"

// Demand source entries closely match waterfall server responses, but are not required to.
#define VASDemandSourceItemIdKey          VASServerResponseEntryItemIdKey    // NSString
#define VASDemandSourceNetworkIdKey       VASServerResponseEntryNetworkIdKey // NSString
#define VASDemandSourceTypeKey            VASServerResponseEntryTypeKey      // NSString
#define VASDemandSourceAdContentKey       @"adContent"   // NSString
#define VASDemandSourcePriceKey           @"price"       // NSString
#define VASDemandSourceBuyerKey           @"buyer"       // NSString
#define VASDemandSourceRequestKey         @"req"         // NSDictionary<NSString *, id>
#define VASDemandSourceRequestSiteKey     @"site"        // NSString
#define VASDemandSourceRequestSpaceIdKey  @"posId"       // NSString
#define VASDemandSourceRequestURLKey      @"url"         // NSString
#define VASDemandSourceAdCridKey          @"ad_crid"     // NSString
#define VASDemandSourceAdBidderIdKey      @"ad_bidder_id"// NSString

NS_ASSUME_NONNULL_BEGIN

// An abstract base class for the variety of VerizonSSP waterfall item types.
@interface VASVerizonSSPWaterfallItem : NSObject <VASWaterfallItem>

@property (readonly, copy) NSString *itemId;
@property (nullable, readonly, copy) NSString *networkId;
@property (nullable, readonly, copy) NSString *placementId;
@property (readonly, getter=isEnhancedAdControlEnabled) BOOL enhancedAdControlEnabled;
@property (nonatomic, nullable, readonly, copy) NSDictionary<NSString *, id> *adSize;
@property (nonatomic, nullable, copy) VASCreativeInfo *creativeInfo;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithResponseDictionary:(NSDictionary<NSString *, id> *)waterfallItemEntry
                               placementId:(nullable NSString *)placementId
                                    vasAds:(VASAds *)vasAds
                           HTTPURLResponse:(nullable NSHTTPURLResponse *)response;

- (instancetype)initWithItemId:(NSString *)itemId
                     networkId:(nullable NSString *)networkId
                   placementId:(nullable NSString *)placementId
             enhancedAdControl:(BOOL)enhancedAdControlEnabled
                        adSize:(nullable NSDictionary<NSString *, id> *)adSizeDictionary;

+ (nullable NSDictionary<NSString *, id> *)adSizeFromResponseDictionary:(NSDictionary<NSString *, id> *)responseDictionary;

+ (NSData *)retrieveAdContentWithURLData:(NSString *)url
                                postBody:(NSString *)postBody
                         postContentType:(NSString *)postContentType
                                 timeout:(NSTimeInterval)timeout
                                 session:(NSURLSession *)session
                                response:(NSURLResponse  * __autoreleasing _Nullable * _Nullable)response
                                   error:(VASErrorInfo  * __autoreleasing _Nullable * _Nullable)errorInfo;

+ (nullable VASVerizonSSPWaterfallItem *)createFromSuperAuctionDemandSourceType:(NSString *)demandSourceType placementId:(NSString *)placementId vasAds:(VASAds *)vasAds demandSourceResponse:(NSDictionary *)demandSourceResponseDict;

@end

NS_ASSUME_NONNULL_END

