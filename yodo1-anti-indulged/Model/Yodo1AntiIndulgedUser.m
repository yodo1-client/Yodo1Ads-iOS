//
//  Yodo1User.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedUser.h"

@implementation Yodo1AntiIndulgedUser

+ (NSString *)createSql {
    NSString *tableName = NSStringFromClass([Yodo1AntiIndulgedUser class]);
    NSMutableString *createSql = [[NSMutableString alloc]init];
    [createSql appendString:@" CREATE TABLE IF NOT EXISTS "];
    [createSql appendString:tableName];
    [createSql appendString:@" ( "];
    
    [createSql appendFormat:@" %@ VARCHAR, ", @"accountId"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"uid"];
    [createSql appendFormat:@" %@ VARCHAR, ", @"yid"];
    [createSql appendFormat:@" %@ INTEGER, ", @"age"];
    [createSql appendFormat:@" %@ SMALLINT, ", @"inWhiteList"];
    [createSql appendFormat:@" %@ SMALLINT, ", @"certificationStatus"];
    [createSql appendFormat:@" %@ DOUBLE ", @"certificationTime"];
    
    [createSql appendFormat:@" ); "];
    
    return createSql;
}

- (BOOL)isEqual:(id)object {
    BOOL isEqual = [super isEqual:object];
    if (!isEqual && [object isKindOfClass:[Yodo1AntiIndulgedUser class]]) {
        Yodo1AntiIndulgedUser *user = object;
        if (self.accountId && user.accountId) {
            isEqual = [self.accountId isEqualToString:user.accountId];
        }
    }
    return isEqual;
}

@end
