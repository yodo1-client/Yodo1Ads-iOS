//
//  Yodo1RealNameManager.m
//  Real-name
//
//  Created by yixian huang on 2020/1/2.
//  Copyright © 2020 yixian huang. All rights reserved.
//

#import "Yodo1RealNameManager.h"
#import "Yodo1Base.h"
#import "Yd1UCenter.h"
#import "Yodo1Tool+Storage.h"
#import "RealNameCertification.h"
#import "Yd1OnlineParameter.h"
#import "Yodo1Tool+Commons.h"
#import "Yodo1UnityTool.h"
#import "Yodo1Commons.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

@interface Yodo1RealNameManager () {
    BOOL isHaveYid;
    int verifierMaxCount;
    int verifierCount;
    NSString* todayKey;
    NSString* yesterdayKey;
    NSString* playerTimeKey;
    NSDate* beginPlayDate;
    BOOL isStartTime;
    __block long playedTime;//已玩时长
    __block long _remainingTime;//剩余时长
    __block NSTimer* timer;
    __block long tempRremainingTime;
    __block long notifyTime;
    NSString* __useId;
}

- (NSString*)today;
- (NSString*)yesterdayDay:(NSDate*)aDate;

@end

@implementation Yodo1RealNameManager

+ (instancetype)shared {
    return [Yodo1Base.shared cc_registerSharedInstance:self block:^{
        [Yodo1RealNameManager.shared willInit];
    }];
}

+ (void)load {
    [Yodo1RealNameManager.shared addRNServer];
}

- (void)dealloc {
    [Yodo1RealNameManager.shared removeRNServer];
}

- (void)addRNServer {
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(rnDidEnterBackgroundNotification:)//前台进入后台
                                               name:UIApplicationDidEnterBackgroundNotification
                                             object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(rnWillEnterForegroundNotification:)//后台进入前台->完全激活状态
                                                name:UIApplicationWillEnterForegroundNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(rnDidFinishLaunchingNotification:)//加载完毕
                                                name:UIApplicationDidFinishLaunchingNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(rnWillTerminateNotification:)//将会终止程序（将要离开激活状态->进入后台->终止程序）
                                                name:UIApplicationWillTerminateNotification
                                              object:nil];
    
}

- (void)removeRNServer {
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIApplicationDidEnterBackgroundNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIApplicationWillEnterForegroundNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIApplicationDidFinishLaunchingNotification
                                                 object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIApplicationWillTerminateNotification
                                                 object:nil];
}

/// 进入后台
- (void)rnDidEnterBackgroundNotification:(NSNotification*)notifi {
    [self savePlayedTime];
}

///后台进入前台->完全激活状态
- (void)rnWillEnterForegroundNotification:(NSNotification*)notifi {
    if (isStartTime && beginPlayDate) {
        beginPlayDate = NSDate.date;
    }
}

///加载完毕
- (void)rnDidFinishLaunchingNotification:(NSNotification*)notifi {
    
}

///将要终止程序
- (void)rnWillTerminateNotification:(NSNotification*)notifi {
    [self savePlayedTime];
}

- (void)savePlayedTime {
    if (isStartTime) {
        NSNumber* oldPlayedTime = (NSNumber*)[Yd1OpsTools.cached objectForKey:playerTimeKey];
        long playedTime = [self intervalWithBeginTime:beginPlayDate];
        playedTime += [oldPlayedTime longValue];
#ifdef DEBUG
        NSLog(@"[ Yodo1 ]  playedTime:%ld",playedTime);
#endif
        [Yd1OpsTools.cached setObject:[NSNumber numberWithLong:playedTime]
                               forKey:playerTimeKey];
    }
}

- (void)willInit {
    notifyTime = 3600;//默认一小时
    isHaveYid = false;
    verifierMaxCount = 3;
    verifierCount = 0;
    todayKey = [self today];
    yesterdayKey = [self yesterdayDay:[NSDate date]];
    NSLog(@"todayKey:%@",todayKey);
    NSLog(@"yesterdayKey:%@",yesterdayKey);
    playerTimeKey = [NSString stringWithFormat:@"playerTime%@",todayKey];
    
    [Yd1OpsTools.cached removeObjectForKey:yesterdayKey];//移除昨天的已验证次数
    [Yd1OpsTools.cached removeObjectForKey:[NSString stringWithFormat:@"playerTime%@",yesterdayKey]];//移除昨天的已玩时间
    
    NSNumber* verifierCountNub = (NSNumber*)[Yd1OpsTools.cached objectForKey:todayKey];
    verifierCount = [verifierCountNub intValue];
    __useId = (NSString*)[[Yd1OpsTools cached] objectForKey:@"__yd1_useId__"];
}

- (void)realNameConfig {
    [RealNameCertification realNameConfigAppKey:Yd1OParameter.appKey
                                        channel:Yd1OParameter.channelId
                                        version:Yd1OpsTools.appVersion
                                       callback:^(OnlineRealNameConfig *config,NSString* errorMsg) {
        if (config) {
            self->_onlineConfig = config;
            self->verifierMaxCount = config.max_count;
        }
#ifdef DEBUG
        NSLog(@"[ Yodo1 ]  %@",[NSString stringWithFormat:@"防沉迷在线配置:验证方:%@,最大验证次数:%d,年龄验证开关:%d,是否强制实名认证:%d,实名验证开关:%d",config.verifier,config.max_count,config.verify_age_enabled,config.forced,config.verify_idcode_enabled]);
#endif
    }];
}

/// get today
- (NSString*)today {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (NSTimeInterval)intervalWithBeginTime:(NSDate*)begin {
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"yyyy-MM-dd HH:mm";
    NSTimeInterval intervalTime = [NSDate.date timeIntervalSinceDate:begin];
    return intervalTime;
}

/// get yesterday
- (NSString*)yesterdayDay:(NSDate*)aDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekday| NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:aDate];
    [components setDay:([components day] - 1)];
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [[NSDateFormatter alloc] init];
    [dateday setDateFormat:@"yyyy-MM-dd"];
    return [dateday stringFromDate:beginningOfWeek];
}

/// 默认是1小时 通知
- (void)playtimeNotifyTime:(long)seconds {
    notifyTime = seconds;
}

- (void)indentifyUserId:(NSString *)userId
         viewController:(UIViewController *)controller
               callback:(void (^)(BOOL ,int, int, NSError *))callback {
    if (!_onlineConfig) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"online config is not fetch!"}];
        callback(NO,ResultCodeFailed,-100,error);
        [self realNameConfig];
        return;
    }
    if (self.onlineConfig.remaining_cost == -1||self.onlineConfig.remaining_time == -1) {
        NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-3 userInfo:@{NSLocalizedDescriptionKey:@"online config is Foreign IP"}];
        callback(NO,ResultCodeFailed,-1001,error);
        return;
    }
    
    if (!self.onlineConfig.verify_idcode_enabled) {//无实名规则
        NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-2 userInfo:@{NSLocalizedDescriptionKey:@"id code of online config is disable"}];
        callback(NO,ResultCodeFailed,-1002,error);
        return;
    }
    
    if (__useId && ![userId isEqualToString:__useId]) {
        //切换账户
        verifierCount = 0;
        [Yd1OpsTools.cached setObject:[NSNumber numberWithInt:0] forKey:self->todayKey];
    }
    _userId = userId;
    __useId = userId;
    [Yd1OpsTools.cached setObject:userId? :@"" forKey:@"__yd1_useId__"];
    
    typeof(self) weakSelf = self;
    [Yd1UCenter.shared deviceLoginWithPlayerId:_userId
                                      callback:^(YD1User * _Nullable user, NSError * _Nullable error) {
        if (callback) {
            self->_yId = user.yid;
            if (user.yid) {
                __block NSString* _yid = user.yid;
                [RealNameCertification userRealNameVerifyYid:_yid
                                                    callback:^(BOOL success,int age, NSString *errorMsg) {
                    if (age > 0) {
                        if (callback) {
                            self->_age = age;
                            ///已经实名过
                            callback(true,ResultCodeSuccess,age,nil);
                        }
                    } else {
                        if (self->verifierCount >= self->verifierMaxCount) {
                            NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"今天已经达到实名验证次数上限"}];
                            callback(false,ResultCodeFailed,-101,error);
                            return;
                        }
                        RealNameViewController * realName = [[RealNameViewController alloc]init];
                        realName.isSkipValidation = !weakSelf.onlineConfig.forced;
                        [controller presentViewController:realName animated:YES completion:nil];
                        [realName setBlock:^(RealNameParameterInfoRequestParameter *info) {
                            
                            if (info.isSkip) {//可跳过，试玩？
                                NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"user is clicked skip button!"}];
                                if (callback) {
                                    callback(NO,ResultCodeCancel,info.age,error);
                                }
                                return;
                            }
                            
                            if (info) {
                                info.yId = _yid;
                            }
                            self->_age = info.age;
                            [RealNameCertification realNameCertificationInfo:info
                                                                    callback:^(BOOL isRealName,int age, NSString *errorMsg) {
                                NSError* error = nil;
                                if (!isRealName && errorMsg) {
                                    error = [NSError errorWithDomain:@"com.yodo1.realname" code:-1 userInfo:@{NSLocalizedDescriptionKey:errorMsg}];
                                }
                                if (callback) {
                                    callback(isRealName,isRealName?ResultCodeSuccess:ResultCodeFailed,info.age,error);
                                }
                                self->verifierCount += 1;
                                [Yd1OpsTools.cached setObject:[NSNumber numberWithInt:self->verifierCount] forKey:self->todayKey];
                            }];
                        }];
                    }
                }];
            } else {
                NSError* error = [NSError errorWithDomain:@"com.yodo1.realname" code:-1 userInfo:@{NSLocalizedDescriptionKey:@"Failed to get yId!"}];
                if (callback) {
                    callback(NO,ResultCodeFailed,-111,error);
                }
            }
        }
    }];
}

/// 执行一次
- (void)createImpubicProtectSystem:(int)age
                          callback:(void (^)(BOOL, NSString *))callback {
    //启动计时
    beginPlayDate = NSDate.date;
    isStartTime = true;
    NSNumber* oldPlayedTime = (NSNumber*)[Yd1OpsTools.cached objectForKey:playerTimeKey];
    playedTime = [oldPlayedTime longValue];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ]  playedTime:%ld",playedTime);
#endif
    AntiConfigRequestParameter * parameter = [AntiConfigRequestParameter new];
    parameter.age = age;
    parameter.yId = self.yId;
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.play_time = playedTime;
    [RealNameCertification antiAddictionConfig:parameter
                                      callback:^(BOOL success,int remainingTime, int remainingCost, NSString *errorMsg) {
#ifdef DEBUG
        NSLog(@"[ Yodo1 ] %@",[NSString stringWithFormat:@"剩余可玩时长:%d 秒,剩余可用的购买金额:%d 元,errorMsg:%@",remainingTime,remainingCost,errorMsg]);
#endif
        if (remainingCost > 0) {
            self->_playerRemainingCost = remainingCost;
        }
        if (success && remainingTime > 0) {
            self->_remainingTime = remainingTime;
            self->tempRremainingTime = remainingTime;
            [Yd1OpsTools.cached setObject:@0 forKey:self->playerTimeKey];
            if (callback) {
                callback(success,errorMsg);
            }
        }else{
            if (callback) { //创建防沉迷系统失败
                callback(NO,errorMsg);
            }
        }
        
    }];
}

- (void)handleTimer {
    
    if (_remainingTime == 0) {
        [timer invalidate];
        //时长消耗完 同步数据
        AntiNotifyRequestParameter* parameter = [AntiNotifyRequestParameter new];
        parameter.game_appkey = Yd1OParameter.appKey;
        parameter.game_version = Yd1OpsTools.appVersion;
        parameter.channel_code = Yd1OParameter.channelId;
        parameter.yId = self.yId;
        parameter.type = NotifyTypeDate;
        parameter.consume_time = tempRremainingTime;
        parameter.age = _age;
        [RealNameCertification uploadAntiAddictionData:parameter
                                              callback:^(BOOL success,NotifyType type,int errorCode,int remainingTime, int remainingCost, NSString *errorMsg) {
            NSString* st = @"";
            NSString* st2 = @"";
            if (type == NotifyTypePay) {
                st = @"支付查询";
                st2 = [NSString stringWithFormat:@"剩余消费:%d",remainingCost];
            }else if (type == NotifyTypeDate){
                st = @"时长查询";
                st2 = [NSString stringWithFormat:@"剩余时长:%d",remainingTime];
            }
            
#ifdef DEBUG
            NSLog(@"[ Yodo1 ] %@",[NSString stringWithFormat:@"%@,errorCode:%d,%@,errorMsg:%@",st,errorCode,st2,errorMsg]);
#endif
            if (self.playtimeOverCallback) {
                self.playtimeOverCallback(success,errorCode, errorMsg, self->tempRremainingTime);
            }
        }];
        return;
    } else if(_remainingTime <= notifyTime) {//通知客户端
        if (self.playTimeCallback) {
            self.playTimeCallback(YES,(tempRremainingTime - _remainingTime), _remainingTime < 0? :0);
        }
    }
    _remainingTime -= 1;
    _playerRemainingTime = _remainingTime;
}

- (void)startPlaytimeKeeper {
    if (!timer) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(handleTimer)
                                               userInfo:nil
                                                repeats:YES];
    }
}

- (void)verifyPaymentAmount:(int)price {
    PaymentCheckRequestParameter * parameter = [PaymentCheckRequestParameter new];
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.yId = self.yId;
    parameter.age = self.age;
    parameter.money = price*100;
    typeof(self) weakSelf = self;
    [RealNameCertification orderToVerify:parameter
                                callback:^(BOOL success,int errorCode, NSString *errorMsg) {
        if (weakSelf.verifyPaymentCallback) {
            weakSelf.verifyPaymentCallback(success,errorCode, errorMsg);
        }
    }];
}

- (void)queryPlayerRemainingTime:(void (^)(BOOL, int, NSString *, double))callback {
    AntiConfigRequestParameter * parameter = [AntiConfigRequestParameter new];
    parameter.age = self.age;
    parameter.yId = self.yId;
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.play_time = (tempRremainingTime - _remainingTime);
    [RealNameCertification antiAddictionConfig:parameter
                                      callback:^(BOOL success,int remainingTime, int remainingCost, NSString *errorMsg) {
#ifdef DEBUG
        NSLog(@"[ Yodo1 ]  %@",[NSString stringWithFormat:@"剩余可玩时长:%d 秒,剩余可用的购买金额:%d 元,errorMsg:%@",remainingTime,remainingCost,errorMsg]);
#endif
        if (callback) {
            callback(success,success?ResultCodeSuccess:ResultCodeFailed,errorMsg,remainingTime);
        }
    }];
}

- (void)queryPlayerRemainingCost:(void (^)(BOOL,int, NSString *, double))callback {
    AntiConfigRequestParameter * parameter = [AntiConfigRequestParameter new];
    parameter.age = self.age;
    parameter.yId = self.yId;
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.play_time = (tempRremainingTime - _remainingTime);
    [RealNameCertification antiAddictionConfig:parameter
                                      callback:^(BOOL success,int remainingTime, int remainingCost, NSString *errorMsg) {
        
#ifdef DEBUG
        NSLog(@"[ Yodo1 ] %@",[NSString stringWithFormat:@"剩余可玩时长:%d 秒,剩余可用的购买金额:%d 元,errorMsg:%@",remainingTime,remainingCost,errorMsg]);
#endif
        if (callback) {
            callback(success,success?ResultCodeSuccess:ResultCodeFailed,errorMsg,remainingCost);
        }
    }];
}

- (void)queryImpubicProtectConfigWithCode:(int)code
                                 callback:(void (^)(BOOL,int, NSString *, NSString *))callback {
    TemplateDetailRequeseParameter *parameter = [TemplateDetailRequeseParameter new];
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.yId = self.yId;
    parameter.code = code;
    [RealNameCertification templateDetail:parameter
                                 callback:^(BOOL success,int errorCode,NSString* response, NSString *errorMsg) {
        if (callback) {
            callback(success,errorCode,errorMsg,response);
        }
    }];
}

@end

#pragma mark- ///Unity

#ifdef __cplusplus

extern "C" {

void UnityIndentifyUser(const char *playerId,const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    NSString* ocPlayerId = Yodo1CreateNSString(playerId);
    
    [Yodo1RealNameManager.shared indentifyUserId:ocPlayerId
                                  viewController:[Yodo1Commons getRootViewController]
                                        callback:^(BOOL isRealName,int resultCode, int age, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                NSMutableDictionary* data = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9001] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:resultCode] forKey:@"code"];
                [dict setObject:error.localizedDescription? :@"" forKey:@"error"];
                
                [data setObject:[NSNumber numberWithInt:age] forKey:@"age"];
                Indentify ify = IndentifyRealName;
                if (!Yodo1RealNameManager.shared.onlineConfig.verify_idcode_enabled) {
                    ify = IndentifyDisabled;
                }
                [data setObject:[NSNumber numberWithInt:(int)ify] forKey:@"type"];
                int level = Yodo1RealNameManager.shared.onlineConfig.level;
                if (age == -1001) {//海外IP
                    level = 2;
                }else if (age == -1002){//无实名规则
                    level = 1;
                }
                
                [data setObject:[NSNumber numberWithInt:level] forKey:@"level"];
                [dict setObject:data forKey:@"data"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9001] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"error"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
}

void UnityCreateImpubicProtectSystem(int age,const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    [Yodo1RealNameManager.shared createImpubicProtectSystem:age
                                                   callback:^(BOOL success, NSString *msg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9008] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:success?1:0] forKey:@"code"];
                [dict setObject:msg? :@"" forKey:@"error"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9008] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"error"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
    
}

void UnityStartPlaytimeKeeper(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    [Yodo1RealNameManager.shared setPlayTimeCallback:^(BOOL success,long playedTime, long remainingTime) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                NSMutableDictionary* data = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9002] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:success?1:0] forKey:@"code"];
                [data setObject:[NSNumber numberWithLong:playedTime] forKey:@"played_time"];
                [data setObject:[NSNumber numberWithLong:remainingTime] forKey:@"remaining_time"];
                [dict setObject:data forKey:@"data"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9002] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
    [Yodo1RealNameManager.shared setPlaytimeOverCallback:^(BOOL success, int resultCode, NSString *msg, long playedTime) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                NSMutableDictionary* data = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9003] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:resultCode] forKey:@"code"];
                [dict setObject:msg? :@"" forKey:@"error"];
                
                [data setObject:[NSNumber numberWithLong:playedTime] forKey:@"played_time"];
                [dict setObject:data forKey:@"data"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9003] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:resultCode] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
    [Yodo1RealNameManager.shared startPlaytimeKeeper];
}

void UnitySetPlaytimeNotifyTime(long seconds)
{
    [Yodo1RealNameManager.shared playtimeNotifyTime:seconds];
}

void UnityVerifyPaymentAmount(double price,const char* gameObjectName, const char* methodName)
{
    
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    [Yodo1RealNameManager.shared setVerifyPaymentCallback:^(BOOL success, int resultCode, NSString *msg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9004] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:success?1:resultCode] forKey:@"code"];
                [dict setObject:msg? :@"" forKey:@"error"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9004] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:success?1:resultCode] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"error"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
    
    [Yodo1RealNameManager.shared verifyPaymentAmount:price];
}

void UnityQueryPlayerRemainingTime(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    if(ocGameObjName && ocMethodName){
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        NSMutableDictionary* data = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:9005] forKey:@"resulType"];
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
        [dict setObject:@"" forKey:@"error"];
        [data setObject:[NSNumber numberWithDouble:Yodo1RealNameManager.shared.playerRemainingTime] forKey:@"remaining_time"];
        NSLog(@"[ Yodo1 ]:剩余时长->%ld 秒",Yodo1RealNameManager.shared.playerRemainingTime);
        [dict setObject:data forKey:@"data"];
        NSError* parseJSONError = nil;
        NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
        if(parseJSONError){
            [dict setObject:[NSNumber numberWithInt:9005] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
            [dict setObject:@"Convert result to json failed!" forKey:@"error"];
            msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
        }
        UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                         [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                         [msg cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}

void UnityQueryPlayerRemainingCost(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    if(ocGameObjName && ocMethodName){
        NSMutableDictionary* dict = [NSMutableDictionary dictionary];
        NSMutableDictionary* data = [NSMutableDictionary dictionary];
        [dict setObject:[NSNumber numberWithInt:9006] forKey:@"resulType"];
        [dict setObject:[NSNumber numberWithInt:1] forKey:@"code"];
        [dict setObject:@"" forKey:@"error"];
        int remainConst = Yodo1RealNameManager.shared.playerRemainingCost;
        [data setObject:[NSNumber numberWithInt:remainConst] forKey:@"remaining_cost"];
        NSLog(@"[ Yodo1 ]:剩余消费->%d元",remainConst);
        [dict setObject:data forKey:@"data"];
        NSError* parseJSONError = nil;
        NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
        if(parseJSONError){
            [dict setObject:[NSNumber numberWithInt:9006] forKey:@"resulType"];
            [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
            [dict setObject:@"Convert result to json failed!" forKey:@"error"];
            msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
        }
        UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                         [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                         [msg cStringUsingEncoding:NSUTF8StringEncoding]);
    }
}

void UnityQueryImpubicProtectConfig(const char* gameObjectName, const char* methodName)
{
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    
    [Yodo1RealNameManager.shared queryImpubicProtectConfigWithCode:0 callback:^(BOOL success, int resultCode, NSString *msg, NSString *response) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9007] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:success?1:0] forKey:@"code"];
                [dict setObject:msg? :@"" forKey:@"error"];
                
                [dict setObject:respo? :@{} forKey:@"data"];
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9007] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:0] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"error"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];
}


void UnityUploadAntiAddictionData(const char* orderId,const char* money,const char* gameObjectName, const char* methodName)
{
    NSString* ocOrderId = Yodo1CreateNSString(orderId);
    NSString* ocMoney = Yodo1CreateNSString(money);
    NSString* ocGameObjName = Yodo1CreateNSString(gameObjectName);
    NSString* ocMethodName = Yodo1CreateNSString(methodName);
    AntiNotifyRequestParameter* parameter = [AntiNotifyRequestParameter new];
    parameter.game_appkey = Yd1OParameter.appKey;
    parameter.game_version = Yd1OpsTools.appVersion;
    parameter.channel_code = Yd1OParameter.channelId;
    parameter.yId = Yodo1RealNameManager.shared.yId;
    parameter.type = NotifyTypePay;
    parameter.consume_time = 0;
    //数组里面的字典
    NSNumber* moneyNum = [NSNumber numberWithInt:ocMoney.intValue*100];
    parameter.orders = @[@{kAntiConsumeOrderid:ocOrderId,
                           kAntiConsumeMoney:moneyNum}];
    parameter.age = Yodo1RealNameManager.shared.age;
    
    [RealNameCertification uploadAntiAddictionData:parameter
                                          callback:^(BOOL success, NotifyType type, int errorCode, int remainingTime, int remainingCost, NSString *errorMsg) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if(ocGameObjName && ocMethodName){
                if (success) {
                    Yodo1RealNameManager.shared.playerRemainingCost -= [ocMoney intValue];
                }
                NSMutableDictionary* dict = [NSMutableDictionary dictionary];
                NSMutableDictionary* data = [NSMutableDictionary dictionary];
                [dict setObject:[NSNumber numberWithInt:9010] forKey:@"resulType"];
                [dict setObject:[NSNumber numberWithInt:errorCode] forKey:@"code"];
                [data setObject:[NSNumber numberWithInt:remainingCost] forKey:@"remaining_cost"];
                [data setObject:errorMsg? :@"" forKey:@"msg"];
                [dict setObject:data forKey:@"data"];
                
                NSError* parseJSONError = nil;
                NSString* msg = [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                if(parseJSONError){
                    [dict setObject:[NSNumber numberWithInt:9010] forKey:@"resulType"];
                    [dict setObject:[NSNumber numberWithInt:errorCode] forKey:@"code"];
                    [dict setObject:@"Convert result to json failed!" forKey:@"msg"];
                    msg =  [Yd1OpsTools stringWithJSONObject:dict error:&parseJSONError];
                }
                UnitySendMessage([ocGameObjName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [ocMethodName cStringUsingEncoding:NSUTF8StringEncoding],
                                 [msg cStringUsingEncoding:NSUTF8StringEncoding]);
            }
        });
    }];;
}

bool UnityIsChineseMainland()
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    //运营商可用
    BOOL use = carrier.allowsVOIP;
    BOOL isCNTerritory = true;
    BOOL isCNSimKa = true;
    if(![[Yodo1Commons territory]isEqualToString:@"CN"]){//地域
        isCNTerritory = false;
    }
    NSString *code = carrier.isoCountryCode;
    if(use && code){//有Sim卡
        if(![code isEqualToString:@"cn"]){
            isCNSimKa = false;
        }
        if (!isCNSimKa) {
            return false;
        }
        return true;
    }
    if (!isCNTerritory) {
        return false;
    }
    return true;
}

}
#endif
