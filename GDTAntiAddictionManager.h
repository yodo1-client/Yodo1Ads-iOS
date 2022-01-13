//
//  GDTAntiAddictionManager.h
//  GDTMobApp
//
//  Created by nimomeng on 2021/6/29.
//  Copyright © 2021 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 接口index，用于在错误回调中标识接口
typedef NS_ENUM(NSInteger, GDTAntiAddictionInterfaceIndex) {
    GDTAntiAddictionInterfaceQueryDevice = 1,               // 查询接口防沉迷信息
    GDTAntiAddictionInterfaceSubmitIDCard = 2,              // 提交实名认证信息
};

typedef NS_ENUM(NSInteger, GDTAntiAddictionErrorCode) {
    GDTAntiAddictionErrorNetwork = 1001,            //网络错误
    GDTAntiAddictionErrorInterface = 1002,          //接口异常
};

@class GDTAntiAddictionManager;

@protocol GDTAntiAddictionManagerDelegate <NSObject>

/// 收到防沉迷系统的指令，根据指令进行下一步操作
/// @param manager 防沉迷manager
/// @param state Json字符串，设备防沉迷信息
- (void)manager:(GDTAntiAddictionManager *)manager didReceiveDeviceAntiAddictionState:(NSString *)state;

/// 提交实名认证信息验证结果
/// @param manager 防沉迷manager
/// @param state Json字符串，实名认证结果
- (void)manager:(GDTAntiAddictionManager *)manager didReceiveIDCardState:(NSString *)state;

/// 请求接口失败回调
/// @param manager 防沉迷manager
/// @param index 接口标识
/// @param error 错误信息
- (void)manager:(GDTAntiAddictionManager *)manager interfaceFailure:(GDTAntiAddictionInterfaceIndex)index error:(NSError *)error;

@end

@interface GDTAntiAddictionManager : NSObject

@property (nonatomic, weak) id<GDTAntiAddictionManagerDelegate> delegate;

/// 查询设备防沉迷状态，在manager:didReceiveDeviceAntiAddictionState:中进行处理
- (void)queryDeviceAntiAddictionState:( NSDictionary * _Nullable )ext;

/// 提交实名认证信息，在manager:didReceiveIDCardState:中进行处理
/// @param name 姓名
/// @param number 身份证号
- (void)submitIDCardWithName:(NSString *)name number:(NSString *)number ext:(NSDictionary * _Nullable )ext;

/// 当查询设备防沉迷状态或提交实名信息认证出现错误时，可调用此接口反馈debug信息。
- (void)uploadDebugInfo;

@end

NS_ASSUME_NONNULL_END
