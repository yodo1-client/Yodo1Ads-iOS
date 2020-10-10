//
//  Yodo1AntiIndulgedRulesManager.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import "Yodo1AntiIndulgedRulesManager.h"
#import "Yodo1AntiIndulgedNet.h"
#import <Yodo1YYModel/Yodo1Model.h>
#import <Yodo1OnlineParameter/Yodo1Tool.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Commons.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Storage.h>

#define kAntiIndulgedRules @"Yodo1AntiIndulgedRules" // 规则
#define kAntiIndulgedHolidays @"Yodo1AntiIndulgedHolidays" // 节假日列表
#define kAntiIndulgedHolidayRules @"Yodo1AntiIndulgedHolidayRules" // 节假日规则

@implementation Yodo1AntiIndulgedRulesManager

+ (Yodo1AntiIndulgedRulesManager *)manager {
    static Yodo1AntiIndulgedRulesManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiIndulgedRulesManager alloc] init];
    });
    return sharedInstance;
}

- (void)requestRules:(void (^ _Nullable)(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    
    _currentRules = (Yodo1AntiIndulgedRules *)[Yd1OpsTools.cached objectForKey:kAntiIndulgedRules];
    if (!_currentRules) {
        NSString *pathName = @"Yodo1AntiIndulgedConfig.bundle/Yodo1AntiIndulgedRules";
        NSString *path = [NSBundle.mainBundle pathForResource:pathName ofType:@"plist"];
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];
        _currentRules = [Yodo1AntiIndulgedRules yodo1_modelWithDictionary:data];
    }
    
    [[Yodo1AntiIndulgedNet manager] GET:@"config/info" parameters:nil success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        Yodo1AntiIndulgedRules *rules = [Yodo1AntiIndulgedRules yodo1_modelWithJSON:res.data];
        if (rules) {
            NSLog(@"获取规则 - %@", res.data);
            self->_currentRules = rules;
            [Yd1OpsTools.cached setObject:rules forKey:kAntiIndulgedRules];
        }
        if (success) {
            success(rules);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

/// 节假日规则
- (void)requestHolidayRules:(void (^ _Nullable)(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    
    _holidayRules = (Yodo1AntiIndulgedHolidayRules *)[Yd1OpsTools.cached objectForKey:kAntiIndulgedHolidayRules];
    if (!_holidayRules) {
        NSString *pathName = @"Yodo1AntiIndulgedConfig.bundle/Yodo1AntiIndulgedHolidayRules";
        NSString *path = [NSBundle.mainBundle pathForResource:pathName ofType:@"plist"];
        NSDictionary *data = [NSDictionary dictionaryWithContentsOfFile:path];
        _holidayRules = [Yodo1AntiIndulgedHolidayRules yodo1_modelWithDictionary:data];
    }
    [[Yodo1AntiIndulgedNet manager] GET:@"config/holiday" parameters:nil success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.data) {
            Yodo1AntiIndulgedHolidayRules *rules = [Yodo1AntiIndulgedHolidayRules yodo1_modelWithJSON:res.data];
            if (rules) {
                [Yd1OpsTools.cached setObject:rules forKey:kAntiIndulgedHolidayRules];
            }
            NSLog(@"获取节假日规则 - %@", res.data);
        }
        if (success) {
            success(res.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


/// 节假日列表
- (void)requestHolidayList:(void (^ _Nullable)(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure {
    
    _holidays = (NSArray *)[Yd1OpsTools.cached objectForKey:kAntiIndulgedHolidays];
    if (!_holidays) {
        NSString *pathName = @"Yodo1AntiIndulgedConfig.bundle/Yodo1AntiIndulgedHolidays";
        NSString *path = [NSBundle.mainBundle pathForResource:pathName ofType:@"plist"];
        _holidays = [NSArray arrayWithContentsOfFile:path];
    }
    
    [[Yodo1AntiIndulgedNet manager] GET:@"config/holidays" parameters:nil success:^(NSURLSessionDataTask *task, id data) {
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:data];
        if (res.data) {
            [Yd1OpsTools.cached setObject:res.data forKey:kAntiIndulgedHolidays];
            NSLog(@"获取节假日列表 - %@", res.data);
        }
        if (success) {
            success(res.data);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
