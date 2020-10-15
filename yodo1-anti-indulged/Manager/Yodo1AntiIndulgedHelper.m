//
//  Yodo1AntiIndulgedHelper.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/9.
//

#import "Yodo1AntiIndulgedHelper.h"

#import <Yodo1OnlineParameter/Yd1OnlineParameter.h>
#import <Yodo1YYModel/Yodo1Model.h>

#import "Yodo1AntiIndulgedDatabase.h"
#import "Yodo1AntiIndulgedNet.h"
#import "Yodo1AntiIndulgedUtils.h"
#import "Yodo1AntiIndulgedRulesManager.h"
#import "Yodo1AntiIndulgedUserManager.h"
#import "Yodo1AntiIndulgedTimeManager.h"
#import "Yodo1AntiIndulgedMainVC.h"
#import "Yodo1AntiIndulgedDialogVC.h"

@interface Yodo1AntiIndulgedHelper()

@property (nonatomic, copy) NSString *version;
@property (nonatomic, copy) NSString *regionCode;

@end

@implementation Yodo1AntiIndulgedHelper

+ (Yodo1AntiIndulgedHelper *)shared {
    static Yodo1AntiIndulgedHelper *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiIndulgedHelper alloc] init];
    });
    return sharedInstance;
}

- (void)init:(NSString *)appKey channel:(NSString *)channel regionCode:(NSString *)regionCode delegate:(id<Yodo1AntiIndulgedDelegate>)delegate {
    _delegate = delegate;
    _autoTimer = YES;
    _regionCode = regionCode ? regionCode : @"00000000";
    
    [[Yd1OnlineParameter shared] initWithAppKey:appKey channelId:channel];
    [Yodo1AntiIndulgedDatabase shared];
    [Yodo1AntiIndulgedNet manager];
    
    // 获取防沉迷规则 获取失败则使用本地默认
    [[Yodo1AntiIndulgedRulesManager manager] requestRules:^(id data) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onInitFinish:message:)]) {
            [self.delegate onInitFinish:YES message:@"初始化方沉迷系统成功"];
        }
    } failure:^(NSError * error) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(onInitFinish:message:)]) {
            [self.delegate onInitFinish:NO message:error.localizedDescription];
        }
    }];
    
    [[Yodo1AntiIndulgedRulesManager manager] requestHolidayList:nil failure:nil];
    [[Yodo1AntiIndulgedRulesManager manager] requestHolidayRules:nil failure:nil];
}

- (NSString *)getSdkVersion {
    if (!_version) {
        NSString *pathName = @"Yodo1AntiIndulgedConfig.bundle/Yodo1AntiIndulgedInfo";
        NSString *path = [NSBundle.mainBundle pathForResource:pathName ofType:@"plist"];
        NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:path];
        _version = info[@"version"];
        if (!_version) {
            _version = @"1.0.0";
        }
    }
    return _version;
}

- (void)startTimer {
    [[Yodo1AntiIndulgedTimeManager manager] startTimer];
}

- (void)stopTimer {
    [[Yodo1AntiIndulgedTimeManager manager] stopTimer];
}

- (BOOL)isTimer {
    return [[Yodo1AntiIndulgedTimeManager manager] isTimer];
}

- (BOOL)isGuestUser {
    return [[Yodo1AntiIndulgedUserManager manager] isGuestUser];
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

- (void)verifyCertificationInfo:(NSString *)accountId success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {
    
    _certSucdessfulCallback = success;
    _certFailureCallback = failure;
    
    BOOL switchStatus = YES;
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    if (rules) {
        switchStatus = rules.switchStatus;
    }
    
    if (switchStatus) {
        [[Yodo1AntiIndulgedUserManager manager] get:accountId success:^(Yodo1AntiIndulgedUser *user) {
            if (user.certificationStatus != UserCertificationStatusNot && user.age != -1) {
                Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                event.eventCode = Yodo1AntiIndulgedEventCodeNone;
                event.action = Yodo1AntiIndulgedActionResumeGame;
                if (self->_certSucdessfulCallback) {
                    self->_certSucdessfulCallback(event);
                }
                // 自动开启计时
                if (self.autoTimer) {
                    [self startTimer];
                }
            } else {
                // 未实名
                [Yodo1AntiIndulgedUtils showVerifyUI];
            }
        } failure:^(NSError *error) {
            // 发生错误一律认为未实名
            [Yodo1AntiIndulgedUtils showVerifyUI];
        }];
    } else {
        Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
        event.eventCode = Yodo1AntiIndulgedEventCodeNone;
        event.action = Yodo1AntiIndulgedActionResumeGame;
        if (self->_certSucdessfulCallback) {
            self->_certSucdessfulCallback(event);
        }
    }
}

///是否已限制消费
- (void)verifyPurchase:(NSInteger)money success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {

    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"money"] = @(money * 100);
    parameters[@"currency"] = @"CNY";
    
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    if (user.certificationStatus == UserCertificationStatusNot) {
        BOOL show = success && success(@(true));
        if (!show) {
            [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleBuyDisable error:nil];
        }
        return;
    }
    
    [[Yodo1AntiIndulgedNet manager] GET:@"money/info" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res && res.success && res.data) {
            
            id hasLimit = res.data[@"hasLimit"];
            BOOL limit = hasLimit ? [hasLimit boolValue] : false; // 是否被限制
    
            id alertMsg = res.data[@"alertMsg"];
            NSString *msg = (alertMsg && ![alertMsg isKindOfClass:[NSNull class]]) ? alertMsg : res.message;

            BOOL show = false;
            if (success) {
                show = success(@(limit));
            }
            
            if (!show && limit) {
                [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleBuyOverstep error:msg];
            }
        } else {
            if (failure) {
                failure([Yodo1AntiIndulgedUtils errorWithCode:res.code msg:res.message]);
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)reportProductReceipts:(NSArray<Yodo1AntiIndulgedProductReceipt *> *)receipts success:(Yodo1AntiIndulgedSuccessful)success failure:(Yodo1AntiIndulgedFailure)failure {
    if (receipts.count == 0) {
        return;
    }
    for (Yodo1AntiIndulgedProductReceipt *receipt in receipts) {
        if (!receipt.region) {
            receipt.region = _regionCode;
        }
    }
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"groupReceiptAndGoodsInfo"] = [receipts yodo1_modelToJSONObject];
    
    long long timestamp = [NSDate date].timeIntervalSince1970 * 1000;
    parameters[@"sign"] = [Yodo1AntiIndulgedUtils md5String:[NSString stringWithFormat:@"anti%@", @(timestamp)]];
    parameters[@"timestamp"] = @(timestamp);
    
    [[Yodo1AntiIndulgedNet manager] POST:@"money/receipt" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res && res.success) {
            if (success) {
                success(res.data);
            }
        } else {
            if (failure) {
                failure([Yodo1AntiIndulgedUtils errorWithCode:res.code msg:res.message]);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
