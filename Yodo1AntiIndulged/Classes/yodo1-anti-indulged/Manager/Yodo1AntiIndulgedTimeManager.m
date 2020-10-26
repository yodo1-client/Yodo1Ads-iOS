//
//  Yodo1AntiIndulgedTimeManager.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/5.
//

#import "Yodo1AntiIndulgedTimeManager.h"
#import "Yodo1AntiIndulgedRulesManager.h"
#import "Yodo1AntiIndulgedUserManager.h"
#import "Yodo1AntiIndulgedDatabase.h"
#import "Yodo1AntiIndulgedNet.h"
#import <Yodo1Reachability/Yodo1Reachability.h>
#import <Yodo1YYModel/Yodo1Model.h>
#import <Toast/Toast.h>

#import "Yodo1AntiIndulgedUtils.h"
#import "Yodo1AntiIndulgedDialogVC.h"

typedef enum: NSInteger {
    CheckActionNone = 0,
    CheckActionNotification = 1,
    CheckActionStop = 2
} CheckAction;

@implementation Yodo1AntiIndulgedTimeManager {
    
    dispatch_source_t timer; // 计时器
    
    NSTimeInterval serverTime; // 服务器时间
    NSTimeInterval serverTimer; // 获取服务器时间后的计时
    
    NSMutableSet *notifyList;
}

+ (Yodo1AntiIndulgedTimeManager *)manager {
    static Yodo1AntiIndulgedTimeManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiIndulgedTimeManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        notifyList = [NSMutableSet set];
        
        // 监听网络变化
        __weak __typeof(self)weakSelf = self;
        [Yodo1Reachability reachability].notifyBlock = ^(Yodo1Reachability *reachability) {
            [weakSelf didNeedGetAppTime];
        };
        // 监听进入前台
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNeedGetAppTime) name:UIApplicationDidBecomeActiveNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopTimer];
}

- (void)didNeedGetAppTime {
    [self getAppTime:NO success:nil failure:nil];
}

#pragma mark - Public
/// 开启计时
- (void)startTimer {
    // 当前有计时不会开启新的计时
    if ([self isTimer]) {
        return;
    }
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    // 无登录用户不会开启计时
    if (user == nil) {
        return;
    }
    // 成年人不会开启计时
    if (user.certificationStatus == UserCertificationStatusAault) {
        return;
    }
    // 在获取服务器时间后开启计时
    [self getAppTime:YES success:^ {
        [self _startTimer];
    } failure:^{
        [self _startTimer];
    }];
}

- (void)_startTimer {
    
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    
    // 查询本地数据 没有则创建一条
    NSString *date = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];
    _record = [self get:user.accountId date:user.certificationStatus == UserCertificationStatusMinor ? date : nil];
    if (_record) {
        // 如果有本地数据 且为游客 每15天重置试玩时间
        if (user.certificationStatus == UserCertificationStatusNot) {
            NSTimeInterval interval = [self getNowTime] - _record.createTime;
            if ((interval / (3600 * 24)) >= rules.guestModeConfig.effectiveDay) {
                _record.leftTime = rules.guestModeConfig.playingTime;
                _record.playingTime = 0;
                _record.awaitTime = 0;
            }
        }
    } else {
        _record = [[Yodo1AntiIndulgedRecord alloc] init];
        _record.accountId = user.accountId;
        _record.date = date;
        _record.createTime = [self getNowTime];
        _record.playingTime = 0;
        _record.awaitTime = 0;
        
        // 初始可玩时间
        if (user.certificationStatus == UserCertificationStatusNot) {
            _record.leftTime = rules.guestModeConfig.playingTime;
        } else {
            NSTimeInterval holidayTime = 10800;
            NSTimeInterval regularTime = 5400;
            for (GroupPlayingTime *range in rules.groupPlayingTimeList) {
                if ([Yodo1AntiIndulgedUtils age:user.age inRange:range.ageRange]) {
                    holidayTime = range.holidayTime;
                    regularTime = range.regularTime;
                }
            }
            NSString *today = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];
            BOOL isHoliday = [[Yodo1AntiIndulgedRulesManager manager].holidays indexOfObject:today] != NSNotFound;
            NSTimeInterval duration = isHoliday ? holidayTime : regularTime;
            _record.leftTime = duration;
        }
        
        [self insert:_record];
    }
    
    
    
    NSTimeInterval delay = 0.0f; // 延迟时间
    NSTimeInterval interval = 1.0f; // 间隔时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 设置延时
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    // 设置计时
    dispatch_source_set_timer(timer, startDelayTime, interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
    // 处理事件
    __weak __typeof(self)weakSelf = self;
    dispatch_source_set_event_handler(timer, ^{
        [weakSelf handleTimer];
    });
    
    if (_record.awaitTime > 0) {
        // 如果有未上报的时间则上报一次时间 然后开始计时
        [self postPlayTime:YES time:_record.awaitTime success:^{
            dispatch_resume(self -> timer);
        } failure:^{
            dispatch_resume(self -> timer);
        }];
    } else {
        // 获取可玩时间后开始计时
        [self getPlayTime:YES success:^{
            dispatch_resume(self -> timer);
        } failure:^{
            dispatch_resume(self -> timer);
        }];
    }
}

- (void)stopTimer {
    if (timer != nil) {
        dispatch_source_cancel(timer);
    }
    timer = nil;
    [notifyList removeAllObjects];
    if (_record.awaitTime > 0) { // 上报一次时间
        [self postPlayTime:NO time:_record.awaitTime success:nil failure:nil];
    }
}

- (BOOL)isTimer {
    return timer != nil;
}

- (NSTimeInterval)getNowTime {
    return serverTime + serverTimer;
}

- (NSDate *)getNowDate {
    return [NSDate dateWithTimeIntervalSince1970: [self getNowTime]];
}

#pragma mark - Method
/// 处理计时
- (void)handleTimer {
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    id<Yodo1AntiIndulgedDelegate> delegate = [Yodo1AntiIndulgedHelper shared].delegate;
    
    // 先检查是否在禁玩时间
    CheckAction forbidden = [self checkForbiddenTime];
    if (forbidden != CheckActionNone) {
        
        dispatch_async(dispatch_get_main_queue(),^{
            if (forbidden == CheckActionNotification) {
                // 提醒
                if (self->notifyList.count == 0) {
                    Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                    event.eventCode = Yodo1AntiIndulgedEventCodeMinorForbiddenTime;
                    event.action = Yodo1AntiIndulgedActionResumeGame;
                    event.title = @"提示";
                    event.content = rules.antiPlayingTimeMsg.beforeMsg;
                    if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                        if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                            [[Yodo1AntiIndulgedUtils getTopWindow] makeToast:event.content duration:0.2 position:CSToastPositionTop];
                        }
                    }
                    [self->notifyList addObject:event];
                }
            } else if (forbidden == CheckActionStop) {
                // 结束
                Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                event.eventCode = Yodo1AntiIndulgedEventCodeMinorForbiddenTime;
                event.action = Yodo1AntiIndulgedActionEndGame;
                event.title = @"提示";
                event.content = rules.antiPlayingTimeMsg.message;
                
                // 禁玩时段的通知 通过onTimeLimitNotify接口返回
                if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                    if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                        [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleTimeDisable error:nil];
                    }
                }
            }
        });
        // 如果已在禁玩时间 停止计时
        if (forbidden == CheckActionStop) {
            [self stopTimer];
            return;
        }
    }
    
    // 检测是否已到可玩时间
    CheckAction end = [self checkEndTime];
    if (end != CheckActionNone) {
        
        dispatch_async(dispatch_get_main_queue(),^{
            if (end == CheckActionNotification) {
                // 提醒
                if (self->notifyList.count == 0) {
                    Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                    if (user.certificationStatus == UserCertificationStatusMinor) {
                        event.eventCode = Yodo1AntiIndulgedEventCodeMinorPlayedTime;
                        event.action = Yodo1AntiIndulgedActionResumeGame;
                        event.title = @"提示";
                        event.content = rules.playingTimeMsg.beforeMsg;
                        if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                            if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                                [[Yodo1AntiIndulgedUtils getTopWindow] makeToast:event.content duration:0.2 position:CSToastPositionTop];
                            }
                        }
                    } else {
                        event.eventCode = Yodo1AntiIndulgedEventCodeGuestPlayedTime;
                        event.action = Yodo1AntiIndulgedActionResumeGame;
                        event.title = @"提示";
                        event.content = rules.guestModeMsg.beforeMsg;
                        if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                            if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                                [[Yodo1AntiIndulgedUtils getTopWindow] makeToast:event.content duration:0.2 position:CSToastPositionTop];
                            }
                        }
                    }
                    [self->notifyList addObject:event];
                }
            } else if (end == CheckActionStop) {
                // 结束
                Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                if (user.certificationStatus == UserCertificationStatusMinor) {
                    event.eventCode = Yodo1AntiIndulgedEventCodeMinorPlayedTime;
                    event.action = Yodo1AntiIndulgedActionEndGame;
                    event.title = @"提示";
                    event.content = rules.playingTimeMsg.message;
                    if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                        if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                            [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleTimeOverstep error:nil];
                        }
                    }
                } else {
                    event.eventCode = Yodo1AntiIndulgedEventCodeGuestPlayedTime;
                    event.action = Yodo1AntiIndulgedActionEndGame;
                    event.title = @"提示";
                    event.content = rules.guestModeMsg.message;
                    if (delegate && [delegate respondsToSelector:@selector(onTimeLimitNotify:title:message:)]) {
                        if (![delegate onTimeLimitNotify:event title:event.title message:event.content]) {
                            [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleVisitorOver error:nil];
                        }
                    }
                }
            }
        });
        
        if (end == CheckActionStop) {
            [self stopTimer];
            return;
        }
    }
    
    serverTimer += 1;
    _record.awaitTime += 1;
    _record.playingTime += 1;
    _record.leftTime -= 1;
    
    if (_record.leftTime <= 0) {
        _record.leftTime = 0;
    }
    
    // 每10秒保存一次本地数据
    NSInteger leftTime = _record.leftTime;
    if (leftTime % 10 == 0) {
        [self update:_record];
    }
    
    // 每5分钟上报一次数据
    if (_record.awaitTime > 30) {
        [self postPlayTime:NO time:_record.awaitTime success:nil failure:nil];
    } else if (_record.awaitTime == 0) {
        [self getPlayTime:NO success:nil failure:nil];
    }
    
    // 每隔30分钟更新一次规则
    if (leftTime % 1800 == 0) {
        [self updateRule];
    }
}

//
- (CheckAction)checkForbiddenTime {
    
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;

    NSDate *serverTime = [self getNowDate];
    NSInteger current = [Yodo1AntiIndulgedUtils timeToInt:[Yodo1AntiIndulgedUtils dateString:serverTime format:@"HH:mm"]];
    
    if (user.certificationStatus == UserCertificationStatusMinor) {
        // 查询是否在可玩时段内
        NSArray<NSString *> *limtRange;
        for (GroupAntiPlayingTimeRange *range in rules.groupAntiPlayingTimeRangeList) {
            if ([Yodo1AntiIndulgedUtils age:user.age inRange:range.ageRange]) {
                limtRange = range.antiPlayingTimeRange;
                break;
            }
        }
        
        if (limtRange) {
            NSRange timeRange = NSMakeRange(0, 0);
            for (NSString *time in limtRange) {
                NSRange range = [Yodo1AntiIndulgedUtils time:current inRange:time];
                if (range.location != 0 && range.length != 0) {
                    timeRange = range;
                } 
            }
            // 没有匹配可玩时间，直接认为是在非可玩时段
            if (timeRange.location == 0 && timeRange.length == 0) {
                return CheckActionStop;
            }
            if (current >= timeRange.location && current <= timeRange.location + timeRange.length) {
                if (NSMaxRange(timeRange) == current) {
                    return CheckActionStop;
                } else if (NSMaxRange(timeRange) - current < 10) {
                    return CheckActionNotification;
                }
            } else {
                return CheckActionStop;
            }
        } else {
            // 没有匹配年龄，直接认为是在非可玩时段
            return CheckActionStop;
        }
    }
    return CheckActionNone;
}

- (CheckAction)checkEndTime {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    NSTimeInterval residue = 600;
    if (user.certificationStatus == UserCertificationStatusMinor) {
        // 匹配可玩时间
        NSTimeInterval holidayTime = 10800;
        NSTimeInterval regularTime = 5400;
        for (GroupPlayingTime *range in rules.groupPlayingTimeList) {
            if ([Yodo1AntiIndulgedUtils age:user.age inRange:range.ageRange]) {
                holidayTime = range.holidayTime;
                regularTime = range.regularTime;
            }
        }
        
        NSString *today = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];
        BOOL isHoliday = [[Yodo1AntiIndulgedRulesManager manager].holidays indexOfObject:today] != NSNotFound;
        NSTimeInterval duration = isHoliday ? holidayTime : regularTime;
        
        if (duration - _record.playingTime <= 0 || _record.leftTime <= 0) {
            return CheckActionStop;
        } else if (duration - _record.playingTime <= residue || (_record.leftTime <= residue && _record.leftTime > 0)) {
            return CheckActionNotification;
        }
    } else {
        NSTimeInterval duration = rules.guestModeConfig.playingTime;
        if (duration - _record.playingTime <= 0 || _record.leftTime <= 0) {
            return CheckActionStop;
        } else if (duration - _record.playingTime <= residue || (_record.leftTime <= residue && _record.leftTime > 0)) {
            return CheckActionNotification;
        }
    }
    return CheckActionNone;
}


/// 获取服务器时间
/// start 是否器开始计时的第一次请求
- (void)getAppTime:(BOOL)start success:(void (^)(void))success failure:(void (^)(void))failure {

    [[Yodo1AntiIndulgedNet manager] GET:@"time/getAppTime" parameters:nil success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data) {
            id time = res.data[@"currentTime"];
            if (time) {
                NSTimeInterval serverTime = [time longLongValue] / 1000;
                self -> serverTime = serverTime;
                self -> serverTimer = 0;
                if (success) {
                    success();
                }
            } else {
                self -> serverTime = [NSDate date].timeIntervalSince1970;
                self -> serverTimer = 0;
                if (failure) {
                    failure();
                }
            }
        } else {
            self -> serverTime = [NSDate date].timeIntervalSince1970;
            self -> serverTimer = 0;
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        self -> serverTime = [NSDate date].timeIntervalSince1970;
        self -> serverTimer = 0;
        if (failure) {
            failure();
        }
    }];
}

/// 获取已完时间
- (void)getPlayTime:(BOOL)start success:(void (^)(void))success failure:(void (^)(void))failure {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    if (user == nil || user.certificationStatus == UserCertificationStatusAault) {
        return;
    }
    
    [[Yodo1AntiIndulgedNet manager] GET:@"time/getPlayingTime" parameters:@{@"businessType" : (user.certificationStatus == UserCertificationStatusMinor ? @1 : @2)} success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data && self->_record) {
            // 服务器时间
            id serverTime = res.data[@"currentTimer"];
            if (serverTime) {
                self -> serverTime = [serverTime longLongValue] / 1000;
                self -> serverTimer = 0;
            }
            
            // 已玩时间
            id playingTime = res.data[@"playingTime"];
            if (playingTime) {
                self->_record.playingTime = [playingTime doubleValue];
            }
            
            // 剩余时间
            id leftTime = res.data[@"leftTime"];
            if (leftTime) {
                self->_record.leftTime = [leftTime doubleValue];
            }
            [self update:self->_record];
            
            if (success) {
                success();
            }
        } else {
            self -> serverTime = [NSDate date].timeIntervalSince1970;
            self -> serverTimer = 0;
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        self -> serverTime = [NSDate date].timeIntervalSince1970;
        self -> serverTimer = 0;
        if (failure) {
            failure();
        }
    }];
}

/// 上报时间
- (void)postPlayTime:(BOOL)start time:(NSTimeInterval)time success:(void (^)(void))success failure:(void (^)(void))failure {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    if (user == nil) {
        return;
    }
    
    NSString *date = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];
    NSString *sign = [Yodo1AntiIndulgedUtils md5String:[NSString stringWithFormat:@"anti%@", date]];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"businessType"] = user.certificationStatus == UserCertificationStatusMinor ? @1 : @2;
    parameters[@"happenDate"] = date;
    parameters[@"playingTime"] = @((NSInteger)time);
    parameters[@"sign"] = sign;
    
    [[Yodo1AntiIndulgedNet manager] POST:@"time/reportPlayingTime" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data) {
            
            // 服务器时间
            id serverTime = res.data[@"currentTimer"];
            if (serverTime) {
                self -> serverTime = [serverTime longLongValue] / 1000;
                self -> serverTimer = 0;
            }
            
            // 已玩时间
            id playingTime = res.data[@"playingTime"];
            if (playingTime) {
                self->_record.playingTime = [playingTime doubleValue];
                NSTimeInterval awaitTime = self->_record.awaitTime - time;
                if (awaitTime < 0) {
                    awaitTime = 0;
                }
                self->_record.awaitTime = awaitTime;
            }
            
            // 剩余时间
            id leftTime = res.data[@"leftTime"];
            if (leftTime) {
                self->_record.leftTime = [leftTime doubleValue];
            }
            [self update:self->_record];
            if (success) {
                success();
            }
        } else {
            self -> serverTime = [NSDate date].timeIntervalSince1970;
            self -> serverTimer = 0;
            if (failure) {
                failure();
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        self -> serverTime = [NSDate date].timeIntervalSince1970;
        self -> serverTimer = 0;
        if (failure) {
            failure();
        }
    }];
}
/// 更新规则
- (void)updateRule {
    [[Yodo1AntiIndulgedRulesManager manager] requestRules:nil failure:nil];
}

#pragma mark - 数据库操作
- (Yodo1AntiIndulgedRecord *)get:(NSString *)accountId date:(NSString *)date {
    
    NSMutableString *where = [NSMutableString string];
    NSMutableArray *args = [NSMutableArray array];
    [where appendString:@"accountId = ?"];
    [args addObject:accountId];
    if (date) {
        [where appendString:@" AND "];
        [where appendString:@"date = ?"];
        [args addObject:date];
    }
    
    FMResultSet *result = [[Yodo1AntiIndulgedDatabase shared] query:NSStringFromClass([Yodo1AntiIndulgedRecord class]) projects:nil where:where args:args order:nil];
    if ([result next]) {
        return [Yodo1AntiIndulgedRecord yodo1_modelWithDictionary:result.resultDictionary];
    }
    return nil;
}

- (BOOL)insert:(Yodo1AntiIndulgedRecord *)record {
    
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    content[@"accountId"] = record.accountId;
    if (record.date) content[@"date"] = record.date;
    content[@"createTime"] = @(record.createTime);
    content[@"leftTime"] = @(record.leftTime);
    content[@"playingTime"] = @(record.playingTime);
    content[@"awaitTime"] = @(record.awaitTime);
    
    return [[Yodo1AntiIndulgedDatabase shared] insertInto:NSStringFromClass([Yodo1AntiIndulgedRecord class]) content:content];
}

- (BOOL)update:(Yodo1AntiIndulgedRecord *)record {
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    content[@"createTime"] = @(record.createTime);
    content[@"leftTime"] = @(record.leftTime);
    content[@"playingTime"] = @(record.playingTime);
    content[@"awaitTime"] = @(record.awaitTime);
    
    NSLog(@"更新一次计时 - %@", content);
    
    NSMutableString *where = [NSMutableString string];
    NSMutableArray *args = [NSMutableArray array];
    [where appendString:@"accountId = ?"];
    [args addObject:record.accountId];
    [where appendString:@" AND "];
    if (record.date) {
        [where appendString:@"date = ?"];
        [args addObject:record.date];
    } else {
        [where appendString:@"date IS NULL"];
    }
    
    return [[Yodo1AntiIndulgedDatabase shared] update:NSStringFromClass([Yodo1AntiIndulgedRecord class]) content:content where:where args:args];
}

- (BOOL)delete:(NSString *)accountId date:(NSString *)date {
    
    NSMutableString *where = [NSMutableString string];
    NSMutableArray *args = [NSMutableArray array];
    [where appendString:@"accountId = ?"];
    [args addObject:_record.accountId];
    [where appendString:@" AND "];
    if (date) {
        [where appendString:@"date = ?"];
        [args addObject:_record.date];
    } else {
        [where appendString:@"date IS NULL"];
    }
    
    return [[Yodo1AntiIndulgedDatabase shared] deleteFrom:NSStringFromClass([Yodo1AntiIndulgedRecord class]) where:where args:args];
}

@end
