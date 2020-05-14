//
//  Yodo1Tool+OpsParameters.m
//  Yodo1UCManager
//
//  Created by yixian huang on 2020/5/6.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import "Yodo1Tool+OpsParameters.h"

@implementation Yodo1Tool (OpsParameters)

- (NSString *)ucapDomain {
#ifdef DEBUG
    return @"https://api-ucap-test.yodo1.com/uc_ap";
#else
    return @"https://uc-ap.yodo1api.com/uc_ap";
#endif
}

- (NSString *)deviceLoginURL {
    return @"channel/device/login";
}

- (NSString *)paymentDomain {
    return @"https://api-payment-test.yodo1.com/";
}

- (NSString *)generateOrderIdURL {
    return @"payment/order/generateOrderId";
}

- (NSString *)verifyAppStoreIAPURL {
    return @"payment/channel/appStore/payVerify";
}

- (NSString *)querySubscriptionsURL {
    return @"payment/channel/appStore/querySubscriptions";
}

- (NSString *)sendGoodsOverURL {
    return @"payment/order/sendGoodsOver";
}

- (NSString *)reportOrderStatusURL {
    return @"payment/order/reportOrderStatus";
}

- (NSString *)clientCallbackURL {
    return @"payment/order/ClientCallback";
}

- (NSString *)createOrderURL {
    return @"payment/order/create";
}

@end
