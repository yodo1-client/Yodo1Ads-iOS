//
//  Yodo1Adapter.m
//  NetGameSDK_Sample
//
//  Created by hyx on 14-6-3.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "Yodo1Adapter.h"

@interface Yodo1Adapter ()
@end

@implementation Yodo1Adapter

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)initWithType:(LoginType)type orientation:(UIInterfaceOrientation)orientation
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)channelUserId{return nil;}

- (NSString *)channelUserName{return nil;}

- (NSString *)channelSessionId{return nil;}

- (void)channelUserView{}

- (void)checkAppUpdate{}

- (void)login:(LoginUCenterCompletionBlock)block{}

- (void)showToolBar:(ChannelToolBarPlace)place{}

- (void)hideToolBar{}

- (void)handleOpenURL:(NSURL *)url
             sourceApplication:(NSString *)sourceApplication{}

- (void)loginOut{}

- (BOOL)isLogined{return NO;}

- (void)paymentWithProductId:(NSString *)uniformProductId{}

- (void)queryLossOrder{}

- (void)querySubscriptions:(BOOL)excludeOldTransactions{}

- (void)restorePayment{}

- (void)productInfoWithProductId:(NSString *)uniformProductId
                        callback:(ProductInfoCompletionBlock)callback{}

- (void)productsInfo:(ProductsInfoCompletionBlock)callback{}

- (void)savePaymentProducts:(id)products key:(NSString *)key{}


- (id)loadPaymentProducts:(NSString*)key{return nil;}

- (void)CancelPromotion{}

- (AppStoreProduct*)GetPromotionProduct
{
    return nil;
}

- (void)ReadyToContinuePurchaseFromPromot{
    
}
- (void)updateStorePromotionVisibility:(BOOL)visibility Product:(NSString*)uniformProductId {
    
}

- (void)fetchStorePromotionOrder {}

- (void)fetchStorePromotionVisibilityForProduct:(NSString*)uniformProductId{}

- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray{}

@end
