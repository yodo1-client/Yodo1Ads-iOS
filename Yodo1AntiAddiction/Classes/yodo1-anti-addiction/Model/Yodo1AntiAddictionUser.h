//
//  Yodo1User.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSInteger {
    UserCertificationStatusNot = -1, // 未验证
    UserCertificationStatusMinor = 0, // 已实名 未成年
    UserCertificationStatusAault = 1 // 已实名 已成年
} UserCertificationStatus;

@interface Yodo1AntiAddictionUser : NSObject

@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *yid;
@property (nonatomic, assign) NSInteger age;
@property (nonatomic, assign) BOOL inWhiteList;
@property (nonatomic, assign) UserCertificationStatus certificationStatus;
@property (nonatomic, assign) NSTimeInterval certificationTime;

+ (NSString *)createSql;

@end

NS_ASSUME_NONNULL_END
