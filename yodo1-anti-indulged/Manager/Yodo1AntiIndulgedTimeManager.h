//
//  Yodo1AntiIndulgedTimeManager.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/5.
//

#import <Foundation/Foundation.h>
#import "Yodo1AntiIndulgedHelper.h"
#import "Yodo1AntiIndulgedRecord.h"

NS_ASSUME_NONNULL_BEGIN

/// 时间管理
@interface Yodo1AntiIndulgedTimeManager : NSObject

@property (nonatomic, strong, readonly) Yodo1AntiIndulgedRecord *record;

+ (Yodo1AntiIndulgedTimeManager *)manager;

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
- (void)postPlayTime:(NSTimeInterval)time;

@end

NS_ASSUME_NONNULL_END
