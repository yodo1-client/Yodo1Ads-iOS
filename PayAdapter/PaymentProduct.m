//
//  PaymentProduct.m
//
//  Created by yodo1 on 14-5-19.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "PaymentProduct.h"

@implementation PaymentProduct
@synthesize uniformProductId;
@synthesize channelProductId;
@synthesize price;
@synthesize currency;
@synthesize gameUserId;
@synthesize gameNickname;
@synthesize ucuid;
@synthesize channelId;
@synthesize gameRegionCode;
@synthesize extra;
@synthesize trxReceipt;
@synthesize transactionIdentifier;
@synthesize productType;

-(void)dealloc
{
    [uniformProductId release];
    [channelProductId release];
    [price release];
    [currency release];
    [gameUserId release];
    [gameNickname release];
    [ucuid release];
    [channelId release];
    [gameRegionCode release];
    [extra release];
    [trxReceipt release];
    [transactionIdentifier release];
    [productType release];
    
    [super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.uniformProductId forKey:@"uniformProductId"];
    [coder encodeObject:self.channelProductId forKey:@"channelProductId"];
    [coder encodeObject:self.price forKey:@"price"];
    [coder encodeObject:self.currency forKey:@"currency"];
    [coder encodeObject:self.gameUserId forKey:@"gameUserId"];
    [coder encodeObject:self.gameNickname forKey:@"gameNickname"];
    [coder encodeObject:self.ucuid forKey:@"ucuid"];
    [coder encodeObject:self.channelId forKey:@"channelId"];
    [coder encodeObject:self.gameRegionCode forKey:@"gameRegionCode"];
    [coder encodeObject:self.extra forKey:@"extra"];
    [coder encodeObject:self.trxReceipt forKey:@"trxReceipt"];
    [coder encodeObject:self.transactionIdentifier forKey:@"transactionIdentifier"];
    [coder encodeObject:self.productType forKey:@"productType"];
}

- (id)initWithCoder:(NSCoder *) coder
{
    uniformProductId = [[coder decodeObjectForKey:@"uniformProductId"]copy];
    channelProductId = [[coder decodeObjectForKey:@"channelProductId"]copy];
    price = [[coder decodeObjectForKey:@"price"]copy];
    currency = [[coder decodeObjectForKey:@"currency"]copy];
    gameUserId = [[coder decodeObjectForKey:@"gameUserId"]copy];
    gameNickname = [[coder decodeObjectForKey:@"gameNickname"]copy];
    ucuid = [[coder decodeObjectForKey:@"ucuid"]copy];
    channelId = [[coder decodeObjectForKey:@"channelId"]copy];
    gameRegionCode = [[coder decodeObjectForKey:@"gameRegionCode"]copy];
    extra = [[coder decodeObjectForKey:@"extra"]copy];
    trxReceipt = [[coder decodeObjectForKey:@"trxReceipt"]copy];
    transactionIdentifier = [[coder decodeObjectForKey:@"transactionIdentifier"]copy];
    productType = [[coder decodeObjectForKey:@"productType"] copy];
    
    return self;
}

@end
