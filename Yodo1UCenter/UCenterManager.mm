//
//  Yodo1NetGameManager.m
//  NetGameSDK_Sample
//
//  Created by yodo1 on 14-5-20.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

#import "UCenterManager.h"
#import "Yodo1Commons.h"
#import "Yodo1UnityTool.h"
#import "Yodo1Registry.h"
#import "Yodo1ClassWrapper.h"
#import "UCSNS.h"
#import "SubscriptionInfo.h"
#import "Yodo1Adapter.h"
#import "Reachability.h"
#import "Yodo1KeyInfo.h"

#define YODO1_REALEASE(obj) \
if (obj) {              \
[obj release];      \
obj = nil;          \
}


#define YODO1_UC_SINA_APPID            @"SinaAppId"
#define YODO1_UC_SINA_CALLBACK_URL     @"SinaCallbackUrl"
#define YODO1_UC_QQ_APPID              @"QQAppId"

@implementation ProductInfo
@synthesize uniformProductId;
@synthesize channelProductId;
@synthesize productName;
@synthesize productPrice;
@synthesize priceDisplay;
@synthesize productDescription;
@synthesize currency;
@synthesize productType;

- (void)dealloc
{
    [self.uniformProductId release];
    [self.channelProductId release];
    [self.productName release];
    [self.productPrice release];
    [self.productDescription release];
    [self.currency release];
    [super dealloc];
}

@end

@interface UCenterManager () {
    BOOL bCompletionInit;
}

@property (nonatomic, assign) LoginType currentType;
@property (nonatomic, assign) UCenterUserType currentUserType;

+ (BOOL)checkNetwork:(id<UIAlertViewDelegate>)delegate;

@end

@implementation UCenterManager
@synthesize currentType;
@synthesize currentUserType;
@synthesize appKey;
@synthesize yodo1UCUid;
@synthesize yodo1UCUserName;
@synthesize gameUserId;
@synthesize gameNickname;
@synthesize channelId;
@synthesize deviceId;
@synthesize gameRegionCode;
@synthesize extra;
@synthesize registerCompletionBlock;
@synthesize loginWithChannelUserBindCompletionBlock;
@synthesize loginWithChannelUserCompletionBlock;
@synthesize loginWithChannelUserDeviceIdCompletionBlock;
@synthesize loginWithUsernameCompletionBlock;
@synthesize deviceUserConvertCompletionBlock;
@synthesize deviceUserConvertToSNSUserCompletionBlock;
@synthesize currentAdapter;
@synthesize snsLoginCompletionBlock;
@synthesize bLogined;
@synthesize paymentCompletionBlock;
@synthesize lossOrderCompletionBlock;
@synthesize loginOutCompletionBlock;
@synthesize changeIdBlock;
@synthesize transferIdBlock;
@synthesize fetchStorePromotionOrderCompletionBlock;
@synthesize fetchStorePromotionVisibilityCompletionBlock;
@synthesize querySubscriptionBlock;
@synthesize updateStorePromotionOrderCompletionBlock;
@synthesize updateStorePromotionVisibilityCompletionBlock;

static UCenterManager* _instance = nil;
+ (UCenterManager*)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[UCenterManager alloc]init];
    });
    return _instance;
}

+ (BOOL)checkNetwork:(id<UIAlertViewDelegate>)delegate {
    Reachability* reachable = [Reachability reachabilityForInternetConnection];
    int currentStatus = [reachable currentReachabilityStatus];
    if (currentStatus == NotReachable) {
        if (delegate) {
            UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:@"对不起，您的网络连接不可用！"
                                                           delegate:nil cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil, nil];
            [alert setTag:65536];
            [alert setDelegate:delegate];
            [alert show];
        }
        return NO;
    }
    return YES;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.bLogined = NO;
        Class adapter = [[[Yodo1Registry sharedRegistry] adapterClassFor:LoginTypeAppStore
                                                               classType:@"platformType"] theYodo1Class];
        
        self.currentAdapter = [[adapter alloc] initWithType:LoginTypeAppStore orientation:UIInterfaceOrientationLandscapeLeft];
    }
    return self;
}

- (void)dealloc
{
    YODO1_REALEASE(self.registerCompletionBlock);
    YODO1_REALEASE(self.loginWithChannelUserBindCompletionBlock);
    YODO1_REALEASE(self.loginWithChannelUserCompletionBlock);
    YODO1_REALEASE(self.loginWithChannelUserDeviceIdCompletionBlock);
    YODO1_REALEASE(self.loginWithUsernameCompletionBlock);
    YODO1_REALEASE(self.deviceUserConvertCompletionBlock);
    YODO1_REALEASE(self.deviceUserConvertToSNSUserCompletionBlock);
    YODO1_REALEASE(self.snsLoginCompletionBlock);
    YODO1_REALEASE(self.paymentCompletionBlock);
    YODO1_REALEASE(self.lossOrderCompletionBlock);
    YODO1_REALEASE(self.loginOutCompletionBlock);
    YODO1_REALEASE(self.changeIdBlock);
    YODO1_REALEASE(self.transferIdBlock);
    YODO1_REALEASE(self.yodo1UCUid);
    YODO1_REALEASE(self.yodo1UCUserName);
    YODO1_REALEASE(self.gameUserId);
    YODO1_REALEASE(self.gameNickname);
    YODO1_REALEASE(self.fetchStorePromotionVisibilityCompletionBlock);
    YODO1_REALEASE(self.fetchStorePromotionOrderCompletionBlock);
    YODO1_REALEASE(self.querySubscriptionBlock);
    YODO1_REALEASE(self.updateStorePromotionOrderCompletionBlock);
    YODO1_REALEASE(self.updateStorePromotionVisibilityCompletionBlock);

    [super dealloc];
}

- (BOOL)isUCAuthorzie
{
    return [UCSNS sharedInstance].isUCAuthorzie;
}

- (void)setLogEnabled:(BOOL)enable
{
    [Yodo1Membership setLogEnabled:enable];
    [[Yodo1OGPayment sharedInstance] setYodo1LogEnabled:enable];
}

- (void)setAPIEnvironment:(UCenterEnvironment)env
{
    [Yodo1Membership setAPIEnvironment:(Yodo1MembershipAPIEnvironment)env];
    [[Yodo1OGPayment sharedInstance] setYodo1APIEnvironment:(Yodo1OGPaymentAPIEnvironment)env];
}

#pragma mark UCenter登录

- (void)regionList:(NSString*)channelCode
         gameAppkey:(NSString*)gameAppkey
    regionGroupCode:(NSString*)regionGroupCode
        environment:(UCenterEnvironment)env
           callback:(RegionListUCenterCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSLog(@"没有网络");
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, nil, error);
        return;
    }
    
    [Yodo1Membership setAPIEnvironment:(Yodo1MembershipAPIEnvironment)env];
    [[Yodo1OGPayment sharedInstance] setYodo1APIEnvironment:(Yodo1OGPaymentAPIEnvironment)env];

    [Yodo1Membership regionList:channelCode
                     gameAppkey:gameAppkey
                regionGroupCode:regionGroupCode
                       callback:^(bool success, NSError* error, NSString* response) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                           if (success) {
                               NSDictionary* dic = (NSDictionary*)[Yodo1Commons JSONObjectWithString:response error:nil];
                               NSArray* regionList = [[dic objectForKey:@"data"] objectForKey:@"region_list"];
                               callback(YES,regionList,nil);
                           }else{
                               callback(NO,nil,error);
                           }
                        });
                       }];
}

- (void)getUpdateInfoWithAppKey:(NSString *)gameAppkey
                    channelCode:(NSString *)channelCode
                       callback:(GetUpdateInfoUCenterCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSLog(@"没有网络");
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, error, nil);
        return;
    }
    [Yodo1Membership getUpdateInfoWithAppKey:gameAppkey channelCode:channelCode callback:^(bool success, NSError *error, NSString *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            callback(success,error,response);
        });
    }];
}

- (void)registUsername:(NSString*)username_
                   pwd:(NSString*)pwd_
              callback:(RegisterUCenterWithUsernameCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, nil, error, nil);
        return;
    }
    self.registerCompletionBlock = callback;
    [Yodo1Membership registerWithUsername:username_ password:pwd_ appKey:self.appKey channelId:self.channelId gameRegion:self.gameRegionCode callback:^(BOOL success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
         dispatch_async(dispatch_get_main_queue(), ^{
             if (success) {
                 self.yodo1UCUserName = username_;
                 self.currentUserType = UCenterUserTypeNormal;
                 self.bLogined = YES;
             }
             self.registerCompletionBlock(success,authorization, error,response);
         });
    }];
}

- (void)login:(UCenterUserType)usertype
     username:(NSString*)username_
          pwd:(NSString*)pwd_
     callback:(LoginUCenterWithUsernameCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(UCenterLoginFail, nil, error, nil);
        return;
    }
    if (usertype == UCenterUserTypeSNS) {
        NSAssert([[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_QQ_APPID] != nil, @"sns 登录,没有设置qqAppId");
        [UCSNS sharedInstance].qqAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_QQ_APPID];
        NSAssert([[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_SINA_APPID] != nil, @"sns 登录,没有设置sinaAppId");
        [UCSNS sharedInstance].sinaAppId = [[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_SINA_APPID];
        NSAssert([[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_SINA_CALLBACK_URL] != nil, @"sns 登录,没有设置sinaCallbackUrl");
        [UCSNS sharedInstance].sinaCallbackUrl = [[Yodo1KeyInfo shareInstance]configInfoForKey:YODO1_UC_SINA_CALLBACK_URL];
    }

    self.loginWithUsernameCompletionBlock = callback;
    self.yodo1UCUserName = username_;
    self.currentUserType = usertype;

    if (self.currentType == LoginTypeAppStore) {
        if (usertype == UCenterUserTypeNormal) {
            [Yodo1Membership loginWithUsername:username_ password:pwd_ appKey:self.appKey channelId:self.channelId gameRegion:self.gameRegionCode callback:^(BOOL success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.bLogined = success;
                    if (success) {
                        self.yodo1UCUid = authorization.userId;
                        self.loginWithUsernameCompletionBlock(UCenterLoginSuccess,authorization,error,response);
                    }else{
                        self.loginWithUsernameCompletionBlock(UCenterLoginFail,authorization,error,response);
                    }
                });
            }];
        }
        else if (usertype == UCenterUserTypeDevice) {
            self.deviceId = username_;
            [Yodo1Membership loginWithDeviceId:username_ appkey:self.appKey channelId:self.channelId gameRegionCode:self.gameRegionCode callback:^(BOOL success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.bLogined = success;
                    if (success) {
                        self.yodo1UCUid = authorization.userId;
                        self.loginWithUsernameCompletionBlock(UCenterLoginSuccess,authorization,error,response);
                    }else{
                        self.loginWithUsernameCompletionBlock(UCenterLoginFail,authorization,error,response);
                    }
                });
            }];
        }
        else if (usertype == UCenterUserTypeSNS) {
            [Yodo1Membership loginWithSNS:username_ appkey:self.appKey channelId:self.channelId gameRegionCode:self.gameRegionCode callback:^(BOOL success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.bLogined = success;
                    if (success) {
                        self.yodo1UCUid = authorization.userId;
                        self.loginWithUsernameCompletionBlock(UCenterLoginSuccess,authorization,error,response);
                    }else{
                        self.loginWithUsernameCompletionBlock(UCenterLoginFail,authorization,error,response);
                    }
                });
            }];
        }
    }
    else {
        [self.currentAdapter login:^(UCenterLoginState result, NSString* message) {
            if (result == UCenterLoginSuccess) {
                [Yodo1Membership loginWithChannelUser:[self.currentAdapter channelUserId]
                                            userToken:[self.currentAdapter channelSessionId]
                                          reservedArg:@""
                                               appKey:self.appKey
                                            channelId:self.channelId
                                           gameRegion:self.gameRegionCode
                                             callback:^(BOOL success, Yodo1MembershipAuthorization *authorization, NSError *error, NSString *response)
                {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         self.bLogined = success;
                         if (success) {
                             self.yodo1UCUid = authorization.userId;
                             self.loginWithUsernameCompletionBlock(UCenterLoginSuccess,authorization,error,response);
                         }else{
                             self.loginWithUsernameCompletionBlock(UCenterLoginFail,authorization,error,response);
                         }
                     });
                   
                }];
            }else {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     self.loginWithUsernameCompletionBlock(result,nil,nil,message);
                 });
            }
        }];
    }
}

- (void)converDeviceToNormal:(NSString*)username
                         pwd:(NSString*)pwd
                    callback:(UCenterDeviceUserConvertCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, error, nil);
        return;
    }
   
    self.deviceUserConvertCompletionBlock = callback;
    if (self.bLogined && self.deviceId) {
        [Yodo1Membership convertDeviceUserToFormalUser:self.deviceId userId:self.yodo1UCUid username:username password:pwd appkey:self.appKey channelId:self.channelId gameRegionCode:self.gameRegionCode callback:^(BOOL success, NSError* error, NSString* response) {
            dispatch_async(dispatch_get_main_queue(), ^{
               self.deviceUserConvertCompletionBlock(success,error,response);
            });
        }];
    }
}

- (void)replaceContentOfUserId:(NSString*)replacedUserId
                      deviceId:(NSString*)deviceId_
                      callback:(UCenterChangeIdCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, error, nil);
        return;
    }
    self.changeIdBlock = callback;
    [Yodo1Membership replaceContentOfUserId:replacedUserId deviceId:deviceId_ appkey:self.appKey callback:^(BOOL success, NSError* error, NSString* response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.changeIdBlock(success,error,response);
        });
    }];
}

- (void)transferWithDeviceUserId:(NSString*)transferUserId
                        deviceId:(NSString*)deviceId_
                        callback:(UCenterChangeIdCallback)callback
{
    if (![UCenterManager checkNetwork:nil] && callback) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.sdk" code:-1 userInfo:@{ NSLocalizedDescriptionKey : @"没有连接网络" }];
        callback(NO, error, nil);
        return;
    }
    self.transferIdBlock = callback;
    [Yodo1Membership transferWithDeviceUserId:transferUserId deviceId:deviceId_ appkey:self.appKey callback:^(BOOL success, NSError* error, NSString* response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.transferIdBlock(success,error,response);
        });
    }];
}

+ (void)setUCenterLoginOutCallback:(LoginOutUCenterCompletionBlock)callback
{
    [UCenterManager sharedInstance].loginOutCompletionBlock = callback;
}

- (void)loginOut
{
    if (!self.currentAdapter) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"没有登录!"
                                                       delegate:nil
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil, nil];
        [alert show];
        [alert release];
        return;
    }
    if ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0) {
        return;
    }
    if ([self.currentAdapter isLogined]) {
        [self.currentAdapter loginOut];
        if (self.currentUserType == UCenterUserTypeSNS) {
            [UCSNS clearAuthorize:self.yodo1UCUserName];
        }
        self.bLogined = NO;
        self.gameUserId = nil;
        self.gameNickname = nil;
        self.yodo1UCUserName = nil;
    }
}

#pragma mark - Payment

+ (void)setPaymentCallback:(PaymentCompletionBlock)callback
{
    [UCenterManager sharedInstance].paymentCompletionBlock = callback;
}

- (void)gameUserId:(NSString*)mGameUserId
{
    self.gameUserId = mGameUserId;
}

- (void)gameNickname:(NSString*)mGameNickname
{
    self.gameNickname = mGameNickname;
}


- (void)paymentWithProductId:(NSString*)uniformProductId
                       extra:(NSString*)extra_
{
    if (![UCenterManager checkNetwork:nil] && [UCenterManager sharedInstance].paymentCompletionBlock) {
        [UCenterManager sharedInstance].paymentCompletionBlock(uniformProductId, PaymentFail, @"没有连接网络！", extra_);
        return;
    }

    self.extra = extra_;
    [self.currentAdapter paymentWithProductId:uniformProductId];
}

+ (void)setQuerySubscriptionBlock:(QuerySubscriptionBlock)callback
{
    [UCenterManager sharedInstance].querySubscriptionBlock = callback;
}

+ (void)setLossOrderCallback:(LossOrderCompletionBlock)callback
{
    [UCenterManager sharedInstance].lossOrderCompletionBlock = callback;
}

- (void)fetchStorePromotionOrder {
    [self.currentAdapter fetchStorePromotionOrder];
}

+ (void)setFetchStorePromotionOrderCallback:(FetchStorePromotionOrderCompletionBlock)callback{
    [UCenterManager sharedInstance].fetchStorePromotionOrderCompletionBlock = callback;
}

- (void)fetchStorePromotionVisibilityForProduct:(NSString*)uniformProductId{
    [self.currentAdapter fetchStorePromotionVisibilityForProduct:uniformProductId];
}

+ (void)setFetchStorePromotionVisibilityCallback:(FetchStorePromotionVisibilityCompletionBlock)callback{
    [UCenterManager sharedInstance].fetchStorePromotionVisibilityCompletionBlock = callback;
}

- (void)updateStorePromotionOrder:(NSArray<NSString *> *)uniformProductIdArray {
    [self.currentAdapter updateStorePromotionOrder:uniformProductIdArray];
}

+ (void)setUpdateStorePromotionOrderCompletionBlock:(UpdateStorePromotionOrderCompletionBlock )callback{
    [UCenterManager sharedInstance].updateStorePromotionOrderCompletionBlock = callback;
}

- (void)updateStorePromotionVisibility:(BOOL)visibility Product:(NSString*)uniformProductId {
    [self.currentAdapter updateStorePromotionVisibility:visibility Product:uniformProductId];
}

+ (void)setUpdateStorePromotionVisibilityCompletionBlock:(UpdateStorePromotionVisibilityCompletionBlock )callback{
    [UCenterManager sharedInstance].updateStorePromotionVisibilityCompletionBlock = callback;
}

- (void)ReadyToContinuePurchaseFromPromot{
    [self.currentAdapter ReadyToContinuePurchaseFromPromot];
}

- (AppStoreProduct*)GetPromotionProduct{
    return [self.currentAdapter GetPromotionProduct];
}

- (void)CancelPromotion{
    [self.currentAdapter CancelPromotion];
}

- (void)querySubscriptions:(BOOL)excludeOldTransactions{
    if (![UCenterManager checkNetwork:nil] && [UCenterManager sharedInstance].querySubscriptionBlock) {
        [UCenterManager sharedInstance].querySubscriptionBlock(nil, -1, NO, @"没有连接网络，无法查询漏单");
        return;
    }
    [self.currentAdapter querySubscriptions:excludeOldTransactions];
}

- (void)queryLossOrder
{
    if (![UCenterManager checkNetwork:nil] && [UCenterManager sharedInstance].lossOrderCompletionBlock) {
        [UCenterManager sharedInstance].lossOrderCompletionBlock(nil, NO, LossOrderTypeLossOrder, @"没有连接网络，无法查询漏单");
        return;
    }
    [self.currentAdapter queryLossOrder];
}

- (void)restorePayment
{
    if (![UCenterManager checkNetwork:nil] && [UCenterManager sharedInstance].lossOrderCompletionBlock) {
        [UCenterManager sharedInstance].lossOrderCompletionBlock(nil, NO, LossOrderTypeRestore, @"没有连接网络，无法恢复购买");
        return;
    }
    [self.currentAdapter restorePayment];
}

- (void)productInfoWithProductId:(NSString*)uniformProductId
                        callback:(ProductInfoCompletionBlock)callback
{
    [self.currentAdapter productInfoWithProductId:uniformProductId callback:callback];
}

- (void)productsInfo:(ProductsInfoCompletionBlock)callback
{
    [self.currentAdapter productsInfo:callback];
}

- (void)handleOpenURL:(NSURL*)url
    sourceApplication:(NSString*)sourceApplication
{
    if (self.currentAdapter) {
        [self.currentAdapter handleOpenURL:url sourceApplication:sourceApplication];
    }
}

#pragma mark -   Unity3d 接口

#ifdef __cplusplus

extern "C" {

/**
 *设置ops 环境
 */
void UnityAPIEnvironment(int env)
{
    [[UCenterManager sharedInstance] setAPIEnvironment:(UCenterEnvironment)env];
}

/**
 *设置是否显示log
 */
void UnityLogEnabled(BOOL enable)
{
    [[UCenterManager sharedInstance] setLogEnabled:enable];
}

void UnityGameUserId(const char* gameUserId)
{
    NSString* ocGameUserId = Yodo1CreateNSString(gameUserId);
    [[UCenterManager sharedInstance]gameUserId:ocGameUserId];
}

void UnityGameNickname(const char* gameNickname)
{
    NSString* ocGameNickname = Yodo1CreateNSString(gameNickname);
    [[UCenterManager sharedInstance]gameUserId:ocGameNickname];
}

/*
     获取在线分区列表
     */
void UnityRegionList(const char* channelCode, const char* gameAppkey, const char* regionGroupCode, int env, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _channelCode = Yodo1CreateNSString(channelCode);
    NSString* _gameAppkey = Yodo1CreateNSString(gameAppkey);
    NSString* _regionGroupCode = Yodo1CreateNSString(regionGroupCode);

    [[UCenterManager sharedInstance] regionList:_channelCode gameAppkey:_gameAppkey regionGroupCode:_regionGroupCode environment:(UCenterEnvironment)env callback:^(BOOL success, NSArray* regionList, NSError* error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                    if (regionList && [regionList count]>0){
                        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"result"];
                        [dict setObject:regionList forKey:@"regionList"];
                    }else{
                        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"result"];
                        [dict setObject:@"" forKey:@"msg"];
                    }
                    NSError* parseJSONError = nil;
                    NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                    if(parseJSONError){
                        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"result"];
                        [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                        msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                    }
                    UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                     [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            });
    }];
}
    
/**
 *获取版本更新信息
 */
void UnityGetUpdateInfoWithAppKey(const char*gameAppkey,const char* channelCode,const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    NSString* _gameAppkey = Yodo1CreateNSString(gameAppkey);
    NSString* _channelCode = Yodo1CreateNSString(channelCode);
    [[UCenterManager sharedInstance] getUpdateInfoWithAppKey:_gameAppkey channelCode:_channelCode callback:^(BOOL success, NSError *error, NSString *response) {
      dispatch_async(dispatch_get_main_queue(), ^{
          if(ocGameObjName && ocMethodName){
              NSMutableDictionary* dict = [NSMutableDictionary dictionary];
              if(success){
                  [dict setObject:[NSNumber numberWithInt:1] forKey:@"result"];
                  [dict setObject:(response == nil?@"":response) forKey:@"response"];
              }else{
                  [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                  [dict setObject:(response == nil?@"":response) forKey:@"response"];
                  if(error){
                      [dict setObject:[NSString stringWithFormat:@"%d",(int)[error code]] forKey:@"errorCode"];
                      [dict setObject:[NSString stringWithFormat:@"%@",[error localizedDescription]] forKey:@"errorNSLocalizedDescription"];
                  }
              }
              NSError* parseJSONError = nil;
              NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
              if(parseJSONError){
                  [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                  [dict setObject:(response == nil?@"":response) forKey:@"response"];
                  [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                  msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
              }
              UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                               [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                               [msg cStringUsingEncoding:NSUTF8StringEncoding]);
          }

      });
    }];

}

/**
 *注册
 */
void UnityRegistUsername(const char* username, const char* pwd, const char* gameObjectName, const char* methodName)
{

    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _username = Yodo1CreateNSString(username);
    NSString* _pwd = Yodo1CreateNSString(pwd);

    [[UCenterManager sharedInstance] registUsername:_username
                                                pwd:_pwd
                                           callback:^(BOOL success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     if(success){
                         [dict setObject:[NSNumber numberWithInt:1] forKey:@"result"];
                         [dict setObject:(authorization.userToken==nil?@"":authorization.userToken) forKey:@"userToken"];
                         [dict setObject:(authorization.userId==nil?@"":authorization.userId) forKey:@"userId"];
                         [dict setObject:(authorization.chanelUserId==nil?@"":authorization.chanelUserId) forKey:@"chanelUserId"];
                         [dict setObject:(authorization.yId==nil?@"":authorization.yId) forKey:@"yId"];
                         [dict setObject:[NSNumber numberWithInt:authorization.isnewuser] forKey:@"isnewuser"];
                         [dict setObject:[NSNumber numberWithInt:authorization.isnewyaccount] forKey:@"isnewyaccount"];
                         [dict setObject:(authorization.extra==nil?@"":authorization.extra) forKey:@"extra"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                     }else{
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         if(error){
                             [dict setObject:[NSString stringWithFormat:@"%d",(int)[error code]] forKey:@"errorCode"];
                             [dict setObject:[NSString stringWithFormat:@"%@",[error localizedDescription]] forKey:@"errorNSLocalizedDescription"];
                         }
                     }
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }
             });

                                           }];
}

/**
 *登录
 */
void UnityLogin(int usertype, const char* username, const char* pwd, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _username = Yodo1CreateNSString(username);
    NSString* _pwd = Yodo1CreateNSString(pwd);

    UCenterUserType _usertype = (UCenterUserType)usertype;

    [[UCenterManager sharedInstance] login:_usertype username:_username pwd:_pwd callback:^(UCenterLoginState success, Yodo1MembershipAuthorization* authorization, NSError* error, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     NSString* msg;
                     if(success == UCenterLoginSuccess){
                         [dict setObject:[NSNumber numberWithInt:1] forKey:@"result"];
                         [dict setObject:(authorization.userToken==nil?@"":authorization.userToken) forKey:@"userToken"];
                         [dict setObject:(authorization.userId==nil?@"":authorization.userId) forKey:@"userId"];
                         [dict setObject:(authorization.chanelUserId==nil?@"":authorization.chanelUserId) forKey:@"chanelUserId"];
                         [dict setObject:(authorization.yId==nil?@"":authorization.yId) forKey:@"yId"];
                         [dict setObject:[NSNumber numberWithInt:authorization.isnewuser] forKey:@"isnewuser"];
                         [dict setObject:[NSNumber numberWithInt:authorization.isnewyaccount] forKey:@"isnewyaccount"];
                         [dict setObject:(authorization.extra==nil?@"":authorization.extra) forKey:@"extra"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         NSError* parseJSONError = nil;
                         msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         if(parseJSONError){
                             [dict setObject:[NSNumber numberWithInt:2] forKey:@"result"];
                             [dict setObject:(response == nil?@"":response) forKey:@"response"];
                             [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                             msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         }
                     }else if(success == UCenterLoginFail){
                         [dict setObject:[NSNumber numberWithInt:2] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         if(error){
                             [dict setObject:[NSString stringWithFormat:@"%d",(int)[error code]] forKey:@"errorCode"];
                             [dict setObject:[NSString stringWithFormat:@"%@",[error localizedDescription]] forKey:@"errorNSLocalizedDescription"];
                         }
                         NSError* parseJSONError = nil;
                         msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         if(parseJSONError){
                             [dict setObject:[NSNumber numberWithInt:2] forKey:@"result"];
                             [dict setObject:(response == nil?@"":response) forKey:@"response"];
                             [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                             msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         }
                     }else{
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         if(error){
                             [dict setObject:[NSString stringWithFormat:@"%d",(int)[error code]] forKey:@"errorCode"];
                             [dict setObject:[NSString stringWithFormat:@"%@",[error localizedDescription]] forKey:@"errorNSLocalizedDescription"];
                         }
                         NSError* parseJSONError = nil;
                         msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         if(parseJSONError){
                             [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                             [dict setObject:(response == nil?@"":response) forKey:@"response"];
                             [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                             msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                         }
                     }
                     
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }
             });
    }];
}

/**
 *注销
 */
void UnityLoginOut(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    [UCenterManager setUCenterLoginOutCallback:^{
            dispatch_async(dispatch_get_main_queue(), ^{
                if(ocGameObjName && ocMethodName){
                    UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding], [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding], "UCenter LoginOut callback");
                }
            });
    }];
    [[UCenterManager sharedInstance] loginOut];
}

/**
 *设备账号转换
 */
void UnityConverDeviceToNormal(const char* username, const char* pwd, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _username = Yodo1CreateNSString(username);
    NSString* _pwd = Yodo1CreateNSString(pwd);

    [[UCenterManager sharedInstance] converDeviceToNormal:_username pwd:_pwd callback:^(BOOL success, NSError* error, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     if(success){
                         [dict setObject:[NSNumber numberWithInt:YES] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                     }else{
                         [dict setObject:[NSNumber numberWithInt:NO] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         [dict setObject:(response == nil?@"":response) forKey:@"msg"];
                     }
                     
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                     
                 }
             });
    }];
}

void UnityReplaceContentOfUserId(const char* replacedUserId, const char* deviceId, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _replacedUserId = Yodo1CreateNSString(replacedUserId);
    NSString* _deviceId = Yodo1CreateNSString(deviceId);

    [[UCenterManager sharedInstance] replaceContentOfUserId:_replacedUserId deviceId:_deviceId callback:^(BOOL success, NSError* error, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     if(success){
                         [dict setObject:[NSNumber numberWithInt:YES] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                     }else{
                         [dict setObject:[NSNumber numberWithInt:NO] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         [dict setObject:(response == nil?@"":response) forKey:@"msg"];
                     }
                     
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                         [dict setObject:(response == nil?@"":response) forKey:@"response"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                     
                 }

             });
    }];
}

/**
 *将device_id代表用户的存档的主帐号变更为user_id代表的帐号，user_id本身的数据被删除，替换的数据包括user_id本身
 *用户再次登录时取到的user_id是操作前device_id对应的user_id，原user_id已经删除了
 *device_id再次登录是取到的user_id是全新的
 *appkey 游戏 game_appkey
 *transferedUserId 用户id
 *device_id  设备id
 */
void UnityTransferWithDeviceUserId(const char* transferedUserId, const char* deviceId, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    NSString* _transferedUserId = Yodo1CreateNSString(transferedUserId);
    NSString* _deviceId = Yodo1CreateNSString(deviceId);

    [[UCenterManager sharedInstance] transferWithDeviceUserId:_transferedUserId deviceId:_deviceId callback:^(BOOL success, NSError* error, NSString* response) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if(ocGameObjName && ocMethodName){
                    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                    if(success){
                        [dict setObject:[NSNumber numberWithInt:YES] forKey:@"result"];
                        [dict setObject:(response == nil?@"":response) forKey:@"response"];
                    }else{
                        [dict setObject:[NSNumber numberWithInt:NO] forKey:@"result"];
                        [dict setObject:(response == nil?@"":response) forKey:@"response"];
                        [dict setObject:(response == nil?@"":response) forKey:@"msg"];
                    }
                    
                    NSError* parseJSONError = nil;
                    NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                    if(parseJSONError){
                        [dict setObject:[NSNumber numberWithInt:0] forKey:@"result"];
                        [dict setObject:(response == nil?@"":response) forKey:@"response"];
                        [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                        msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                    }
                    UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                     [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                     [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                }
            });
    }];
}

/**
 *查询漏单
 */
void UnityQueryLossOrder(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);

    [UCenterManager setLossOrderCallback:^(NSArray* productIds, BOOL result, LossOrderType lossOrderType, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                         [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_LossOrderIdQuery] forKey:@"resulType"];
                         if([productIds count] > 0 ){
                             [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
                             [dict setObject:productIds forKey:@"data"];
                     }else{
                             [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                     }
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                             [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_LossOrderIdQuery] forKey:@"resulType"];
                             [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }

             });
    }];

    [[UCenterManager sharedInstance] queryLossOrder];
}
    
    
void UnityCancelPromotion(const char* gameObjectName, const char* methodName){
    
    [[UCenterManager sharedInstance] CancelPromotion];
}
    
void UnityGetPromotionProduct(const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    
    AppStoreProduct* product = [[UCenterManager sharedInstance] GetPromotionProduct];
    
    
    if(ocGameObjName && ocMethodName){
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        if(product){
            [dict setObject:product.uniformProductId forKey:@"productId"];
            [dict setObject:product.channelProductId forKey:@"marketId"];
            [dict setObject:product.productName forKey:@"productName"];
            [dict setObject:product.productPrice forKey:@"price"];
            [dict setObject:product.priceDisplay forKey:@"priceDisplay"];
            [dict setObject:product.productDescription forKey:@"description"];
            [dict setObject:product.currency forKey:@"currency"];
            [dict setObject:[NSNumber numberWithInt:product.productType] forKey:@"ProductType"];
        }
        [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_GetPromotionProduct] forKey:@"resulType"];
        [dict setObject:[NSNumber numberWithInt:product==nil ? 0 : 1] forKey:@"code"];
        
        NSError* parseJSONError = nil;
        NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
        if(parseJSONError){
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_Payment] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
            [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
            msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
        }
        UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                         [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                         [msg cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}
    
void UnityReadyToContinuePurchaseFromPromotion(const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    //设置回调
    [UCenterManager setPaymentCallback:^(NSString* uniformProductId, PaymentState result, NSString* response, NSString* extra) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSDictionary* responseDic = [Yodo1Commons JSONObjectWithString:response error:nil];
                NSString* orderId = @"";
                if(responseDic){
                    orderId = [responseDic objectForKey:@"orderid"];
                }
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                [dict setObject:(uniformProductId == nil?@"":uniformProductId) forKey:@"uniformProductId"];
                [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_Payment] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:(int)result] forKey:@"code"];
                [dict setObject:(orderId == nil?@"":orderId) forKey:@"orderId"];
                [dict setObject:(extra == nil?@"":extra) forKey:@"extra"];
                
                NSError* parseJSONError = nil;
                NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:(uniformProductId == nil?@"":uniformProductId) forKey:@"uniformProductId"];
                    [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_Payment] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:(int)result] forKey:@"code"];
                    [dict setObject:(response == nil?@"":response) forKey:@"data"];
                    [dict setObject:(orderId == nil?@"":orderId) forKey:@"orderId"];
                    [dict setObject:(extra == nil?@"":extra) forKey:@"extra"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                    msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
    
    [[UCenterManager sharedInstance] ReadyToContinuePurchaseFromPromot];
}
    
void UnityFetchStorePromotionVisibilityForProduct(const char* uniformProductId, const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    NSString* _uniformProductId = Yodo1CreateNSString(uniformProductId);
    
    [[UCenterManager sharedInstance] setFetchStorePromotionVisibilityCompletionBlock:^(Yodo1PromotionVisibility storePromotionVisibility, BOOL success, NSString *error) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_FetchPromotionVisibility] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:success ? 1 : 0] forKey:@"code"];
            if(success > 0 ){
                switch(storePromotionVisibility){
                        case Hide:
                        [dict setObject:[NSString stringWithFormat:@"%d", Hide] forKey:@"visible"];
                        break;
                        case Visible:
                        [dict setObject:[NSString stringWithFormat:@"%d", Visible] forKey:@"visible"];
                        break;
                        case Default:
                        [dict setObject:[NSString stringWithFormat:@"%d", Default] forKey:@"visible"];
                        break;
                }
            }
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }];
    
    [[UCenterManager sharedInstance] fetchStorePromotionVisibilityForProduct:_uniformProductId];
    
}
    
void UnityFetchStorePromotionOrder(const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    
    [[UCenterManager sharedInstance] setFetchStorePromotionOrderCompletionBlock:^(NSArray<NSString *> *storePromotionOrder, BOOL success, NSString *error) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_FetchStorePromotionOrder] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:success ? 1 : 0] forKey:@"code"];
            
            [dict setObject:storePromotionOrder forKey:@"storePromotionOrder"];

            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }];
    
    [[UCenterManager sharedInstance] fetchStorePromotionOrder];
}
    
void UnityUpdateStorePromotionOrder(const char* productids, const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    [[UCenterManager sharedInstance] setUpdateStorePromotionOrderCompletionBlock:^(BOOL success, NSString *error) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_UpdateStorePromotionOrder] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:success ? 1 : 0] forKey:@"code"];
                        
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }];
    
    [[UCenterManager sharedInstance] updateStorePromotionOrder:[[NSString stringWithUTF8String:productids] componentsSeparatedByString:@","]];
}

void UnityUpdateStorePromotionVisibility(bool visible, const char* uniformProductId, const char* gameObjectName, const char* methodName){
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    [[UCenterManager sharedInstance] setUpdateStorePromotionVisibilityCompletionBlock:^(BOOL success, NSString *error) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_UpdateStorePromotionVisibility] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:success ? 1 : 0] forKey:@"code"];
            
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }];
    
    [[UCenterManager sharedInstance] updateStorePromotionVisibility:visible Product:[NSString stringWithUTF8String:uniformProductId]];
}
    
/**
 *查询订阅
 */
void UnityQuerySubscriptions(BOOL excludeOldTransactions, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    [UCenterManager setQuerySubscriptionBlock:^(NSArray *subscriptions, NSTimeInterval serverTime, BOOL success, NSString *error) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_QuerySubscriptions] forKey:@"resulType"];
            
            if([subscriptions count] > 0 ){
                NSMutableArray* arrayProduct = [NSMutableArray arrayWithCapacity:1];
                for(int i = 0;i < [subscriptions count]; i++){
                    NSMutableDictionary* dicProduct = [NSMutableDictionary dictionary];
                    SubscriptionInfo* info = [subscriptions objectAtIndex:i];
                    [dicProduct setObject:info.uniformProductId forKey:@"uniformProductId"];
                    [dicProduct setObject:info.channelProductId forKey:@"channelProductId"];
                    [dicProduct setObject:[NSNumber numberWithDouble:info.expiresTime] forKey:@"expiresTime"];
                    [dicProduct setObject:[NSNumber numberWithDouble:info.purchase_date_ms] forKey:@"purchase_date_ms"];
                    
                    [arrayProduct addObject:dicProduct];
                }
                
                [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
                [dict setObject:arrayProduct forKey:@"data"];
                [dict setObject:[NSNumber numberWithDouble:serverTime] forKey:@"serverTime"];
            }else{
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
            }
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            if(parseJSONError){
                [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_QuerySubscriptions] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
            }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }
    }];
    
    [[UCenterManager sharedInstance] querySubscriptions:excludeOldTransactions];
}
/**
 *appstore渠道，恢复购买
 */
void UintyRestorePayment(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    //设置回调
    [UCenterManager setLossOrderCallback:^(NSArray* productIds, BOOL result, LossOrderType lossOrderType, NSString* response) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RestorePayment] forKey:@"resulType"];
                     if([productIds count] > 0 ){
                         [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
                         [dict setObject:productIds forKey:@"data"];
                     }else{
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                     }
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError]; 
                     if(parseJSONError){
                         [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RestorePayment] forKey:@"resulType"];
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }

             });
    }];

    [[UCenterManager sharedInstance] restorePayment];
}

/**
 *根据产品ID,获取产品信息
 */
void UnityProductInfoWithProductId(const char* uniformProductId, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    NSString* _uniformProductId = Yodo1CreateNSString(uniformProductId);
    [[UCenterManager sharedInstance] productInfoWithProductId:_uniformProductId callback:^(NSString* uniformProductId, ProductInfo* productInfo) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RequestProductsInfo] forKey:@"resulType"];
                     if(productInfo){
                         NSMutableDictionary* dicProduct = [NSMutableDictionary dictionary];
                         [dicProduct setObject:uniformProductId forKey:@"productId"];
                         [dicProduct setObject:productInfo.channelProductId == nil?@"":productInfo.channelProductId forKey:@"marketId"];
                         [dicProduct setObject:productInfo.productName == nil?@"":productInfo.productName forKey:@"productName"];
                         NSString* priceDisplay = [NSString stringWithFormat:@"%@ %@",productInfo.productPrice,productInfo.currency];
                         [dicProduct setObject:priceDisplay == nil?@"":priceDisplay forKey:@"priceDisplay"];
                         [dicProduct setObject:productInfo.productPrice == nil?@"":productInfo.productPrice forKey:@"price"];
                         [dicProduct setObject:productInfo.productDescription == nil?@"":productInfo.productDescription forKey:@"description"];
                         [dicProduct setObject:[NSNumber numberWithInt:productInfo.productType] forKey:@"ProductType"];
                         [dicProduct setObject:productInfo.currency == nil?@"":productInfo.currency forKey:@"currency"];
                         [dicProduct setObject:[NSNumber numberWithInt:0] forKey:@"coin"];
                         
                         NSMutableArray* arrayProduct = [NSMutableArray arrayWithCapacity:1];
                         [arrayProduct addObject:dicProduct];
                         [dict setObject:arrayProduct forKey:@"data"];
                         
                         [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
                         
                         
                     }else{
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                     }
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                         [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RequestProductsInfo] forKey:@"resulType"];
                         [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }
             });
    }];
}

/**
 *根据,获取所有产品信息
 */
void UnityProductsInfo(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    [[UCenterManager sharedInstance]productsInfo:^(NSArray *productInfo) {
        if(ocGameObjName && ocMethodName){
            NSMutableDictionary* dict = [NSMutableDictionary dictionary];
            [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RequestProductsInfo] forKey:@"resulType"];
            if([productInfo count] > 0){
            [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
                [dict setObject:productInfo forKey:@"data"];
            }else{
                [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
            }
            NSError* parseJSONError = nil;
            NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
           if(parseJSONError){
               [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_RequestProductsInfo] forKey:@"resulType"];
               [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
           }
            UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                             [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                             [msg cStringUsingEncoding:NSUTF8StringEncoding]);
        }

    }];
}

/**
 *支付
 */
void UnityPayNetGame(const char* uniformProductId,const char* extra, const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    NSString* _uniformProductId = Yodo1CreateNSString(uniformProductId);
    NSString* _extra = Yodo1CreateNSString(extra);

    //设置回调
    [UCenterManager setPaymentCallback:^(NSString* uniformProductId, PaymentState result, NSString* response, NSString* extra) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 if(ocGameObjName && ocMethodName){
                     NSDictionary* responseDic = [Yodo1Commons JSONObjectWithString:response error:nil];
                     NSString* orderId = @"";
                     if(responseDic){
                         orderId = [responseDic objectForKey:@"orderid"];
                     }
                     NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                     [dict setObject:(uniformProductId == nil?@"":uniformProductId) forKey:@"uniformProductId"];
                     [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_Payment] forKey:@"resulType"];
                     [dict setObject:[NSNumber numberWithInt:(int)result] forKey:@"code"];
                     [dict setObject:(orderId == nil?@"":orderId) forKey:@"orderId"];
                     [dict setObject:(extra == nil?@"":extra) forKey:@"extra"];
                     
                     NSError* parseJSONError = nil;
                     NSString* msg = [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     if(parseJSONError){
                         [dict setObject:(uniformProductId == nil?@"":uniformProductId) forKey:@"uniformProductId"];
                         [dict setObject:[NSNumber numberWithInt:Yodo1U3dSDK_ResulType_Payment] forKey:@"resulType"];
                         [dict setObject:[NSNumber numberWithInt:(int)result] forKey:@"code"];
                         [dict setObject:(response == nil?@"":response) forKey:@"data"];
                         [dict setObject:(orderId == nil?@"":orderId) forKey:@"orderId"];
                         [dict setObject:(extra == nil?@"":extra) forKey:@"extra"];
                         [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                         msg =  [Yodo1Commons stringWithJSONObject:dict error:&parseJSONError];
                     }
                     UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                      [msg cStringUsingEncoding:NSUTF8StringEncoding]);
                 }
             });
    }];

    [[UCenterManager sharedInstance] paymentWithProductId:_uniformProductId
                                                    extra:_extra];
}
}

#endif

@end
