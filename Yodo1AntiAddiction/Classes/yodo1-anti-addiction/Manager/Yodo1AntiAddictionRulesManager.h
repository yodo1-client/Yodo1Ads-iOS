//
//  Yodo1AntiAddictionRulesManager.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import <Foundation/Foundation.h>
#import "Yodo1AntiAddictionRules.h"

NS_ASSUME_NONNULL_BEGIN

///规则管理
@interface Yodo1AntiAddictionRulesManager : NSObject

+ (Yodo1AntiAddictionRulesManager *)manager;

@property (nonatomic, strong, readonly) Yodo1AntiAddictionRules *currentRules;
@property (nonatomic, strong, readonly) NSArray *holidays;
@property (nonatomic, strong, readonly) Yodo1AntiAddictionHolidayRules *holidayRules;

/// 获取防沉迷规则
- (void)requestRules:( void (^ _Nullable )(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure;

/// 节假日规则
- (void)requestHolidayRules:(void (^ _Nullable)(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure;

/// 节假日列表
- (void)requestHolidayList:(void (^ _Nullable)(id _Nullable))success failure:(void (^ _Nullable)(NSError * _Nonnull))failure;


@end

NS_ASSUME_NONNULL_END
