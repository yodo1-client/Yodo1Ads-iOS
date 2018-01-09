//
//  SubscriptionInfo.h
//  Yodo1UCenter
//
//  Created by Yuehai on 27/07/2017.
//

#import <Foundation/Foundation.h>

@interface SubscriptionInfo : NSObject

@property (nonatomic, retain) NSString* uniformProductId;       //通用产品id
@property (nonatomic, retain) NSString* channelProductId;       //渠道产品id:比如91的产品id，AppStore的产品
@property (nonatomic, assign) NSTimeInterval expiresTime;       //过期时间
@property (nonatomic, assign) NSTimeInterval purchase_date_ms;  //购买时间

- (id)initWithUniformProductId:(NSString*)uniformProductId channelProductId:(NSString*)channelProductId expires:(NSTimeInterval)expiresTime purchaseDate:(NSTimeInterval)purchaseDateMs;

@end
