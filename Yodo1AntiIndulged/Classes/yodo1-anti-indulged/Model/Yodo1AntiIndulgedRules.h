//
//  Yodo1AntiIndulgedRules.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yodo1AntiIndulgedHolidayRules : NSObject<NSSecureCoding>

@property (nonatomic, strong) NSArray<NSString *> *antiPlayingTimeRange;
@property (nonatomic, assign) NSTimeInterval playingTime;

@end

// 提醒消息
@interface Yodo1AntiIndulgedRuleMsg : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *beforeMsg; // 提前10分钟提醒
@property (nonatomic, copy) NSString *message; // 提醒消息

@end

// 可玩时段
@interface GroupAntiPlayingTimeRange : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *ageRange; // 年龄段
@property (nonatomic, retain) NSArray<NSString *> *antiPlayingTimeRange; //可玩时段

@end

// 可玩时长（秒）
@interface GroupPlayingTime : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *ageRange;
@property (nonatomic, assign) NSTimeInterval holidayTime; // 节假日可玩时长
@property (nonatomic, assign) NSTimeInterval regularTime; // 平时可玩时长

@end

// 限制消费
@interface GroupMoneyLimitation : NSObject<NSSecureCoding>

@property (nonatomic, copy) NSString *ageRange;
@property (nonatomic, assign) NSInteger dayLimit; // 日消费金额（分）
@property (nonatomic, assign) NSInteger monthLimit; // 月消费金额（分）

@end

// 游客模式规则
@interface GuestModeConfig : NSObject<NSSecureCoding>

@property (nonatomic, assign) NSInteger effectiveDay; // 有效期（天）
@property (nonatomic, assign) BOOL guestMode; // 是否为游客
@property (nonatomic, assign) NSTimeInterval playingTime; // 可玩时长

@end

// 规则
@interface Yodo1AntiIndulgedRules : NSObject<NSSecureCoding>

@property (nonatomic, assign) BOOL switchStatus;
@property (nonatomic, copy) NSString *csEmail;
@property (nonatomic, copy) NSString *moneyLimitationMsg; // 消费限制消息

@property (nonatomic, strong) Yodo1AntiIndulgedRuleMsg *guestModeMsg; // 游客模式提醒消息
@property(nonatomic, strong) Yodo1AntiIndulgedRuleMsg *playingTimeMsg; // 可玩时长提醒消息
@property (nonatomic, strong) Yodo1AntiIndulgedRuleMsg *antiPlayingTimeMsg; // 宵禁提醒消息

@property (nonatomic, strong) GuestModeConfig *guestModeConfig; // 游客模式规则

@property (nonatomic, strong) NSArray<GroupAntiPlayingTimeRange *> *groupAntiPlayingTimeRangeList; // 可玩时段
@property(nonatomic, strong) NSArray<GroupPlayingTime *> *groupPlayingTimeList; // 可玩时长（秒）
@property(nonatomic, strong) NSArray<GroupMoneyLimitation *> *groupMoneyLimitationList; // 限制消费

@end

NS_ASSUME_NONNULL_END
