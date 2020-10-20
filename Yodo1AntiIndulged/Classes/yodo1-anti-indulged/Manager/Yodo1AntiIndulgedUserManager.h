//
//  Yodo1AntiIndulgedUserManager.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/4.
//

#import <Foundation/Foundation.h>
#import "Yodo1AntiIndulgedUser.h"

NS_ASSUME_NONNULL_BEGIN

/// 用户管理
@interface Yodo1AntiIndulgedUserManager : NSObject

+ (Yodo1AntiIndulgedUserManager *)manager;

@property (nonatomic, strong, readonly) Yodo1AntiIndulgedUser *currentUser;

- (BOOL)isGuestUser;

/// 获取用户防沉迷信息
- (void)get:(NSString *)accountId success:(void (^)(Yodo1AntiIndulgedUser *))success failure:(void (^)(NSError *))failure;
/// 提交用户信息
- (void)post:(NSString *)name identify:(NSString *)identify success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end

NS_ASSUME_NONNULL_END
