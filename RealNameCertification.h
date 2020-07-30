//
//  RealNameCertification.h
//  Real-name
//
//  Created by yixian huang on 2019/11/25.
//  Copyright © 2019 yixian huang. All rights reserved.
//

#ifndef RealNameCertification_h
#define RealNameCertification_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface OnlineRealNameConfig : NSObject
@property (nonatomic,assign)BOOL verify_age_enabled;//年龄验证开关
@property (nonatomic,assign)BOOL verify_idcode_enabled;//实名验证开关
@property (nonatomic,assign)BOOL forced;//是否强制实名认证
@property (nonatomic,strong)NSString* verifier;//验证方:client，server
@property (nonatomic,assign)int max_count;//最大验证次数
@property (nonatomic,assign)int level;//0 表示不可以进游戏，1可以进游戏,2国外IP 可以进游戏
@property (nonatomic,assign)int remaining_time;//-1 表示海外，不需要实名验证
@property (nonatomic,assign)int remaining_cost;//-1 表示海外，不需要实名验证
@end

@interface RealNameParameterInfoRequestParameter : NSObject
@property(nonatomic,strong)NSString* yId;///yodo1 yid
///登记类型，为online时为联网验证，其它值或不传为本地验证
@property(nonatomic,strong)NSString* signinType;
///证件类型,1:身份证,2:护照,3:军官证,100:其它
@property(nonatomic,strong)NSString* idType;
@property(nonatomic,strong)NSString* idCode;///证件号
@property(nonatomic,strong)NSString* name;///实名姓名
@property(nonatomic,assign)int age;///年龄
@property(nonatomic,assign)BOOL isSkip;///是否跳过
- (NSDictionary *)parameterInfo;
@end

///获取用户剩余花销和剩余游玩时间
@interface AntiConfigRequestParameter : NSObject
@property (nonatomic,strong)NSString* game_appkey;//游戏key
@property (nonatomic,strong)NSString* game_version;//游戏版本
@property (nonatomic,strong)NSString* channel_code;//渠道code
@property (nonatomic,strong)NSString* yId;//用户唯一标识（三方这全用game_user_id）
@property (nonatomic,assign)long play_time;//已消费的时间数（秒）
@property (nonatomic,assign)int age;//年纪
- (NSDictionary *)parameterInfo;
@end

@interface PaymentCheckRequestParameter : NSObject
@property (nonatomic,strong)NSString* game_appkey;//游戏key
@property (nonatomic,strong)NSString* game_version;//游戏版本
@property (nonatomic,strong)NSString* channel_code;//渠道code
@property (nonatomic,strong)NSString* yId;//用户唯一标识（三方这全用game_user_id）
@property (nonatomic,assign)int money;//货币单价（分)
@property (nonatomic,assign)int age;//年纪
///当金额为-1的时候，是必传参数。计费点信息，需要从三方获取金额
@property (nonatomic,strong)NSString* charging_point;
- (NSDictionary *)parameterInfo;
@end

@interface TemplateDetailRequeseParameter : NSObject
@property (nonatomic,strong)NSString* game_appkey;//游戏key
@property (nonatomic,strong)NSString* game_version;//游戏版本
@property (nonatomic,strong)NSString* channel_code;//渠道code
@property (nonatomic,strong)NSString* yId;//用户唯一标识（三方这全用game_user_id）
@property (nonatomic,assign)int code;//之前接口返回客户端的错误码
- (NSDictionary *)parameterInfo;
@end

extern NSString* const kAntiConsumeMoney;
extern NSString* const kAntiConsumeOrderid;
@interface AntiNotifyRequestParameter : NSObject
@property (nonatomic,strong)NSString* game_appkey;//游戏key
@property (nonatomic,strong)NSString* game_version;//游戏版本
@property (nonatomic,strong)NSString* channel_code;//渠道code
@property (nonatomic,strong)NSString* yId;//用户唯一标识（三方这全用game_user_id）
@property (nonatomic,assign)int type;//0：时长，1：支付
@property (nonatomic,assign)int age;//年纪
@property (nonatomic,assign)long consume_time;//当type为0时，必要参数。已秒为单位的数字
//consume_money(已分为单位的消费金额)/consume_orderid(该笔数据的orderid（订单间属于唯一标识）)
@property (nonatomic,strong)NSArray* orders;
- (NSDictionary *)parameterInfo;
@end

typedef void(^RealNameBlock)(BOOL isRealName,int age,NSString* errorMsg);
typedef void(^RealNameViewBlock)(RealNameParameterInfoRequestParameter* info);

typedef enum {
    NotifyTypeNone = -1,//未知
    NotifyTypeDate,//时长
    NotifyTypePay,//支付
} NotifyType;


@interface RealNameCertification : NSObject

#pragma mark- RealName Verify [实名认证]
///实名制认证配置
+ (void)realNameConfigAppKey:(NSString *)appKey
                     channel:(NSString *)channel
                     version:(NSString *)version
                    callback:(void (^)(OnlineRealNameConfig* config,NSString* errorMsg))callback;

///账号实名登记
+ (void)realNameCertificationInfo:(RealNameParameterInfoRequestParameter *)parameter
                         callback:(RealNameBlock)callback;

///查询用户是否已经实名
+ (void)userRealNameVerifyYid:(NSString *)yid
                     callback:(void (^)(BOOL success,int age,NSString* errorMsg))callback;

///显示验证实名UI
+ (void)showRealNameYid:(NSString *)yid
         viewController:(UIViewController *)controller
                  block:(RealNameBlock)callback;

#pragma mark- RealName Addiction [防沉迷]

///获取用户剩余花销和剩余游玩时间
+ (void)antiAddictionConfig:(AntiConfigRequestParameter *)parameter
                   callback:(void (^)(BOOL success,int remainingTime,int remainingCost,NSString * errorMsg))callback;

///同步防沉迷数据 -- 查询剩余可支付金额/时长
+ (void)uploadAntiAddictionData:(AntiNotifyRequestParameter *)parameter
                       callback:(void (^)(BOOL success,NotifyType type,int errorCode,int remainingTime,int remainingCost,NSString* errorMsg))callback;

///下单前验证消息
+ (void)orderToVerify:(PaymentCheckRequestParameter *)parameter
             callback:(void (^)(BOOL success,int errorCode,NSString* errorMsg))callback;

/// 获取防沉迷模板内容
+ (void)templateDetail:(TemplateDetailRequeseParameter *)parameter
              callback:(void (^)(BOOL success,int errorCode,NSString* jsonResponse,NSString* errorMsg))callback;

@end

@interface RealNameViewController : UIViewController

@property(nonatomic,copy)RealNameViewBlock block;
@property(nonatomic,assign)BOOL isSkipValidation;//是否允许跳过


@end

#endif /* RealNameCertification_h */
