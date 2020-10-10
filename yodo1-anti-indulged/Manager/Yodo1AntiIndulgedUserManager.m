//
//  Yodo1AntiIndulgedUserManager.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import "Yodo1AntiIndulgedUserManager.h"
#import <Yodo1YYModel/Yodo1Model.h>
#import <Yodo1YYCache/Yodo1YYCache.h>
#import <Yodo1OnlineParameter/Yodo1Tool.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Commons.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Storage.h>
#import "Yd1UCenter.h"
#import "Yd1UCenterManager.h"
#import "Yodo1AntiIndulgedDatabase.h"
#import "Yodo1AntiIndulgedNet.h"
#import "Yodo1AntiIndulgedHelper.h"
#import "Yodo1AntiIndulgedUtils.h"

#define TABLE_NAME NSStringFromClass([Yodo1AntiIndulgedUser class])

@implementation Yodo1AntiIndulgedUserManager

+ (Yodo1AntiIndulgedUserManager *)manager {
    static Yodo1AntiIndulgedUserManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiIndulgedUserManager alloc] init];
    });
    return sharedInstance;
}

- (BOOL)isGuestUser {
    return _currentUser.certificationStatus == UserCertificationStatusNot || _currentUser.age == -1;
}

#pragma mark - 网络请求
- (void)get:(NSString *)accountId success:(void (^)(Yodo1AntiIndulgedUser *))success failure:(void (^)(NSError *))failure {
    
    // 查询已存在的用户信息，如果没有则保存一条
    Yodo1AntiIndulgedUser *antiUser = [self query:accountId];
    if (!antiUser) {
        antiUser = [[Yodo1AntiIndulgedUser alloc] init];
        antiUser.accountId = accountId;
        antiUser.certificationStatus = UserCertificationStatusNot;
        [self insert:antiUser];
    }
    
    BOOL isLogined = [Yd1UCenterManager shared].isLogined;
    YD1User *yd1User = [Yd1UCenterManager shared].user;
    // 如果UserCenter已登录
    if (isLogined && yd1User && [yd1User.yid isEqualToString:antiUser.yid]) {
        antiUser.yid = yd1User.yid;
        antiUser.uid = yd1User.uid;
        [self update:antiUser];
    }
    // 如果要登录的用户和当前登录的用户不一致，则停止计时
    if (![antiUser isEqual:_currentUser]) {
        [[Yodo1AntiIndulgedHelper shared] stopTimer];
    }
    _currentUser = antiUser;
    
    if (antiUser.yid) {
        [self getCertificationInfo:antiUser success:success failure:failure];
    } else {
        [[Yd1UCenter shared] deviceLoginWithPlayerId:antiUser.accountId callback:^(YD1User *user, NSError *error) {
            if (!error) {
                
                [Yd1UCenterManager shared].user = user;
                [Yd1UCenterManager shared].isLogined = YES;
                [Yd1OpsTools.cached setObject:user forKey:@"yd1User"];
                antiUser.yid = user.yid;
                antiUser.uid = user.uid;
                [self getCertificationInfo:antiUser success:success failure:failure];
            } else {
                if (failure) {
                    failure(error);
                }
            }
        }];
    }
}

- (void)getCertificationInfo:(Yodo1AntiIndulgedUser *)user success:(void (^)(Yodo1AntiIndulgedUser *))success failure:(void (^)(NSError *))failure {
    
    [[Yodo1AntiIndulgedNet manager] GET:@"certification/info" parameters:nil success:^(NSURLSessionDataTask *task, id response) {
        
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:response];
        id data = res.data;
        if (res.success && data) {
            user.age = [data[@"age"] integerValue];
            user.inWhiteList = [data[@"hasInWhiteList"] boolValue];
            user.certificationStatus = [data[@"status"] integerValue];
            user.certificationTime = [NSDate date].timeIntervalSince1970;
            [self update:user];
            if (success) {
                success(user);
            }
        } else {
            if (success) {
                success(user);
            }
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (success) {
            success(user);
        }
    }];
}

- (void)post:(NSString *)name identify:(NSString *)identify success:(void (^)(id _Nonnull))success failure:(void (^)(NSError * _Nonnull))failure {
    
    [[Yodo1AntiIndulgedNet manager] POST:@"certification/info" parameters:@{@"name": name, @"idCard" : identify} success:^(NSURLSessionDataTask *task, id response) {
        Yodo1AntiIndulgedUser *user = self.currentUser;
        
        Yodo1AntiIndulgedResponse *res = [Yodo1AntiIndulgedResponse yodo1_modelWithJSON:response];
        id data = res.data;
        if (res.success && data) {
            NSInteger status = [data[@"status"] integerValue];
            if (status >= 0) {
                user.age = [data[@"age"] integerValue];
                user.inWhiteList = [data[@"hasInWhiteList"] boolValue];
                user.certificationStatus = status;
                user.certificationTime = [NSDate date].timeIntervalSince1970;
                [self update:user];
            }
            if (success) {
                success(data);
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

#pragma mark - 数据库操作
- (Yodo1AntiIndulgedUser *)query:(NSString *)accountId {
    FMResultSet *result = [[Yodo1AntiIndulgedDatabase shared] query:TABLE_NAME projects:nil where:@"accountId = ?" args:@[accountId] order:nil];
    
    if ([result next]) {
        return [Yodo1AntiIndulgedUser yodo1_modelWithDictionary:result.resultDictionary];
    }
    return nil;
}

- (BOOL)insert:(Yodo1AntiIndulgedUser *)user {
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    content[@"accountId"] = user.accountId;
    if (user.uid) content[@"uid"] = user.uid;
    if (user.yid) content[@"yid"] = user.yid;
    content[@"age"] = @(user.age);
    content[@"inWhiteList"] = @(user.inWhiteList);
    content[@"certificationStatus"] = @(user.certificationStatus);
    content[@"certificationTime"] = @(user.certificationTime);
    return [[Yodo1AntiIndulgedDatabase shared] insertInto:TABLE_NAME content:content];
}

- (BOOL)update:(Yodo1AntiIndulgedUser *)user {
    NSMutableDictionary *content = [NSMutableDictionary dictionary];
    if (user.uid) content[@"uid"] = user.uid;
    if (user.yid) content[@"yid"] = user.yid;
    content[@"age"] = @(user.age);
    content[@"inWhiteList"] = @(user.inWhiteList);
    content[@"certificationStatus"] = @(user.certificationStatus);
    content[@"certificationTime"] = @(user.certificationTime);
    return [[Yodo1AntiIndulgedDatabase shared] update:TABLE_NAME content:content where:@"accountId = ?" args:@[user.accountId]];
}

- (BOOL)delete:(NSString *)accountId {
    return [[Yodo1AntiIndulgedDatabase shared] deleteFrom:TABLE_NAME where:@"accountId = ?" args:@[accountId]];
}

@end
