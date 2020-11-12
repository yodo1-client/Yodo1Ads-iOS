//
//  Yodo1AntiAddictionHelper.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/9.
//

#import "Yodo1AntiAddictionHelper.h"

#import <Yodo1OnlineParameter/Yd1OnlineParameter.h>
#import <Yodo1YYModel/Yodo1Model.h>

#import "Yodo1AntiAddictionDatabase.h"
#import "Yodo1AntiAddictionNet.h"
#import "Yodo1AntiAddictionUtils.h"
#import "Yodo1AntiAddictionRulesManager.h"
#import "Yodo1AntiAddictionUserManager.h"
#import "Yodo1AntiAddictionTimeManager.h"
#import "Yodo1AntiAddictionMainVC.h"
#import "Yodo1AntiAddictionDialogVC.h"

@interface Yodo1AntiAddictionHelper()

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *regionCode;

@end

@implementation Yodo1AntiAddictionHelper

+ (Yodo1AntiAddictionHelper *)shared {
    static Yodo1AntiAddictionHelper *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiAddictionHelper alloc] init];
    });
    return sharedInstance;
}

- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate:(id<Yodo1AntiAddictionDelegate>)delegate {
    _delegate = delegate;
    _autoTimer = YES;
    _regionCode = regionCode ? regionCode : @"00000000";
    
    [[Yd1OnlineParameter shared] initWithAppKey:appKey channelId:channel];
    [Yodo1AntiAddictionDatabase shared];
    [Yodo1AntiAddictionNet manager];
    
    // 获取防沉迷规则 获取失败则使用本地默认
    [[Yodo1AntiAddictionRulesManager manager] requestRules:^(id data) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onInitFinish:message:)]) {
            [self.delegate onInitFinish:YES message:@"初始化方沉迷系统成功"];
        }
    } failure:^(NSError * error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onInitFinish:message:)]) {
            [self.delegate onInitFinish:NO message:error.localizedDescription];
        }
    }];
    
    [[Yodo1AntiAddictionRulesManager manager] requestHolidayList:nil failure:nil];
    [[Yodo1AntiAddictionRulesManager manager] requestHolidayRules:nil failure:nil];
}

- (NSString *)getSdkVersion {
    if (!_version) {
        NSString *path = [[Yodo1AntiAddictionUtils bundle] pathForResource:@"Yodo1AntiAddictionInfo" ofType:@"plist"];
        NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:path];
        _version = info[@"version"];
        if (!_version) {
            _version = @"1.0.0";
        }
    }
    return _version;
}

- (void)startTimer {
    [[Yodo1AntiAddictionTimeManager manager] startTimer];
}

- (void)stopTimer {
    [[Yodo1AntiAddictionTimeManager manager] stopTimer];
}

- (BOOL)isTimer {
    return [[Yodo1AntiAddictionTimeManager manager] isTimer];
}

- (BOOL)isGuestUser {
    return [[Yodo1AntiAddictionUserManager manager] isGuestUser];
}

- (BOOL)successful:(id _Nullable)data {
    if (_certSucdessfulCallback) {
        return _certSucdessfulCallback(data);
    } else {
        return NO;
    }
}

- (BOOL)failure:(NSError * _Nullable)error {
    if (_certFailureCallback) {
        return _certFailureCallback(error);
    } else {
        return NO;
    }
}

- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {
    
    _certSucdessfulCallback = success;
    _certFailureCallback = failure;
    
    BOOL switchStatus = YES;
    Yodo1AntiAddictionRules *rules = [Yodo1AntiAddictionRulesManager manager].currentRules;
    if (rules) {
        switchStatus = rules.switchStatus;
    }
    
    if (switchStatus) {
        [[Yodo1AntiAddictionUserManager manager] get:accountId success:^(Yodo1AntiAddictionUser *user) {
            if (user.certificationStatus != UserCertificationStatusNot && user.age != -1) {
                Yodo1AntiAddictionEvent *event = [[Yodo1AntiAddictionEvent alloc] init];
                event.eventCode = Yodo1AntiAddictionEventCodeNone;
                event.action = Yodo1AntiAddictionActionResumeGame;
                if (self->_certSucdessfulCallback) {
                    self->_certSucdessfulCallback(event);
                }
                // 自动开启计时
                if (self.autoTimer) {
                    [self startTimer];
                }
            } else {
                // 未实名
                [Yodo1AntiAddictionUtils showVerifyUI];
            }
        } failure:^(NSError *error) {
            // 发生错误一律认为未实名
            if ([Yodo1AntiAddictionUtils isNetError:error]) {
                [Yodo1AntiAddictionDialogVC showDialog:Yodo1AntiAddictionDialogStyleError error:[Yodo1AntiAddictionUtils convertError:error].localizedDescription];
            } else {
                [Yodo1AntiAddictionUtils showVerifyUI];
            }
        }];
    } else {
        Yodo1AntiAddictionEvent *event = [[Yodo1AntiAddictionEvent alloc] init];
        event.eventCode = Yodo1AntiAddictionEventCodeNone;
        event.action = Yodo1AntiAddictionActionResumeGame;
        if (self->_certSucdessfulCallback) {
            self->_certSucdessfulCallback(event);
        }
    }
}

///是否已限制消费
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"money"] = @(money);
    parameters[@"currency"] = @"CNY";
    
    Yodo1AntiAddictionUser *user = [Yodo1AntiAddictionUserManager manager].currentUser;
    if (user.certificationStatus == UserCertificationStatusNot) {
        BOOL show = success && success(@{@"hasLimit" : @(true), @"alertMsg": @"根据国家规定：游客体验模式无法购买物品"});
        if (!show) {
            [Yodo1AntiAddictionDialogVC showDialog:Yodo1AntiAddictionDialogStyleBuyDisable error:nil];
        }
        return;
    }
    
    [[Yodo1AntiAddictionNet manager] GET:@"money/info" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiAddictionResponse *res = [Yodo1AntiAddictionResponse yodo1_modelWithJSON:data];
        if (res && res.success && res.data) {
            
            id hasLimit = res.data[@"hasLimit"];
            BOOL limit = hasLimit ? [hasLimit boolValue] : false; // 是否被限制
    
            id alertMsg = res.data[@"alertMsg"];
            NSString *msg = (alertMsg && ![alertMsg isKindOfClass:[NSNull class]]) ? alertMsg : res.message;

            BOOL show = false;
            if (success) {
                show = success(@{@"hasLimit": @(limit), @"alertMsg": msg});
            }
            
            if (!show && limit) {
                [Yodo1AntiAddictionDialogVC showDialog:Yodo1AntiAddictionDialogStyleBuyOverstep error:msg];
            }
        } else {
            if (failure) {
                failure([Yodo1AntiAddictionUtils errorWithCode:res.code msg:res.message]);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure([Yodo1AntiAddictionUtils convertError:error]);
        }
    }];
}

- (void)reportProductReceipts:(NSArray<Yodo1AntiAddictionProductReceipt *> *)receipts success:(Yodo1AntiAddictionSuccessful)success failure:(Yodo1AntiAddictionFailure)failure {
    if (receipts.count == 0) {
        return;
    }
    for (Yodo1AntiAddictionProductReceipt *receipt in receipts) {
        if (!receipt.region) {
            receipt.region = _regionCode;
        }
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"groupReceiptAndGoodsInfo"] = [receipts yodo1_modelToJSONObject];
    
    long long timestamp = [NSDate date].timeIntervalSince1970 * 1000;
    parameters[@"sign"] = [Yodo1AntiAddictionUtils md5String:[NSString stringWithFormat:@"anti%@", @(timestamp)]];
    parameters[@"timestamp"] = @(timestamp);
    
    [[Yodo1AntiAddictionNet manager] POST:@"money/receipt" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiAddictionResponse *res = [Yodo1AntiAddictionResponse yodo1_modelWithJSON:data];
        if (res && res.success) {
            if (success) {
                success(res.data);
            }
        } else {
            if (failure) {
                failure([Yodo1AntiAddictionUtils errorWithCode:res.code msg:res.message]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure([Yodo1AntiAddictionUtils convertError:error]);
        }
    }];
}

@end
