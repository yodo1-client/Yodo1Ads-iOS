//
//  AppStoreProduct.m
//
//  Created by yodo1 on 14-5-19.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "AppStoreProduct.h"

@implementation AppStoreProduct
@synthesize channelProductId;
@synthesize productName;
@synthesize productPrice;
@synthesize productDescription;
@synthesize uniformProductId;
@synthesize currency;
@synthesize productType;

-(id)initWithDict:(NSDictionary*)dictProduct productId:(NSString*)uniformProductId_
{
    self = [super init];
    if (self) {
        self.uniformProductId = uniformProductId_;
        self.channelProductId = [dictProduct objectForKey:PRODUCT_ID];
        self.productName = [dictProduct objectForKey:PRODUCT_NAME];
        self.productPrice = [dictProduct objectForKey:PRODUCT_PRICE];
        self.priceDisplay = [dictProduct objectForKey:PRICE_DISPLAY];
        self.currency = [dictProduct objectForKey:PRODUCT_CURRENCY];
        self.productDescription = [dictProduct objectForKey:PRODUCT_DESCRIPTION];
        self.productType = [[dictProduct objectForKey:PRODUCTTYPE] intValue];
    }
    return self;
}

@end
