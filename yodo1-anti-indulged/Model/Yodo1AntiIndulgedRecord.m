//
//  Yodo1AntiIndulgedRecord.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import "Yodo1AntiIndulgedRecord.h"

@implementation Yodo1AntiIndulgedRecord

+ (NSString *)createSql {
    NSString *tableName = NSStringFromClass([Yodo1AntiIndulgedRecord class]);
    NSMutableString *createSql = [[NSMutableString alloc]init];
    [createSql appendString:@" CREATE TABLE IF NOT EXISTS "];
    [createSql appendString:tableName];
    [createSql appendString:@" ( "];
    
    [createSql appendFormat:@" %@ VARCHAR, ", @"accountId"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"date"];
    [createSql appendFormat:@" %@ DOUBLE, ", @"createTime"];
    [createSql appendFormat:@" %@ DOUBLE, ", @"leftTime"];
    [createSql appendFormat:@" %@ DOUBLE, ", @"playingTime"];
    [createSql appendFormat:@" %@ DOUBLE ", @"awaitTime"];

    [createSql appendFormat:@" ); "];
    
    return createSql;
}

- (instancetype) init {
    self = [super init];
    if (self) {
        _createTime = [NSDate date].timeIntervalSince1970;
    }
    return self;
}

@end
