//
//  SubscriptionInfo.m
//  Yodo1UCenter
//
//  Created by Yuehai on 27/07/2017.
//

#import "SubscriptionInfo.h"

@implementation SubscriptionInfo

- (id)initWithUniformProductId:(NSString*)m_uniformProductId channelProductId:(NSString*)m_channelProductId expires:(NSTimeInterval)m_expiresTime purchaseDate:(NSTimeInterval)m_purchaseDateMs
{
    self = [super init];
    if (self) {
        self.uniformProductId = m_uniformProductId == nil ? @"ERROR_PRODUCT_NOT_FOUND":m_uniformProductId;
        self.channelProductId = m_channelProductId;
        self.expiresTime = m_expiresTime;
        self.purchase_date_ms = m_purchaseDateMs;
    }
    return self;
}

@end
