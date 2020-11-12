//
//  Yodo1AntiAddictionTimeManager.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/5.
//

#import <Foundation/Foundation.h>
#import "Yodo1AntiAddictionHelper.h"
#import "Yodo1AntiAddictionRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// 时间管理
@interface Yodo1AntiAddictionTimeManager : NSObject

@property (nonatomic, strong, readonly) Yodo1AntiAddictionRecord *record;

+ (Yodo1AntiAddictionTimeManager *)manager;

/// 开启计时
/// 当前无登录用户时，忽略
/// 已开启计时时，忽略
- (void)startTimer;
/// 停止计时，同时会上报时间
/// 无正在计时的任务，忽略
- (void)stopTimer;
/// 是否正在计时，未登录则默认NO
- (BOOL)isTimer;

- (NSTimeInterval)getNowTime;
- (NSDate *)getNowDate;
- (void)postPlayTime:(BOOL)start time:(NSTimeInterval)time success:(void (^)(void))success failure:(void (^)(void))failure;

@end

NS_ASSUME_NONNULL_END
