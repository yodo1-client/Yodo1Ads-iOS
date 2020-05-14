//
//  Yd1UCenterManager.m
//  Yd1UCenterManager
//
//  Created by yixian huang on 2017/7/24.
//

#import "Yd1UCenterManager.h"
#import "RMStore.h"
#import "Yodo1Reachability.h"
#import "Yodo1Tool+Commons.h"
#import "Yodo1Tool+Storage.h"
#import "RMStoreUserDefaultsPersistence.h"
#import "Yd1UCenter.h"
#import "RMStoreTransaction.h"

@implementation Product

- (instancetype)initWithDict:(NSDictionary*)dictProduct
                   productId:(NSString*)uniformProductId_ {
    self = [super init];
    if (self) {
        self.uniformProductId = uniformProductId_;
        self.channelProductId = [dictProduct objectForKey:@"ChannelProductId"];
        self.productName = [dictProduct objectForKey:@"ProductName"];
        self.productPrice = [dictProduct objectForKey:@"ProductPrice"];
        self.priceDisplay = [dictProduct objectForKey:@"PriceDisplay"];
        self.currency = [dictProduct objectForKey:@"Currency"];
        self.productDescription = [dictProduct objectForKey:@"ProductDescription"];
        self.productType = (ProductType)[[dictProduct objectForKey:@"ProductType"] intValue];
        self.periodUnit = [dictProduct objectForKey:@"PeriodUnit"];
    }
    return self;
}

@end

@interface Yd1UCenterManager ()<RMStoreObserver> {
    NSMutableDictionary* productInfos;
    NSMutableArray* channelProductIds;
    RMStoreUserDefaultsPersistence *persistence;
    PaymentCallback paymentCallback;
}

@property (nonatomic,strong) NSString* currentUniformProductId;
@property (nonatomic,retain) SKPayment* addedStorePayment;//promot Appstore Buy

- (Product *)productWithChannelProductId:(NSString *)channelProductId;
- (NSArray *)productInfoWithProducts:(NSArray *)products;
- (void)updateProductInfo:(NSArray *)products;
- (NSString *)diplayPrice:(SKProduct *)product;
- (NSString *)productPrice:(SKProduct *)product;
- (NSString *)periodUnitWithProduct:(SKProduct *)product;
- (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString;
@end

@implementation Yd1UCenterManager

+ (instancetype)shared {
    return [Yodo1Base.shared cc_registerSharedInstance:self block:^{
        [Yd1UCenterManager.shared willInit];
    }];
}

- (void)dealloc {
    [RMStore.defaultStore removeStoreObserver:self];
}

- (void)willInit {
    YD1User* user = (YD1User*)[Yd1OpsTools.cached objectForKey:@"yd1User"];
    if (user) {
        self.user = user;
        Yd1UCenter.shared.itemInfo.uid = user.uid;
        Yd1UCenter.shared.itemInfo.ucuid = user.yid;
    }
    //设备登录
    __weak typeof(self) weakSelf = self;
    [Yd1UCenter.shared deviceLogin:^(YD1User * _Nullable user, NSError * _Nullable error) {
        weakSelf.user = user;
        if (user) {
            [Yd1OpsTools.cached setObject:user forKey:@"yd1User"];
        }
        if (user && !error) {
            weakSelf.isLogined = YES;
            Yd1UCenter.shared.itemInfo.uid = self.user.uid;
            Yd1UCenter.shared.itemInfo.ucuid = self.user.yid;
        }else{
            weakSelf.isLogined = NO;
            YD1LOG(@"%@",error.localizedDescription);
        }
    }];
    productInfos = [NSMutableDictionary dictionary];
    channelProductIds = [NSMutableArray array];
    NSString* pathName = @"Yodo1KeyConfig.bundle/Yodo1ProductInfo";
    NSString* path=[NSBundle.mainBundle pathForResource:pathName
                                                 ofType:@"plist"];
    NSDictionary* productInfo =[NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSAssert([productInfo count] > 0, @"Yodo1ProductInfo.plist 没有配置产品ID!");
    for (id key in productInfo){
        NSDictionary* item = [productInfo objectForKey:key];
        Product* product = [[Product alloc] initWithDict:item productId:key];
        [productInfos setObject:product forKey:key];
        [channelProductIds addObject:[item objectForKey:@"ChannelProductId"]];
    }
    
    persistence = [[RMStoreUserDefaultsPersistence alloc] init];
    RMStore.defaultStore.transactionPersistor = persistence;
    [RMStore.defaultStore addStoreObserver:self];
    
    [self requestProducts];
    
    /// 网络变化监测
    [Yodo1Reachability.reachability setNotifyBlock:^(Yodo1Reachability * _Nonnull reachability) {
        if (reachability.reachable) {
            [weakSelf requestProducts];
        }
    }];
}

- (void)requestProducts {
    /// 请求产品信息
    NSSet* productIds = [NSSet setWithArray:channelProductIds];
    [RMStore.defaultStore requestProducts:productIds];
}

- (void)paymentWithUniformProductId:(NSString *)uniformProductId callback:(nonnull PaymentCallback)callback {
    if (!RMStore.canMakePayments) {
        YD1LOG(@"This device is not able or allowed to make payments!");
        callback(uniformProductId,@"",@"",PaymentFail,@"This device is not able or allowed to make payments!");
        return;
    }
    __weak typeof(self) weakSelf = self;
    self.currentUniformProductId = uniformProductId;
    __block Product* product = [productInfos objectForKey:uniformProductId];
    SKProduct* skp = [RMStore.defaultStore productForIdentifier:product.channelProductId];
    if (!skp) {
        callback(product.uniformProductId,@"",@"",PaymentFail,@"products request failed with error Error");
        return;
    }
    //创建订单号
    [Yd1UCenter.shared generateOrderId:^(NSString * _Nullable orderId, NSError * _Nullable error) {
        if (!orderId || [orderId isEqualToString:@""]) {
            YD1LOG(@"%@",error.localizedDescription);
            callback(uniformProductId,@"",@"",PaymentFail,error.localizedDescription);
            return;
        }
        Yd1UCenter.shared.itemInfo.orderId = orderId;
        Yd1UCenter.shared.itemInfo.product_type = [NSString stringWithFormat:@"%d",product.productType];
        Yd1UCenter.shared.itemInfo.item_code = product.channelProductId;
        // 下单
        NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
        [parameters setObject:orderId forKey:@"orderId"];
        
        NSDictionary* productInfo = @{
            @"productId":product.channelProductId? :@"",
            @"productName":product.productName? :@"",
            @"productCount":@"1",
            @"productDescription":product.productDescription? :@"",
            @"currency":product.currency? :@"",
            @"productType":[NSString stringWithFormat:@"%d",product.productType]? :@"",
            @"price":product.productPrice? :@"",
            @"channelItemCode":@"",
        };
        
        [parameters setObject:productInfo forKey:@"product"];
        [parameters setObject:product.channelProductId? :@"" forKey:@"itemCode"];
        [parameters setObject:product.productPrice? :@"" forKey:@"orderMoney"];
        [parameters setObject:weakSelf.user.uid forKey:@"uid"];
        [parameters setObject:weakSelf.user.yid forKey:@"yid"];
        [parameters setObject:weakSelf.user.yid forKey:@"ucuid"];
        [parameters setObject:weakSelf.user.yid forKey:@"playerId"];
        [parameters setObject:Yd1OpsTools.appName forKey:@"gameName"];
        [parameters setObject:@"offline" forKey:@"gameType"];
        [parameters setObject:Yd1OpsTools.appVersion forKey:@"gameVersion"];
        [parameters setObject:@"" forKey:@"gameExtra"];
        [parameters setObject:@"" forKey:@"extra"];
        [parameters setObject:Yd1OpsTools.appVersion forKey:@"channelVersion"];
        
        [Yd1UCenter.shared createOrder:parameters
                              callback:^(int error_code, NSString * _Nonnull error) {
            if (error_code == 0) {
                YD1LOG(@"%@:下单成功",orderId);
                
                if (product.productType == Auto_Subscription) {
                    NSString* msg = [self localizedStringForKey:@"SubscriptionAlertMessage"
                                                    withDefault:@"确认启用后，您的iTunes账户将支付 %@ %@ 。%@自动续订此服务时您的iTunes账户也会支付相同费用。系统在订阅有效期结束前24小时会自动为您续订并扣费，除非您在有效期结束前取消服务。若需取消订阅，可前往设备设置-iTunes与App Store-查看Apple ID-订阅，管理或取消已经启用的服务。"];
                    NSString* message = [NSString stringWithFormat:msg,product.productPrice,product.currency,product.periodUnit];
                    
                    NSString* title = [self localizedStringForKey:@"SubscriptionAlertTitle" withDefault:@"确认启用订阅服务"];
                    NSString* cancelTitle = [self localizedStringForKey:@"SubscriptionAlertCancel" withDefault:@"取消"];
                    NSString* okTitle = [self localizedStringForKey:@"SubscriptionAlertOK" withDefault:@"启用"];
                    NSString* privateTitle = [self localizedStringForKey:@"SubscriptionAlertPrivate" withDefault:@"隐私协议"];
                    NSString* serviceTitle = [self localizedStringForKey:@"SubscriptionAlertService" withDefault:@"服务条款"];
                    UIAlertControllerStyle uiStyle = UIAlertControllerStyleActionSheet;
                    if([Yd1OpsTools isIPad]){
                        uiStyle = UIAlertControllerStyleAlert;
                    }
                    
                    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:uiStyle];
                    
                    NSString* privacyPolicyUrl = [self localizedStringForKey:@"SubscriptionPrivacyPolicyURL"
                                                                 withDefault:@"https://www.yodo1.com/cn/privacy_policy"];
                    NSString* termsServiceUrl = [self localizedStringForKey:@"SubscriptionTermsServiceURL"
                                                                withDefault:@"https://www.yodo1.com/cn/user_agreement"];
                    
                    UIAlertAction *privateAction = [UIAlertAction actionWithTitle:privateTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:privacyPolicyUrl]];
                        callback(product.uniformProductId,@"",@"",PaymentCannel,@"购买取消");
                    }];
                    UIAlertAction *serviceAction = [UIAlertAction actionWithTitle:serviceTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:termsServiceUrl]];
                        callback(product.uniformProductId,@"",@"",PaymentCannel,@"购买取消");
                    }];
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                        callback(product.uniformProductId,@"",@"",PaymentCannel,@"购买取消");
                    }];
                    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                        [self paymentProduct:product callback:callback];
                    }];
                    [alertController addAction:okAction];
                    [alertController addAction:serviceAction];
                    [alertController addAction:privateAction];
                    [alertController addAction:cancelAction];
                    [[[[UIApplication sharedApplication] keyWindow] rootViewController] presentViewController:alertController animated:YES completion:nil];
                } else {
                    [self paymentProduct:product callback:callback];
                }
            }else{
                YD1LOG(@"%@",error);
                callback(product.uniformProductId,@"",@"",PaymentFail,error);
            }
        }];
    }];
}

- (void)paymentProduct:(Product*)product callback:(PaymentCallback)callback {
    paymentCallback = [callback copy];
    [RMStore.defaultStore addPayment:product.channelProductId];
}

- (void)restorePayment:(RestoreCallback)callback {
    [RMStore.defaultStore restoreTransactionsOnSuccess:^(NSArray *transactions) {
        NSMutableArray* restore = [NSMutableArray array];
        for (SKPaymentTransaction *transaction in transactions) {
            Product* product = [self productWithChannelProductId:transaction.payment.productIdentifier];
            if (product) {
                BOOL isHave = false;
                for (Product* pro in restore) {
                    if ([pro.channelProductId isEqualToString:product.channelProductId]) {
                        isHave = true;
                        continue;
                    }
                }
                if (!isHave) {
                    [restore addObject:product];
                }
            }
        }
        NSArray* restoreProduct = [self productInfoWithProducts:restore];
        callback(restoreProduct,@"恢复购买成功");
    } failure:^(NSError *error) {
        callback(@[],error.localizedDescription);
    }];
}

- (NSArray *)productInfoWithProducts:(NSArray *)products {
    NSMutableArray* dicProducts = [NSMutableArray array];
    for (Product* product in products) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:product.uniformProductId == nil?@"":product.uniformProductId forKey:@"productId"];
        [dict setObject:product.channelProductId == nil?@"":product.channelProductId forKey:@"marketId"];
        [dict setObject:product.productName == nil?@"":product.productName forKey:@"productName"];
        
        SKProduct* skp = [RMStore.defaultStore productForIdentifier:product.channelProductId];
        NSString* price = nil;
        if (skp) {
            price = [self productPrice:skp];
        }else{
            price = product.productPrice;
        }
        
        NSString* priceDisplay = [NSString stringWithFormat:@"%@ %@",price,product.currency];
        [dict setObject:priceDisplay == nil?@"":priceDisplay forKey:@"priceDisplay"];
        [dict setObject:price == nil?@"":price forKey:@"price"];
        [dict setObject:product.productDescription == nil?@"":product.productDescription forKey:@"description"];
        [dict setObject:[NSNumber numberWithInt:product.productType] forKey:@"ProductType"];
        [dict setObject:product.currency == nil?@"":product.currency forKey:@"currency"];
        [dict setObject:[NSNumber numberWithInt:0] forKey:@"coin"];
        [dict setObject:product.periodUnit == nil?@"":[self periodUnitWithProduct:skp] forKey:@"periodUnit"];
        
        [dicProducts addObject:dict];
    }
    return dicProducts;
}

- (void)queryLossOrder:(LossOrderCallback)callback {
    NSMutableArray* restoreProduct = [NSMutableArray array];
    
    NSSet* productIdentifiers = [persistence purchasedProductIdentifiers];
    YD1LOG(@"%@",productIdentifiers);
    for (NSString* productIdentifier in productIdentifiers.allObjects) {
        NSArray* transactions = [persistence transactionsForProductOfIdentifier:productIdentifier];
        for (RMStoreTransaction* transaction in transactions) {
            if (transaction.consumed) {
                continue;
            }
            [restoreProduct addObject:transaction];
        }
    }
    if ([restoreProduct count] < 1) {
        callback(@[],@"no have loss order");
        return;
    }
    NSString* receipt = [[NSData dataWithContentsOfURL:RMStore.receiptURL] base64EncodedStringWithOptions:0];
    Yd1UCenter.shared.itemInfo.trx_receipt = receipt;
    __block NSMutableDictionary* lossOrder = [NSMutableDictionary dictionary];
    __block NSMutableArray* lossOrderProduct = [NSMutableArray array];
    __block int lossOrderCount = 0;
    __block int lossOrderReceiveCount = 0;
    __weak typeof(self) weakSelf = self;
    for (RMStoreTransaction* transaction in restoreProduct) {
        lossOrderCount++;
        Product* paymentProduct = [self productWithChannelProductId:transaction.productIdentifier];
        Yd1UCenter.shared.itemInfo.channelOrderid = transaction.transactionIdentifier;
        Yd1UCenter.shared.itemInfo.orderId = transaction.orderId;
        Yd1UCenter.shared.itemInfo.item_code = transaction.productIdentifier;
        Yd1UCenter.shared.itemInfo.product_type = [NSString stringWithFormat:@"%d",paymentProduct.productType];
        
        [Yd1UCenter.shared verifyAppStoreIAPOrder:Yd1UCenter.shared.itemInfo
                                         callback:^(BOOL verifySuccess, NSString * _Nonnull response, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (response && response.length > 0) {
                    NSDictionary* dic = [Yd1OpsTools JSONObjectWithString:response error:nil];
                    NSString* orderId = [dic objectForKey:@"orderid"];
                    NSString* itemCode = [dic objectForKey:@"item_code"];
                    int errorCode = [[dic objectForKey:@"error_code"]intValue];
                    if (verifySuccess) {
                        if (orderId && itemCode) {
                            [lossOrder setObject:itemCode forKey:orderId];
                            [self->persistence consumeProductOfIdentifier:itemCode];
                        }
                        NSLog(@"验证成功orderid:%@",orderId);
                    } else {
                        /// 移除
                        if (errorCode == 20 && itemCode) {
                            [self->persistence consumeProductOfIdentifier:itemCode];
                        }
                        NSLog(@"苹果收据验证失败OrderId:%@",orderId);
                    }
                }
                lossOrderReceiveCount++;
                if (lossOrderReceiveCount == lossOrderCount) {
                    if (callback) {
                        NSArray* orderIds = [lossOrder allValues];
                        for (NSString* itemCode in orderIds) {
                            Product* product = [weakSelf productWithChannelProductId:itemCode];
                            if (product) {
                                [lossOrderProduct addObject:product];
                            }
                        }
                        NSArray* dics = [weakSelf productInfoWithProducts:lossOrderProduct];
                        callback(dics,@"");
                    }
                }
            });
        }];
    }
}

- (void)querySubscriptions:(BOOL)excludeOldTransactions
                  callback:(QuerySubscriptionCallback)callback {
    
    NSMutableArray* result = [NSMutableArray array];
    Yd1UCenter.shared.itemInfo.exclude_old_transactions = excludeOldTransactions?@"true":@"false";
    NSString* receipt = [[NSData dataWithContentsOfURL:RMStore.receiptURL] base64EncodedStringWithOptions:0];
    Yd1UCenter.shared.itemInfo.trx_receipt = receipt;
    [Yd1UCenter.shared querySubscriptions:Yd1UCenter.shared.itemInfo
                                 callback:^(BOOL success, NSString * _Nullable response, NSError * _Nullable error) {
        if (success) {
            NSDictionary *responseDic = [Yd1OpsTools JSONObjectWithString:response error:nil];
            if(responseDic){
                NSDictionary* extra =[responseDic objectForKey:@"extra"];
                NSArray* latest_receipt_infos =[extra objectForKey:@"latest_receipt_info"];
                NSTimeInterval serverTime = [[responseDic objectForKey:@"timestamp"] doubleValue];
                
                for (int i = 0; i < [latest_receipt_infos count]; i++) {
                    NSDictionary* latest_receipt_info =[latest_receipt_infos objectAtIndex:i];
                    NSTimeInterval expires_date_ms = [[latest_receipt_info objectForKey:@"expires_date_ms"] doubleValue];
                    if(expires_date_ms == 0){
                        continue;
                    }
                    NSTimeInterval purchase_date_ms = [[latest_receipt_info objectForKey:@"purchase_date_ms"] doubleValue];
                    NSString* channelProductId = [latest_receipt_info objectForKey:@"product_id"];
                    NSString* uniformProductId = [[self productWithChannelProductId:channelProductId] uniformProductId];
                    SubscriptionInfo* info = [[SubscriptionInfo alloc] initWithUniformProductId:uniformProductId channelProductId:channelProductId expires:expires_date_ms purchaseDate:purchase_date_ms];
                    [result addObject:info];
                }
                callback(result, serverTime, YES, nil);
            }
        }else{
            callback(result, -1, NO, response);
        }
    }];
    
}

- (void)productWithUniformProductId:(NSString *)uniformProductId callback:(ProductsInfoCallback)callback {
    NSMutableArray* products = [NSMutableArray array];
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    Product* product = [productInfos objectForKey:uniformProductId];
    [dict setObject:product.uniformProductId == nil?@"":product.uniformProductId forKey:@"productId"];
    [dict setObject:product.channelProductId == nil?@"":product.channelProductId forKey:@"marketId"];
    [dict setObject:product.productName == nil?@"":product.productName forKey:@"productName"];
    SKProduct* skp = [RMStore.defaultStore productForIdentifier:product.channelProductId];
    NSString* price = nil;
    if (skp) {
        price = [skp.price stringValue];
        product.currency = [Yd1OpsTools currencyCode:skp.priceLocale];
        product.priceDisplay = [self diplayPrice:skp];
        product.periodUnit = [self periodUnitWithProduct:skp];
    }else{
        price = product.productPrice;
    }
    [dict setObject:product.priceDisplay == nil?@"":product.priceDisplay forKey:@"priceDisplay"];
    [dict setObject:price == nil?@"":price forKey:@"price"];
    [dict setObject:product.productDescription == nil?@"":product.productDescription forKey:@"description"];
    [dict setObject:[NSNumber numberWithInt:product.productType] forKey:@"ProductType"];
    [dict setObject:product.currency == nil?@"":product.currency forKey:@"currency"];
    [dict setObject:[NSNumber numberWithInt:0] forKey:@"coin"];
    [products addObject:dict];
    if (callback) {
        callback(products);
    }else{
        NSAssert(callback != nil, @"ProductsInfoCallback of callback not set!");
    }
}

- (void)products:(ProductsInfoCallback)callback {
    NSMutableArray* products = [NSMutableArray array];
    NSArray* allProduct = [productInfos allValues];
    for (Product *product in allProduct) {
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        [dict setObject:product.uniformProductId == nil?@"":product.uniformProductId forKey:@"productId"];
        [dict setObject:product.channelProductId == nil?@"":product.channelProductId forKey:@"marketId"];
        [dict setObject:product.productName == nil?@"":product.productName forKey:@"productName"];
        
        SKProduct* skp = [RMStore.defaultStore productForIdentifier:product.channelProductId];
        NSString* price = nil;
        if (skp) {
            price = [skp.price stringValue];
            product.currency = [Yd1OpsTools currencyCode:skp.priceLocale];
            product.priceDisplay = [self diplayPrice:skp];
            product.periodUnit = [self periodUnitWithProduct:skp];
        }else{
            price = product.productPrice;
        }
        
        [dict setObject:product.priceDisplay == nil?@"":product.priceDisplay forKey:@"priceDisplay"];
        [dict setObject:price == nil?@"":price forKey:@"price"];
        [dict setObject:product.productDescription == nil?@"":product.productDescription forKey:@"description"];
        [dict setObject:[NSNumber numberWithInt:product.productType] forKey:@"ProductType"];
        [dict setObject:product.currency == nil?@"":product.currency forKey:@"currency"];
        [dict setObject:[NSNumber numberWithInt:0] forKey:@"coin"];
        
        [products addObject:dict];
    }
    if (callback) {
        callback(products);
    }else{
        NSAssert(callback != nil, @"ProductsInfoCallback of callback not set!");
    }
}

#pragma mark- 促销活动

- (void)fetchStorePromotionOrder:(FetchStorePromotionOrderCallback)callback {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        [[SKProductStorePromotionController defaultController] fetchStorePromotionOrderWithCompletionHandler:^(NSArray<SKProduct *> * _Nonnull storePromotionOrder, NSError * _Nullable error) {
            if(callback){
                NSMutableArray<NSString*>* uniformProductIDs = [[NSMutableArray alloc] init];
                for (int i = 0; i < [storePromotionOrder count]; i++) {
                    NSString* productID = [[storePromotionOrder objectAtIndex:i] productIdentifier];
                    NSString* uniformProductID = [[self productWithChannelProductId:productID] uniformProductId];
                    [uniformProductIDs addObject:uniformProductID];
                }
                callback(uniformProductIDs, error == nil, [error description]);
            }
        }];
    } else {
        
    }
#endif
}

- (void)fetchStorePromotionVisibilityForProduct:(NSString *)uniformProductId callback:(FetchStorePromotionVisibilityCallback)callback {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        NSString* channelProductId = [[productInfos objectForKey:uniformProductId] channelProductId];
        [[SKProductStorePromotionController defaultController] fetchStorePromotionVisibilityForProduct:[RMStore.defaultStore productForIdentifier:channelProductId] completionHandler:^(SKProductStorePromotionVisibility storePromotionVisibility, NSError * _Nullable error) {
            if(callback){
                PromotionVisibility result = Default;
                switch (storePromotionVisibility) {
                    case SKProductStorePromotionVisibilityShow:
                        result = Visible;
                        break;
                    case SKProductStorePromotionVisibilityHide:
                        result = Hide;
                        break;
                    default:
                        break;
                }
                callback(result, error == nil, [error description]);
            }
        }];
    } else {
    }
#endif
}

- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray
                         callback:(nonnull UpdateStorePromotionOrderCallback)callback {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        NSMutableArray<SKProduct *> *productsArray = [[NSMutableArray alloc] init];
        for (NSString* uniformProductId in uniformProductIdArray) {
            NSString* channelProductId = [[productInfos objectForKey:uniformProductId] channelProductId];
            [productsArray addObject:[RMStore.defaultStore productForIdentifier:channelProductId]];
        }
        [[SKProductStorePromotionController defaultController] updateStorePromotionOrder:productsArray completionHandler:^(NSError * _Nullable error) {
            callback(error == nil, [error description]);
        }];
    } else {
        
    }
#endif
}

- (void)updateStorePromotionVisibility:(BOOL)visibility
                               product:(NSString *)uniformProductId
                              callback:(UpdateStorePromotionVisibilityCallback)callback {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        NSString* channelProductId = [[productInfos objectForKey:uniformProductId] channelProductId];
        SKProduct* product = [RMStore.defaultStore productForIdentifier:channelProductId];
        [[SKProductStorePromotionController defaultController] updateStorePromotionVisibility:visibility ? SKProductStorePromotionVisibilityShow : SKProductStorePromotionVisibilityHide forProduct:product completionHandler:^(NSError * _Nullable error) {
            callback(error == nil, [error description]);
        }];
    } else {
    }
#endif
}

- (void)readyToContinuePurchaseFromPromot {
#ifdef __IPHONE_11_0
    if (@available(iOS 11.0, *)) {
        if(self.addedStorePayment){
            [[SKPaymentQueue defaultQueue] addPayment:self.addedStorePayment];
        }
    }else{
        
    }
#endif
}

- (void)cancelPromotion {
    self.addedStorePayment = nil;
}

- (Product*)promotionProduct {
    if (self.addedStorePayment) {
        NSString* uniformProductId = [[self productWithChannelProductId:self.addedStorePayment.productIdentifier] uniformProductId];
        Product* product = [productInfos objectForKey:uniformProductId];
        return product;
    }
    return nil;
}

- (Product*)productWithChannelProductId:(NSString*)channelProductId {
    NSArray* allProduct = [productInfos allValues];
    for (Product *productInfo in allProduct) {
        if ([productInfo.channelProductId isEqualToString:channelProductId]) {
            return productInfo;
        }
    }
    return nil;
}

- (void)updateProductInfo:(NSArray *)products {
    for (NSString* uniformProductId in [productInfos allKeys]) {
        Product* product = [productInfos objectForKey:uniformProductId];
        for (SKProduct* sk in products) {
            if ([sk.productIdentifier isEqualToString:product.channelProductId]) {
                product.productName = sk.localizedTitle;
                product.channelProductId = sk.productIdentifier;
                product.productPrice = [sk.price stringValue];
                product.productDescription = sk.localizedDescription;
                product.currency = [Yd1OpsTools currencyCode:sk.priceLocale];
                product.priceDisplay = [self diplayPrice:sk];
                product.periodUnit = [self periodUnitWithProduct:sk];
            }
        }
    }
}

- (NSString *)diplayPrice:(SKProduct *)product {
    return [NSString stringWithFormat:@"%@ %@",[self productPrice:product],[Yd1OpsTools currencyCode:product.priceLocale]];
}

- (NSString *)productPrice:(SKProduct *)product {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setLocale:product.priceLocale];
    [numberFormatter setCurrencySymbol:@""];
    NSString *formattedPrice = [numberFormatter stringFromNumber:product.price];
    return formattedPrice;
}

- (NSString*)periodUnitWithProduct:(SKProduct*)product {
    if (@available(iOS 11.2, *)) {
        NSString* unit = @"";
        int numberOfUnits = (int)product.subscriptionPeriod.numberOfUnits;
        switch (product.subscriptionPeriod.unit)
        {
            case SKProductPeriodUnitDay:
            {
                if (numberOfUnits == 7) {
                    unit = [self localizedStringForKey:@"SubscriptionWeek" withDefault:@"每周"];
                }else if (numberOfUnits == 30){
                    unit = [self localizedStringForKey:@"SubscriptionMonth" withDefault:@"每月"];
                } else {
                    unit = [NSString stringWithFormat:[self localizedStringForKey:@"SubscriptionDay" withDefault:@"每%d天"],numberOfUnits];
                }
            }
                break;
            case SKProductPeriodUnitWeek:
            {
                if (numberOfUnits == 1) {
                    unit = [self localizedStringForKey:@"SubscriptionWeek" withDefault:@"每周"];
                } else {
                    unit = [NSString stringWithFormat:[self localizedStringForKey:@"SubscriptionWeeks" withDefault:@"每%d周"],numberOfUnits];
                }
            }
                break;
            case SKProductPeriodUnitMonth:
            {
                if (numberOfUnits == 1) {
                    unit = [self localizedStringForKey:@"SubscriptionMonth" withDefault:@"每月"];
                } else {
                    unit = [NSString stringWithFormat:[self localizedStringForKey:@"SubscriptionMonths" withDefault:@"每%d个月"],numberOfUnits];
                }
            }
                break;
            case SKProductPeriodUnitYear:
            {
                if (numberOfUnits == 1) {
                    unit = [self localizedStringForKey:@"SubscriptionYear" withDefault:@"每年"];
                } else {
                    unit = [NSString stringWithFormat:[self localizedStringForKey:@"SubscriptionYears" withDefault:@"每%d年"],numberOfUnits];
                }
            }
                break;
        }
        return unit;
    } else {
        return @"";
    }
    return @"";
}

- (NSString *)localizedStringForKey:(NSString *)key withDefault:(NSString *)defaultString {
    return [Yd1OpsTools localizedString:@"Yodo1SDKStrings"
                                    key:key
                          defaultString:defaultString];
}

#pragma mark- RMStoreObserver
- (void)storePaymentTransactionDeferred:(NSNotification*)notification {
    YD1LOG(@"");
}

- (void)storePaymentTransactionFailed:(NSNotification*)notification {
    YD1LOG(@"");
    if (paymentCallback) {
        NSString* channelOrderid = notification.rm_transaction.transactionIdentifier;
        if (!channelOrderid) {
            channelOrderid = @"";
        }
        paymentCallback(self.currentUniformProductId,@"",channelOrderid,PaymentFail,notification.rm_storeError.localizedDescription);
    }
}

- (void)storePaymentTransactionFinished:(NSNotification*)notification {
    
    if (!Yd1UCenter.shared.itemInfo.product_type || !Yd1UCenter.shared.itemInfo.orderId) {
        [SKPaymentQueue.defaultQueue finishTransaction:notification.rm_transaction];
        return;
    }
    NSString* channelOrderid = notification.rm_transaction.transactionIdentifier;
    if (!channelOrderid) {
        channelOrderid = @"";
    }
    Yd1UCenter.shared.itemInfo.channelOrderid = notification.rm_transaction.transactionIdentifier;
    NSString* receipt = [[NSData dataWithContentsOfURL:RMStore.receiptURL] base64EncodedStringWithOptions:0];
    Yd1UCenter.shared.itemInfo.trx_receipt = receipt;
    
    [Yd1UCenter.shared verifyAppStoreIAPOrder:Yd1UCenter.shared.itemInfo
                                     callback:^(BOOL verifySuccess, NSString * _Nonnull response, NSError * _Nonnull error) {
        NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
        NSString* orderId = @"";
        if (respo) {
            orderId = [respo objectForKey:@"orderid"];
        }
        if (verifySuccess) {
            if (self->paymentCallback) {
                self->paymentCallback(self.currentUniformProductId,orderId,channelOrderid,PaymentSuccess,response);
            }
            
            [self->persistence consumeProductOfIdentifier:notification.rm_productIdentifier];
        } else {
            if (self->paymentCallback) {
                self->paymentCallback(self.currentUniformProductId,orderId,channelOrderid,PaymentFail,response);
            }
        }
    }];
}

- (void)storeProductsRequestFailed:(NSNotification*)notification {
    YD1LOG(@"%@",notification.rm_storeError);
}

- (void)storeProductsRequestFinished:(NSNotification*)notification {
    YD1LOG(@"");
    NSArray *products = notification.rm_products;
    [self updateProductInfo:products];
}

- (void)storeRefreshReceiptFailed:(NSNotification*)notification {
    YD1LOG(@"");
}

- (void)storeRefreshReceiptFinished:(NSNotification*)notification {
    YD1LOG(@"");
}

- (void)storeRestoreTransactionsFailed:(NSNotification*)notification {
    YD1LOG(@"");
}

- (void)storeRestoreTransactionsFinished:(NSNotification*)notification {
    YD1LOG(@"");
}

- (void)storePromotionPaymentFinished:(NSNotification *)notification {
    YD1LOG(@"");
    self.addedStorePayment = notification.rm_payment;
}

@end
