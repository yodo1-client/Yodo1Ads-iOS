//
//  AppStoreProduct.h
//
//  Created by yodo1 on 14-5-19.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Yodo1Types.h"

//各渠道产品item 字段
#define PRODUCT_ID                  @"ChannelProductId"
#define PRODUCT_NAME                @"ProductName"
#define PRODUCT_PRICE               @"ProductPrice"
#define PRICE_DISPLAY               @"PriceDisplay"
#define PRODUCT_CURRENCY            @"Currency"
#define PRODUCT_DESCRIPTION         @"ProductDescription"
#define GAME_ID                     @"gameId"
#define KUAIYONG_MD5KEY             @"md5Key"
#define PRODUCTTYPE                 @"ProductType"

#define ORDER_ID                    @"orderid"



@interface AppStoreProduct : NSObject

@property (nonatomic, copy) NSString* uniformProductId;
@property (nonatomic, copy) NSString* channelProductId;
@property (nonatomic, copy) NSString* productName;
@property (nonatomic, copy) NSString* productPrice;
@property (nonatomic, copy) NSString* priceDisplay;
@property (nonatomic, copy) NSString* productDescription;
@property (nonatomic, copy) NSString* currency;
@property (nonatomic, assign) ProductType productType;

- (id)initWithDict:(NSDictionary*)dictProduct productId:(NSString*)uniformProductId;

@end
