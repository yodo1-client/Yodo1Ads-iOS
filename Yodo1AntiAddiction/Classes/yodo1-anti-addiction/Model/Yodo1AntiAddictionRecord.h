//
//  Yodo1AntiAddictionRecord.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Yodo1AntiAddictionRecord : NSObject

@property (nonatomic, copy) NSString *accountId;
@property (nonatomic, copy) NSString *date; // 2020-10-06
@property (nonatomic, assign) NSTimeInterval createTime; // 创建时间
@property (nonatomic, assign) NSTimeInterval leftTime; // 剩余时间(秒)
@property (nonatomic, assign) NSTimeInterval playingTime; // 已玩时间(秒)
@property (nonatomic, assign) NSTimeInterval awaitTime; // 未上报时间(秒)

+ (NSString *)createSql;

@end

NS_ASSUME_NONNULL_END
