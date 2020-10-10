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
#import <Yodo1YYModel/Yodo1Model.h>
#import <Toast/Toast.h>

#import "Yodo1AntiIndulgedUtils.h"
#import "Yodo1AntiIndulgedDialogVC.h"

@implementation Yodo1AntiIndulgedTimeManager {
    dispatch_source_t timer; // 计时器
    NSTimeInterval start; // 计时开始时间
    NSTimeInterval save; // 记录保存时间
    NSTimeInterval serverTime; // 服务器时间
    NSTimeInterval booteTime; // 核查时间
    NSTimeInterval getServerRequestTime; // 获取服务器请求时间
    NSTimeInterval getPlayRequestTime; // 获取已玩请求时间
    NSTimeInterval postPlayRequestTime; // 上报已玩请求时间
    NSTimeInterval updateRulesRequestTime; // 更新规则请求时间
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
    }
    return self;
}

- (void)dealloc {
    [self stopTimer];
}

- (void)startTimer {
    // 当前有计时不会开启新的计时
    if ([self isTimer]) {
        return;
    }
    
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    // 无登录用户不会开启计时
    if (user == nil) {
        return;
    }
    // 成年人不会开启计时
    if (user.certificationStatus == UserCertificationStatusAault) {
        return;
    }
    
    NSString *date = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];

    _record = [self get:user.accountId date:user.certificationStatus == UserCertificationStatusMinor ? date : nil];
    if (!_record) {
        _record = [[Yodo1AntiIndulgedRecord alloc] init];
        _record.accountId = user.accountId;
        _record.date = date;
        _record.leftTime = rules.guestModeConfig.playingTime;
        [self insert:_record];
    }
    
    if (user.certificationStatus == UserCertificationStatusNot) {
        NSInteger effectiveDay = 15;
        NSTimeInterval leftTime = 3600;
        if (rules) {
            effectiveDay = rules.guestModeConfig.effectiveDay;
            leftTime = rules.guestModeConfig.playingTime;
        }
        NSTimeInterval interval = [NSDate date].timeIntervalSince1970 - _record.createTime;
        if ((interval / (3600 * 24)) >= 15) {
            _record.leftTime = leftTime;
            _record.playingTime = 0;
            _record.awaitTime = 0;
        }
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
    // 启动计时
    start = [NSDate date].timeIntervalSince1970;
    save = start;
    [self getAppTime];
    [self getPlayTime];
    dispatch_resume(timer);
}

- (void)stopTimer {
    // 上报一次时间
    if (timer != nil) {
        dispatch_source_cancel(timer);
    }
    timer = nil;
    [notifyList removeAllObjects];
    if (_record.awaitTime > 0) {
        [self postPlayTime: _record.awaitTime];
    }
}

- (BOOL)isTimer {
    return timer != nil;
}

- (NSTimeInterval)getNowTime {
    return serverTime + ([NSDate date].timeIntervalSince1970 - booteTime);
}

- (NSDate *)getNowDate {
    return [NSDate dateWithTimeIntervalSince1970: [self getNowTime]];
}


#pragma mark - Method
/// 处理计时
- (void)handleTimer {
    // 每隔5分钟上报一次时间
    _record.awaitTime += 1;
    _record.playingTime += 1;
    _record.leftTime -= 1;
    
    if (_record.leftTime <= 0) {
        _record.leftTime = 0;
    }
    
    NSTimeInterval now = [NSDate date].timeIntervalSince1970;
    if (now - save >= 30) {
        save = now;
        [self update:_record];
    }
    
    if (now - postPlayRequestTime >= 300) {
        if (_record.awaitTime > 0) {
            [self postPlayTime:_record.awaitTime];
        } else {
            [self getPlayTime];
        }
    }
    // 每隔30分钟更新一次规则
    if (now - updateRulesRequestTime >= 1800) {
        [self updateRule];
    }
    
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    id<Yodo1AntiIndulgedDelegate> delegate = [Yodo1AntiIndulgedHelper shared].delegate;
    NSInteger forbidden = [self checkForbiddenTime];
    if (forbidden != 0) {
        if (forbidden == 2) {
            [self stopTimer];
        }
        dispatch_async(dispatch_get_main_queue(),^{
            if (forbidden == 1) {
                // 提醒
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
                
            } else if (forbidden == 2) {
                // 结束
                Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
                event.eventCode = Yodo1AntiIndulgedEventCodeMinorForbiddenTime;
                event.action = Yodo1AntiIndulgedActionEndGame;
                event.title = @"提示";
                event.content = rules.antiPlayingTimeMsg.message;
                if (![[Yodo1AntiIndulgedHelper shared] successful: event]) {
                    [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleTimeDisable error:nil];
                }
            }
        });
    } else {
        NSInteger end = [self checkEndTime];
        if (end != 0) {
            if (end == 2) {
                [self stopTimer];
            }
            dispatch_async(dispatch_get_main_queue(),^{
                if (end == 1) {
                    // 提醒
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
                } else if (end == 2) {
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
        }
    }
}

//
- (NSInteger)checkForbiddenTime {
    
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
            NSRange timeRange = NSMakeRange(480, 840);
            for (NSString *time in limtRange) {
                NSRange range = [Yodo1AntiIndulgedUtils time:current inRange:time];
                if (range.location != 0 && range.length != 0) {
                    timeRange = range;
                } 
            }
            // 没有匹配可玩时间，直接认为是在非可玩时段
            if (timeRange.location == 0 && timeRange.length == 0) {
                return 2;
            } 
            if (NSMaxRange(timeRange) == current) {
                return 2;
            } else if (NSMaxRange(timeRange) - current < 600) {
                return 1;
            }
        } else {
            // 没有匹配年龄，直接认为是在非可玩时段
            return 2;
        }
    }
    return 0;
}

- (NSInteger)checkEndTime {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRulesManager manager].currentRules;
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
            return 2;
        } else if (duration - _record.playingTime <= 600 || (_record.leftTime <= 600 && _record.leftTime > 0)) {
            return 1;
        }
    } else {
        NSTimeInterval duration = rules.guestModeConfig.playingTime;
        if (duration - _record.playingTime <= 0 || _record.leftTime <= 0) {
            return 2;
        } else if (duration - _record.playingTime <= 600 || (_record.leftTime <= 600 && _record.leftTime > 0)) {
            return 1;
        }
    }
    return 0;
}


/// 获取服务器时间
- (void)getAppTime {
    getServerRequestTime = [NSDate date].timeIntervalSince1970;
    serverTime = getServerRequestTime;
    booteTime = getServerRequestTime;
    
    [[Yodo1AntiIndulgedNet manager] GET:@"time/getAppTime" parameters:nil success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data) {
            id time = res.data[@"currentTime"];
            if (time) {
                self->serverTime = [time longLongValue] / 1000;
                self->booteTime = [NSDate date].timeIntervalSince1970;
            }
            NSLog(@"获取服务器时间 - %@", res.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        
    }];
}

/// 获取已完时间
- (void)getPlayTime {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    if (user == nil || user.certificationStatus == UserCertificationStatusAault) {
        return;
    }
    getPlayRequestTime = [NSDate date].timeIntervalSince1970;
    [[Yodo1AntiIndulgedNet manager] GET:@"time/getPlayingTime" parameters:@{@"businessType" : (user.certificationStatus == UserCertificationStatusMinor ? @1 : @2)} success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data && self->_record) {
            id playingTime = res.data[@"playingTime"];
            if (playingTime) {
                self->_record.playingTime = [playingTime doubleValue];
                self->_record.awaitTime = [NSDate date].timeIntervalSince1970 - self->getPlayRequestTime;
            }
            id leftTime = res.data[@"leftTime"];
            if (leftTime) {
                self->_record.leftTime = [leftTime integerValue];
            }
            [self update:self->_record];
            NSLog(@"获取已玩时间 - %@", res.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError * error) {
        
    }];
}

/// 上报时间
- (void)postPlayTime:(NSTimeInterval)time {
    Yodo1AntiIndulgedUser *user = [Yodo1AntiIndulgedUserManager manager].currentUser;
    if (user == nil) {
        return;
    }
    
    NSString *date = [Yodo1AntiIndulgedUtils dateString:[self getNowDate]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"businessType"] = user.certificationStatus == UserCertificationStatusMinor ? @1 : @2;
    parameters[@"happenDate"] = date;
    parameters[@"playingTime"] = @((NSInteger)time);
    parameters[@"sign"] = [Yodo1AntiIndulgedUtils md5String:[NSString stringWithFormat:@"anti%@", date]];
    
    postPlayRequestTime = [NSDate date].timeIntervalSince1970;
    [[Yodo1AntiIndulgedNet manager] POST:@"time/reportPlayingTime" parameters:parameters success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.success && res.data) {
            id playingTime = res.data[@"playingTime"];
            if (playingTime) {
                self->_record.playingTime = [playingTime doubleValue];
                self->_record.awaitTime = [NSDate date].timeIntervalSince1970 - self->postPlayRequestTime;
            }
            id leftTime = res.data[@"leftTime"];
            if (leftTime) {
                self->_record.leftTime = [leftTime integerValue];
            }
            [self update:self->_record];
            NSLog(@"上报已玩时间 - %@", res.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
    }];
}
/// 更新规则
- (void)updateRule {
    updateRulesRequestTime = [NSDate date].timeIntervalSince1970;
    [[Yodo1AntiIndulgedRulesManager manager] requestRules:^(id data) {
        
    } failure:^(NSError *error) {
        
    }];
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
