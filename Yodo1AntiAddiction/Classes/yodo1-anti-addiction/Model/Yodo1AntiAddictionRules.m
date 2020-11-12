//
//  Yodo1AntiAddictionRules.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import "Yodo1AntiAddictionRules.h"
#import "Yodo1AntiAddictionUtils.h"

@implementation Yodo1AntiAddictionHolidayRules

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _antiPlayingTimeRange = [decoder decodeObjectOfClass:[NSArray class] forKey:@"antiPlayingTimeRange"];
        _playingTime = [decoder decodeDoubleForKey:@"playingTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.antiPlayingTimeRange) {
        [coder encodeObject:self.antiPlayingTimeRange forKey:@"antiPlayingTimeRange"];
    }
    [coder encodeDouble:self.playingTime forKey:@"playingTime"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation Yodo1AntiAddictionRuleMsg

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _beforeMsg = [decoder decodeObjectForKey:@"beforeMsg"];
        _message = [decoder decodeObjectForKey:@"message"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.beforeMsg) {
        [coder encodeObject:self.beforeMsg forKey:@"beforeMsg"];
    }
    if (self.message) {
        [coder encodeObject:self.message forKey:@"message"];
    }
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation GroupAntiPlayingTimeRange

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _ageRange = [decoder decodeObjectForKey:@"ageRange"];
        _antiPlayingTimeRange = [decoder decodeObjectOfClass:[NSArray class] forKey:@"antiPlayingTimeRange"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.ageRange) {
        [coder encodeObject:self.ageRange forKey:@"ageRange"];
    }
    if (self.antiPlayingTimeRange) {
        [coder encodeObject:self.antiPlayingTimeRange forKey:@"antiPlayingTimeRange"];
    }
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation GroupPlayingTime

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _ageRange = [decoder decodeObjectForKey:@"ageRange"];
        _holidayTime = [decoder decodeDoubleForKey:@"holidayTime"];
        _regularTime = [decoder decodeDoubleForKey:@"regularTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.ageRange) {
        [coder encodeObject:self.ageRange forKey:@"ageRange"];
    }
    [coder encodeDouble:self.regularTime forKey:@"holidayTime"];
    [coder encodeDouble:self.holidayTime forKey:@"regularTime"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation GroupMoneyLimitation

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _ageRange = [decoder decodeObjectForKey:@"ageRange"];
        _dayLimit = [decoder decodeIntegerForKey:@"dayLimit"];
        _monthLimit = [decoder decodeIntegerForKey:@"monthLimit"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    if (self.ageRange) {
        [coder encodeObject:self.ageRange forKey:@"ageRange"];
    }
    [coder encodeInteger:self.dayLimit forKey:@"dayLimit"];
    [coder encodeInteger:self.monthLimit forKey:@"monthLimit"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation GuestModeConfig

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _effectiveDay = [decoder decodeIntegerForKey:@"effectiveDay"];
        _guestMode = [decoder decodeBoolForKey:@"guestMode"];
        _playingTime = [decoder decodeDoubleForKey:@"playingTime"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:self.effectiveDay forKey:@"effectiveDay"];
    [coder encodeBool:self.guestMode forKey:@"guestMode"];
    [coder encodeDouble:self.playingTime forKey:@"playingTime"];
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end

@implementation Yodo1AntiAddictionRules

+ (NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"groupAntiPlayingTimeRangeList" : [GroupAntiPlayingTimeRange class],
        @"groupPlayingTimeList" : [GroupPlayingTime class],
        @"groupMoneyLimitationList" : [GroupMoneyLimitation class]
    };
}

- (instancetype)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        _switchStatus = [decoder decodeBoolForKey:@"switchStatus"];
        _csEmail = [decoder decodeObjectForKey:@"csEmail"];
        _moneyLimitationMsg = [decoder decodeObjectForKey:@"moneyLimitationMsg"];
        _guestModeMsg = [decoder decodeObjectOfClass:[Yodo1AntiAddictionRuleMsg class] forKey:@"guestModeMsg"];
        _playingTimeMsg = [decoder decodeObjectOfClass:[Yodo1AntiAddictionRuleMsg class] forKey:@"playingTimeMsg"];
        _antiPlayingTimeMsg = [decoder decodeObjectOfClass:[Yodo1AntiAddictionRuleMsg class] forKey:@"antiPlayingTimeMsg"];
        
        _guestModeConfig = [decoder decodeObjectOfClass:[GuestModeConfig class] forKey:@"guestModeConfig"];
        
        _groupAntiPlayingTimeRangeList = [decoder decodeObjectOfClass:[NSArray class] forKey:@"groupAntiPlayingTimeRangeList"];
        _groupPlayingTimeList = [decoder decodeObjectOfClass:[NSArray class] forKey:@"groupPlayingTimeList"];
        _groupMoneyLimitationList = [decoder decodeObjectOfClass:[NSArray class] forKey:@"groupMoneyLimitationList"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBool:self.switchStatus forKey:@"switchStatus"];
    if (self.csEmail) {
        [coder encodeObject:self.csEmail forKey:@"csEmail"];
    }
    if (self.moneyLimitationMsg) {
        [coder encodeObject:self.moneyLimitationMsg forKey:@"moneyLimitationMsg"];
    }
    if (self.guestModeMsg) {
        [coder encodeObject:self.guestModeMsg forKey:@"guestModeMsg"];
    }
    if (self.playingTimeMsg) {
        [coder encodeObject:self.playingTimeMsg forKey:@"playingTimeMsg"];
    }
    if (self.antiPlayingTimeMsg) {
        [coder encodeObject:self.antiPlayingTimeMsg forKey:@"antiPlayingTimeMsg"];
    }
    if (self.guestModeConfig) {
        [coder encodeObject:self.guestModeConfig forKey:@"guestModeConfig"];
    }
    if (self.groupAntiPlayingTimeRangeList) {
        [coder encodeObject:self.groupAntiPlayingTimeRangeList forKey:@"groupAntiPlayingTimeRangeList"];
    }
    if (self.groupPlayingTimeList) {
        [coder encodeObject:self.groupPlayingTimeList forKey:@"groupPlayingTimeList"];
    }
    if (self.groupMoneyLimitationList) {
        [coder encodeObject:self.groupMoneyLimitationList forKey:@"groupMoneyLimitationList"];
    }
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

@end
