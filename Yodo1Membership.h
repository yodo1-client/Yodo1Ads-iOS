//
//  Yodo1Membership.h
//  membership_sdk
//
//  Created by huafei qu on 13-6-5.
//  Copyright (c) 2013年 yodo1. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    Yodo1MembershipAPIEnvironmentProduction,
    Yodo1MembershipAPIEnvironmentTest
}Yodo1MembershipAPIEnvironment;

/**
 Yodo1 Membership错误码
 */
enum Yodo1MembershipErrorCode {
    Yodo1MembershipErrorUnknownError = -3,
    
    /**
     必须的参数未指定
     */
    Yodo1MembershipErrorInvalidParams = -1,
    
    /**
     网络连接错误
     */
    Yodo1MembershipErrorNetworkError = -4,
    /**
     用户名长度错误 6-32
     */
    Yodo1MembershipErrorUsernameLenError = -1022,
    /**
     密码长度错误 6-32
     */
    Yodo1MembershipErrorPasswordLenError = -1024,
};


/**
 用户注册/登陆后获得的授权信息
 */
@interface Yodo1MembershipAuthorization : NSObject

/**
 用户Token,访问Membership API的其他接口时会用到
 yodo1 每个game的id，每个用户在不同游戏的userid不同
 */
@property (nonatomic,copy) NSString* userId;

/**
 用户Token,访问Membership API的其他接口时会用到
 */
@property (nonatomic,copy) NSString* userToken;

/**
 渠道用户ID （只有在渠道相关的流程中才会有值）
 */
@property (nonatomic,copy) NSString* chanelUserId;

/**
 1 是  0否
 */
@property (nonatomic,assign) int  isnewuser;

/**
 yodo1 id，每个用户的唯一id，在任何游戏登陆的yid都相同
 */
@property (nonatomic,copy) NSString* yId;

/**
 1 是  0否
 */
@property (nonatomic,assign) int  isnewyaccount;

/**
 保留字段,在某些登陆方式如渠道登陆中会使用到,用来保存除User ID和User Token之外的其他信息。
 此字段会以JSON格式提供，需要开发者根据渠道等登陆方式自行解析内容。
 */
@property (nonatomic,copy) NSString* extra;

@end

extern NSString* const Yodo1MembershipErrorDomain;

/**
 获取分区列表回调方法
 @param success 获取是否成功
 @param error 获取分区列表失败时返回的错误信息,获取分区列表成功时为nil
 @param response 服务端返回内容
 */
typedef void (^RegionListCallback) (bool success,NSError* error,NSString *response);

/**
 获取版本信息回调方法
 @param success 获取是否成功
 @param error 获取版本信息失败时返回的错误信息,获取版本信息成功时为nil
 @param response 服务端返回内容
 */
typedef void (^GetUpdateInfoCallback) (bool success,NSError* error,NSString *response);

/**
 注册接口回调方法
 @param success 注册是否成功
 @param authorization 注册成功时返回的用户授权信息，注册失败时为nil
 @param error 注册失败时返回的错误信息,注册成功时为nil
 */
typedef void (^RegisterWithUsernameCallback)(BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 登陆接口回调方法
 @param success 登陆是否成功
 @param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 */
typedef void (^LoginWithUsernameCallback)(BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);


/**
 渠道用户登陆接口回调方法
 @param success 登陆是否成功
 @param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 */
typedef void (^LoginWithChannelUserCallback)(BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 渠道登陆回调方法
 @param success 登陆是否成功
 @param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 @param response 服务端返回内容
 */
typedef void (^LoginWithChannelUserBindCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 设备ID登陆回调方法
 @param success 登陆是否成功
 @param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 @param response 服务端返回内容
 */
typedef void (^LoginWithChannelUserDeviceIdCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 转换设备用户回调方法
 @param success 转换是否成功
 @param error 转换设备用户错误信息,转换成功时为nil
 @param response 服务端返回内容
 */
typedef void (^DeviceUserConvertCallback) (BOOL success,NSError* error,NSString* response);

/**
 回调方法:转换设备用户为SNS用户
 @param success 转换是否成功
 @param error 转换设备用户错误信息,转换成功时为nil
 @param response 服务端返回内容
 */
typedef void (^DeviceUserConvertToSNSUserCallback) (BOOL success,NSError* error,NSString* response);

/**
 SNS登陆回调方法
 @param success 登陆是否成功
 @param authorization 登陆成功时返回的用户授权信息，登陆失败时为nil
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 @param response 服务端返回内容
 */
typedef void (^SNSLoginCallback) (BOOL success,Yodo1MembershipAuthorization* authorization,NSError* error,NSString* response);

/**
 SNS登陆回调方法
 @param success 登陆是否成功
 @param error 登陆失败时返回的错误信息,登陆成功时为nil
 @param response 服务端返回内容
 */
typedef void (^ChangeIdCallback) (BOOL success,NSError* error,NSString* response);

/**
 Yodo1 Membership系统核心类
 */
@interface Yodo1Membership : NSObject

/**
 设置API环境，默认为生产环境。
 @param env Membership API环境:Yodo1MembershipAPIEnvironmentProduction-生产环境,Yodo1MembershipAPIEnvironmentTest-测试环境
 */
+ (void) setAPIEnvironment:(Yodo1MembershipAPIEnvironment) env;

/**
 打开/关闭日志功能
 @param enable 是否打开日志功能
 */
+ (void) setLogEnabled:(BOOL) enable;

/**
 打开/关闭异步连网功能(多线程)，默认为开。
 异步连网功能打开时，网络返回数据的回调方法会在连网线程中执行，游戏需要自己处理主线程/子线程之间的切换。
 @param async 是否打开异步连网功能
 */
+ (void) setAsyncConnections:(BOOL) async;

/*
 获取在线分区列表
 */
+ (void) regionList:(NSString*) channelCode
         gameAppkey:(NSString*)gameAppkey
    regionGroupCode:(NSString*)regionGroupCode
           callback:(RegionListCallback)callback;
/*
 获取版本更新信息
 */
+ (void) getUpdateInfoWithAppKey:(NSString*)gameAppkey
                    channelCode:(NSString*)channelCode
                       callback:(GetUpdateInfoCallback)callback;
/**
 用户注册
 @param username 用户名,必须提供。
 @param password 密码，必须提供。
 @param appKey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegion （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) registerWithUsername:(NSString*) username
                     password:(NSString*) password
                       appKey:(NSString*) appKey
                    channelId:(NSString*) channelId
                   gameRegion:(NSString*) gameRegion
                     callback:(RegisterWithUsernameCallback) callback;

/**
用户登陆
@param username 用户名,必须提供。
@param password 密码，必须提供。
@param appKey 当前游戏的Yodo1 AppKey，必须提供。
@param channelId 渠道号，必须提供。
@param gameRegion （网游）游戏分区，必须提供。
@param callback 回调方法，可选。
*/
+ (void) loginWithUsername:(NSString*) username
                  password:(NSString*) password
                    appKey:(NSString*) appKey
                 channelId:(NSString*) channelId
                gameRegion:(NSString*) gameRegion
                  callback:(LoginWithUsernameCallback) callback;

/**
 渠道用户登陆(如果Yodo1用户中心没有该渠道用户，则自动注册并登陆)。
 三方渠道登陆所需参数：
 UC:
 当乐:
 91:
 @param userId 渠道用户ID,可以为NULL。
 @param userToken 渠道用户Token，必须提供。
 @param reservedArg 保留参数,可以为NULL(预留给需要多于2个参数的渠道)。
 @param appKey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegion （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) loginWithChannelUser:(NSString*) userId
                    userToken:(NSString*) userToken
                  reservedArg:(NSString*)reservedArg
                       appKey:(NSString*) appKey
                    channelId:(NSString*) channelId
                   gameRegion:(NSString*) gameRegion
                     callback:(LoginWithChannelUserCallback) callback;

/**
 渠道用户绑定。
 @param yodo1UserId Yodo1用户ID,必须提供。
 @param channelUserId 渠道用户ID,如果需要服务端配合获取渠道ID，此字段填NULL。
 @param channelUserToken 渠道用户Token，必须提供。
 @param channelReservedArg 保留参数,可以为NULL(预留给需要多于2个参数的渠道)。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) bindWithChannelUser:(NSString*)yodo1UserId
               channelUserId:(NSString*)channelUserId
            channelUserToken:(NSString*)channelUserToken
          channelReservedArg:(NSString*)channelReservedArg
                      appkey:(NSString*)appkey
                   channelId:(NSString*)channelId
              gameRegionCode:(NSString*)gameRegionCode
                    callback:(LoginWithChannelUserBindCallback)callback;

/**
 设备ID登陆
 @param deviceId 设备ID。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) loginWithDeviceId:(NSString*)deviceId
                    appkey:(NSString*)appkey
                 channelId:(NSString*)channelId
            gameRegionCode:(NSString*)gameRegionCode
                  callback:(LoginWithChannelUserDeviceIdCallback)callback;

/**
 转换设备ID用户为正式用户。
 @param deviceId 设备ID。
 @param userId 设备用户ID。
 @param username 用户名，必须提供。
 @param password 用户密码，必须提供。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) convertDeviceUserToFormalUser:(NSString*)deviceId
                                userId:(NSString*)userId
                              username:(NSString*)username
                              password:(NSString*)password
                                appkey:(NSString*)appkey
                             channelId:(NSString*)channelId
                        gameRegionCode:(NSString*)gameRegionCode
                              callback:(DeviceUserConvertCallback)callback;

/**
 转换设备ID用户SNS用户。
 @param deviceId 设备ID，必须提供
 @param userId 设备用户ID，必须提供
 @param snsType SNS类型，必须提供。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) convertDeviceUserToSNSUser:(NSString*)deviceId
                             userId:(NSString*)userId
                            snsType:(NSString*)snsType
                             appkey:(NSString*)appkey
                        channelId:(NSString*)channelId
                     gameRegionCode:(NSString*)gameRegionCode
                           callback:(DeviceUserConvertToSNSUserCallback)callback;

/**
 SNS用户登陆
 @param snsType SNS类型。
 @param userId SNS用户ID,必须提供。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) loginWithSNSByUserID:(NSString*)snsType
                       userId:(NSString*)userId
                       appkey:(NSString*)appkey
                    channelId:(NSString*)channelId
               gameRegionCode:(NSString*)gameRegionCode
                     callback:(SNSLoginCallback)callback;

/**
 SNS用户登陆（使用Yodo1 SNS登陆获取取用户ID后登陆）
 @param snsType SNS类型。
 @param appkey 当前游戏的Yodo1 AppKey，必须提供。
 @param channelId 渠道号，必须提供。
 @param gameRegionCode （网游）游戏分区，必须提供。
 @param callback 回调方法，可选。
 */
+ (void) loginWithSNS:(NSString*)snsType
               appkey:(NSString*)appkey
            channelId:(NSString*)channelId
       gameRegionCode:(NSString*)gameRegionCode
             callback:(SNSLoginCallback)callback;

/**
 仍使用传入的user_id作为device_id代表用户的存档数据的_id，并将此存档变更为use的主帐号，原有device的存档被删除
 用户再次登录时取到的user_id不变，但是对应的存档是device_id对应的存档，原存档已经删除了（如分区信息等）
 device_id再次登录是取到的存档是全新的
 
 appkey 游戏 game_appkey
 replacedUserId 用户id
 device_id  设备id
 */
+ (void) replaceContentOfUserId:(NSString*)replacedUserId
                       deviceId:(NSString *)deviceId
                         appkey:(NSString *)appkey
                       callback:(ChangeIdCallback)callback;

/**
 将device_id代表用户的存档的主帐号变更为user_id代表的帐号，user_id本身的数据被删除，替换的数据包括user_id本身
 用户再次登录时取到的user_id是操作前device_id对应的user_id，原user_id已经删除了
 device_id再次登录是取到的user_id是全新的
 
 appkey 游戏 game_appkey
 transferedUserId 用户id
 device_id  设备id
 */

+ (void) transferWithDeviceUserId:(NSString *)transferedUserId
                         deviceId:(NSString *)deviceId
                           appkey:(NSString *)appkey
                         callback:(ChangeIdCallback)callback;

@end
