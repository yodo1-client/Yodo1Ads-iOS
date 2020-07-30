//
//  RealNameCertification.m
//  Real-name
//
//  Created by yixian huang on 2019/11/25.
//  Copyright © 2019 yixian huang. All rights reserved.
//

#import "RealNameCertification.h"
#import <Yodo1AFNetworking/Yodo1AFNetworking.h>
#import "Yodo1Tool+Commons.h"
#define RNDEBUG     0

#if RNDEBUG == 1 //测试环境
NSString* const kRealNameBaseUrl = @"https://api-olconfig-test.yodo1.com";
#elif RNDEBUG == 2 //准生产环境
NSString* const kRealNameBaseUrl = @"https://anti-stg.yodo1api.com";
#else
NSString* const kRealNameBaseUrl = @"https://anti.yodo1api.com";
#endif

/// 实名验证BaseUrl
#if RNDEBUG == 1 //测试环境
NSString* const kRNBaseUrl = @"https://api-ucap-test.yodo1.com";
#elif RNDEBUG == 2 //准生产环境
NSString* const kRNBaseUrl = @"https://uc-ap-stg.yodo1api.com";
#else
NSString* const kRNBaseUrl = @"https://uc-ap.yodo1api.com";
#endif

/// 实名验证
NSString* const kRealNameUrl = @"/uc_ap/channel/yodo1/signInRealName";

/// 获取用户是否已经实名
NSString* const kUserRealNameUrl = @"/config/getUserRealNameInfo";
/// 实名认证配置
NSString* const kRealNameConfigUrl = @"/config/realNameConfig";
/// 下单前的验证消息
NSString* const kPaymentCheckUrl = @"/config/payment/check";
/// 同步防沉迷数据
NSString* const kNotifyUrl = @"/config/notify";
/// 获取防沉迷模板内容
NSString* const kTemplateDetailUrl = @"/config/getTemplateDetail";
/// 获取用户剩余花销和剩余游玩时间
NSString* const kAntiAddictionConfigUrl = @"/config/antiAddictionConfig";

@implementation OnlineRealNameConfig
@end

@implementation RealNameParameterInfoRequestParameter

- (NSDictionary *)parameterInfo {
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    NSString* mSign = [NSString stringWithFormat:@"yodo1.com%@%@",
                       self.yId,self.idCode];
    NSString* sign =  [Yd1OpsTools signMd5String:mSign];
    NSDictionary* data = @{
        @"yid":self.yId? :@"",
        @"signintype":self.signinType? :@"",
        @"idtype":self.idType? :@"1",
        @"idcode":self.idCode? :@"",
        @"name":self.name? :@"",
    };
    [param setObject:sign? :@"" forKey:@"sign"];
    [param setObject:data forKey:@"data"];
    return param;
}

@end

@implementation PaymentCheckRequestParameter
- (NSDictionary *)parameterInfo {
    NSString* mSign = [NSString stringWithFormat:@"%@%@yodo1",
                       self.game_appkey,self.yId];
    NSString* sign =  [Yd1OpsTools signMd5String:mSign];
    NSDictionary* param = @{
        @"age":[NSNumber numberWithInt:self.age? :0],
        @"yid":self.yId? :@"",
        @"game_appkey":self.game_appkey? :@"",
        @"channel_code":self.channel_code? :@"",
        @"game_version":self.game_version? :@"",
        @"money":[NSNumber numberWithInt:self.money? :0],
        @"charging_point":self.charging_point? :@"",
        @"sign":sign?sign:@"",
    };
    return param;
}
@end

@implementation TemplateDetailRequeseParameter
- (NSDictionary *)parameterInfo {
    NSString* mSign = [NSString stringWithFormat:@"%@%dyodo1",
                       self.game_appkey,self.code];
    NSString* sign =  [Yd1OpsTools signMd5String:mSign];
    NSDictionary* param = @{
        @"code":[NSNumber numberWithInt:self.code? :0],
        @"yid":self.yId? :@"",
        @"game_appkey":self.game_appkey? :@"",
        @"channel_code":self.channel_code? :@"",
        @"game_version":self.game_version? :@"",
        @"sign":sign? :@"",
    };
    return param;
}
@end

NSString* const kAntiConsumeMoney = @"consume_money";
NSString* const kAntiConsumeOrderid = @"consume_orderid";
@implementation AntiNotifyRequestParameter

- (NSDictionary *)parameterInfo {
    NSMutableDictionary* param = [NSMutableDictionary dictionary];
    NSString* mSign = [NSString stringWithFormat:@"%@%@yodo1",
                       self.game_appkey,self.yId];
    NSString* sign =  [Yd1OpsTools signMd5String:mSign];
    
    [param setObject:self.game_appkey forKey:@"game_appkey"];
    [param setObject:self.channel_code forKey:@"channel_code"];
    [param setObject:self.game_version forKey:@"game_version"];
    [param setObject:self.yId forKey:@"yid"];
    [param setObject:[NSNumber numberWithInt:self.type] forKey:@"type"];
    [param setObject:[NSNumber numberWithInt:self.age] forKey:@"age"];
    [param setObject:sign?sign:@"" forKey:@"sign"];
    
    if (self.type == 1) {
        [param setObject:(self.orders != nil ?self.orders:@[]) forKey:@"orders"];
    }else if (self.type == 0){
        [param setObject:[NSNumber numberWithLong:self.consume_time] forKey:@"consume_time"];
    }
    
    return param;
}

@end

@implementation AntiConfigRequestParameter

- (NSDictionary *)parameterInfo {
    NSString* mSign = [NSString stringWithFormat:@"%@%@yodo1",
                       self.game_appkey,self.yId];
    NSString* sign =  [Yd1OpsTools signMd5String:mSign];
    NSDictionary* param = @{
        @"age":[NSNumber numberWithInt:self.age? :0],
        @"yid":self.yId?self.yId:@"",
        @"game_appkey":self.game_appkey? :@"",
        @"channel_code":self.channel_code? :@"",
        @"game_version":self.game_version? :@"",
        @"play_time":[NSNumber numberWithLong:self.play_time? :0],
        @"sign":sign? :@"",
    };
    return param;
}

@end

@implementation RealNameCertification

+ (void)realNameConfigAppKey:(NSString *)appKey
                     channel:(NSString *)channel
                     version:(NSString *)version
                    callback:(void (^)(OnlineRealNameConfig *,NSString*))callback {
    
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString* channelCode = @"general";
    if (channel) {
        channelCode = channel;
    }
    NSString* gameVersion = @"general";
    if (version) {
        gameVersion = version;
    }
    
    NSString* mSign = [NSString stringWithFormat:@"%@%@%@yodo1",appKey,channelCode,gameVersion];
    NSString* sign = [Yd1OpsTools signMd5String:mSign];
    NSDictionary* parameters = @{
        @"game_appkey":appKey,
        @"channel_code":channelCode,
        @"game_version":gameVersion,
        @"sign":sign,
    };
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kRealNameConfigUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
#ifdef DEBUG
        NSLog(@"[ Yodo1 ] response:%@",response);
#endif
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            if ([[respo allKeys]containsObject:@"error_code"]) {
                int error_code = [[respo objectForKey:@"error_code"]intValue];
                if (error_code==0) {
                    if ([[respo allKeys]containsObject:@"data"]) {
                        NSDictionary* data = (NSDictionary *)[respo objectForKey:@"data"];
                        OnlineRealNameConfig* config = [OnlineRealNameConfig new];
                        BOOL verify_age_enabled = [[data objectForKey:@"verify_age_enabled"]boolValue];
                        BOOL verify_idcode_enabled = [[data objectForKey:@"verify_idcode_enabled"]boolValue];
                        BOOL forced = [[data objectForKey:@"forced"]boolValue];
                        NSString* verifier = (NSString*)[data objectForKey:@"verifier"];
                        int max_count = [[data objectForKey:@"max_count"]intValue];
                        int level = [[data objectForKey:@"level"]intValue];
                        config.verify_age_enabled = verify_age_enabled;
                        config.verify_idcode_enabled = verify_idcode_enabled;
                        config.forced = forced;
                        config.verifier = verifier;
                        config.max_count = max_count;
                        config.level = level;
                        if ([[data allKeys]containsObject:@"remaining_cost"]) {
                            config.remaining_cost = [[data objectForKey:@"remaining_cost"]intValue];
                        }
                        
                        if ([[data allKeys]containsObject:@"remaining_time"]) {
                            config.remaining_time = [[data objectForKey:@"remaining_time"]intValue];
                        }
                        
                        if (callback) {
                            callback(config,@"");
                        }
                    }else{
                        if (callback) {
                            callback(nil,@"Empty Data!");
                        }
                    }
                }else{
                    if (callback) {
                        callback(nil,[NSString stringWithFormat:@"error_code:%d",error_code]);
                    }
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error:%@",error.localizedDescription);
        }
        if (callback) {
            callback(nil,error.localizedDescription);
        }
    }];
}

+ (void)realNameCertificationInfo:(RealNameParameterInfoRequestParameter *)parameter
                         callback:(void (^)(BOOL,int,NSString *))callback {
    
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRNBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary* parameters = [parameter parameterInfo];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kRealNameUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
#ifdef DEBUG
        NSLog(@"[ Yodo1 ] response:%@",response);
#endif
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            if ([[respo allKeys]containsObject:@"error_code"]) {
                int error_code = [[respo objectForKey:@"error_code"]intValue];
                NSString* errorMsg = [respo objectForKey:@"error"];
                if (error_code==0) {
                    if (callback) {
                        callback(true,0,errorMsg);
                    }
                }else{
                    if (callback) {
                        callback(false,0,errorMsg);
                    }
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error:%@",error.localizedDescription);
        }
        if (callback) {
            callback(false,0,error.localizedDescription);
        }
    }];
}

+ (void)userRealNameVerifyYid:(NSString *)yid
                     callback:(void (^)(BOOL,int, NSString *))callback {
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSString* signStr = [NSString stringWithFormat:@"%@yodo1",yid];
    NSString* sign = [Yd1OpsTools signMd5String:signStr];
    NSDictionary* parameters = @{
        @"yid":yid,
        @"sign":sign,
    };
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kUserRealNameUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
#ifdef DEBUG
        NSLog(@"[ Yodo1 ]查询 real name of response:%@",response);
#endif
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            if ([[respo allKeys]containsObject:@"error_code"]) {
                int error_code = [[respo objectForKey:@"error_code"]intValue];
                ///age假如为负数的话，说明该用户未进行过实名认证
                int age = [[respo objectForKey:@"age"]intValue];
                NSString* errorMsg = [respo objectForKey:@"error"];
                if (error_code==0) {
                    if (callback) {
                        callback(YES,age,@"");
                    }
                }else{
                    if (callback) {
                        callback(NO,age,errorMsg);
                    }
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            NSLog(@"error:%@",error.localizedDescription);
        }
        if (callback) {
            callback(NO,0,error.localizedDescription);
        }
    }];
}

+ (void)showRealNameYid:(NSString *)yid
         viewController:(UIViewController *)controller
                  block:(RealNameBlock)block {
    
    RealNameViewController * realName = [[RealNameViewController alloc]init];
    [controller presentViewController:realName animated:YES completion:nil];
    [realName setBlock:^(RealNameParameterInfoRequestParameter *info) {
        if (info) {
            info.yId = yid;
        }
        [RealNameCertification realNameCertificationInfo:info
                                                callback:^(BOOL isRealName,int age, NSString *errorMsg) {
            if (block) {
                block(isRealName,info.age,errorMsg);
            }
        }];
    }];
}

+ (void)antiAddictionConfig:(AntiConfigRequestParameter *)parameter
                   callback:(void (^)(BOOL success,int remainingTime,int remainingCost,NSString * errorMsg))callback {
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary* parameters = [parameter parameterInfo];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kAntiAddictionConfigUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            if ([[respo allKeys]containsObject:@"error_code"]) {
                int error_code = [[respo objectForKey:@"error_code"]intValue];
                if (error_code==0) {
                    int remaining_time = 0;
                    int remaining_cost = 0;
                    if ([[respo allKeys]containsObject:@"data"]) {
                        NSDictionary* data = [respo objectForKey:@"data"];
                        if ([[data allKeys]containsObject:@"remaining_time"]) {
                            remaining_time = [[data objectForKey:@"remaining_time"]intValue];
                        }
                        if ([[data allKeys]containsObject:@"remaining_cost"]) {
                            remaining_cost = [[data objectForKey:@"remaining_cost"]intValue];
                        }
                    }
                    if (callback) {
                        callback(YES,remaining_time,remaining_cost/100,@"");
                    }
                }else{
                    NSString* errorMsg = @"";
                    if ([[respo allKeys]containsObject:@"error"]){
                        errorMsg = (NSString *)[respo objectForKey:@"error"];
                    }
                    if (callback) {
                        callback(NO,0,0,errorMsg);
                    }
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(NO,0,0,error.localizedDescription);
        }
    }];
}

+ (void)uploadAntiAddictionData:(AntiNotifyRequestParameter *)parameter
                       callback:(void (^)(BOOL, NotifyType, int, int, int, NSString *))callback {
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary* parameters = [parameter parameterInfo];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kNotifyUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            NSString* errorMsg = @"";
            int errorCode = -999;
            if ([[respo allKeys]containsObject:@"error_code"]) {
                errorCode = [[respo objectForKey:@"error_code"]intValue];
                if ([[respo allKeys]containsObject:@"error"]){
                    errorMsg = (NSString *)[respo objectForKey:@"error"];
                }
                if (errorCode == 0) {
                    NSDictionary* data = [respo objectForKey:@"data"];
                    int type = [[data objectForKey:@"type"] intValue];
                    int remainingCost = 0;
                    int remainingTime = 0;
                    if ([[data allKeys]containsObject:@"remaining_cost"]) {
                        remainingCost = [[data objectForKey:@"remaining_cost"] intValue];
                    }
                    if ([[data allKeys]containsObject:@"remaining_time"]) {
                        remainingTime = [[data objectForKey:@"remaining_time"] intValue];
                    }
                    if (callback) {
                        callback(YES,(NotifyType)type,errorCode,remainingTime,remainingCost,errorMsg);
                    }
                    return;
                }
            }
            if (callback) {
                callback(NO,NotifyTypeNone,errorCode,0,0,errorMsg);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(NO,NotifyTypeNone,(int)error.code,0,0,error.localizedDescription);
        }
    }];
}

+ (void)orderToVerify:(PaymentCheckRequestParameter *)parameter
             callback:(void (^)(BOOL success,int errorCode,NSString* errorMsg))callback {
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"content-type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    NSDictionary* parameters = [parameter parameterInfo];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kPaymentCheckUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            int errorCode = -9999;
            NSString* errorMsg = @"";
            if ([[respo allKeys]containsObject:@"error_code"]) {
                errorCode = [[respo objectForKey:@"error_code"]intValue];
                if ([[respo allKeys]containsObject:@"error"]){
                    errorMsg = (NSString *)[respo objectForKey:@"error"];
                }
                if (callback) {
                    callback(errorCode == 0,errorCode,errorMsg);
                }
            }else{
                if (callback) {
                    callback(NO,errorCode,@"server of error!");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(NO,(int)error.code,error.localizedDescription);
        }
    }];
}

+ (void)templateDetail:(TemplateDetailRequeseParameter *)parameter
              callback:(void (^)(BOOL success,int errorCode,NSString* jsonResponse,NSString* errorMsg))callback {
    Yodo1AFHTTPSessionManager *manager = [[Yodo1AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:kRealNameBaseUrl]];
    manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"text/plain" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/plain"];
    
    NSDictionary* parameters = [parameter parameterInfo];
#ifdef DEBUG
    NSLog(@"[ Yodo1 ] parameters:%@",[Yd1OpsTools stringWithJSONObject:parameters error:nil]);
#endif
    [manager POST:kTemplateDetailUrl
       parameters:parameters
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSString* response = [Yd1OpsTools stringWithJSONObject:responseObject error:nil];
        if (response) {
            NSDictionary* respo = [Yd1OpsTools JSONObjectWithString:response error:nil];
            int errorCode = -9999;
            NSString* errorMsg = @"";
            if ([[respo allKeys]containsObject:@"error_code"]) {
                errorCode = [[respo objectForKey:@"error_code"]intValue];
                if ([[respo allKeys]containsObject:@"error"]){
                    errorMsg = (NSString *)[respo objectForKey:@"error"];
                }
                if (callback) {
                    callback(YES,errorCode,response,errorMsg);
                }
            }else{
                if (callback) {
                    callback(NO,errorCode,response,@"server of error!");
                }
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (callback) {
            callback(NO,(int)error.code,nil,error.localizedDescription);
        }
    }];
}


@end

@interface RealNameViewController ()<UITextFieldDelegate> {
    UITextField* idName;
    UITextField* idNunbers;
    UILabel* tips;
    BOOL bSkip;
}

@end

@implementation RealNameViewController

- (BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSInteger length =0;
    if (!value) {
        return NO;
    } else {
        length = value.length;
        ///不满足15位和18位，即身份证错误
        if (length !=15 && length !=18) {
            return NO;
        }
    }
    /// 省份代码
    NSArray *areasArray = @[@"11",@"12", @"13",@"14", @"15",@"21", @"22",@"23", @"31",@"32", @"33",@"34", @"35",@"36", @"37",@"41", @"42",@"43", @"44",@"45", @"46",@"50", @"51",@"52", @"53",@"54", @"61",@"62", @"63",@"64", @"65",@"71", @"81",@"82", @"91"];
    /// 检测省份身份行政区代码
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO; /// 标识省份代码是否正确
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    int year =0;
    /// 分为15位、18位身份证进行校验
    switch (length) {
        case 15:
        {
            ///获取年份对应的数字
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                ///创建正则表达式 NSRegularExpressionCaseInsensitive：不区分字母大小写的模式
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];
                ///测试出生日期的合法性
            } else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                        options:NSRegularExpressionCaseInsensitive error:nil];
                ///测试出生日期的合法性
            }
            ///使用正则表达式匹配字符串 NSMatchingReportProgress:找到最长的匹配字符串后调用block回调
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        }
            break;
        case 18:
        {
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year %4 ==0 || (year %100 ==0 && year %4 ==0)) {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
                //测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc]initWithPattern:@"^((1[1-5])|(2[1-3])|(3[1-7])|(4[1-6])|(5[0-4])|(6[1-5])|71|(8[12])|91)\\d{4}(((19|20)\\d{2}(0[13-9]|1[012])(0[1-9]|[12]\\d|30))|((19|20)\\d{2}(0[13578]|1[02])31)|((19|20)\\d{2}02(0[1-9]|1\\d|2[0-8]))|((19|20)([13579][26]|[2468][048]|0[048])0229))\\d{3}(\\d|X|x)?$" options:NSRegularExpressionCaseInsensitive error:nil];
                //测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                ///1：校验码的计算方法 身份证号码17位数分别乘以不同的系数。从第一位到第十七位的系数分别为：7－9－10－5－8－4－2－1－6－3－7－9－10－5－8－4－2。将这17位数字和系数相乘的结果相加。
                int S = [value substringWithRange:NSMakeRange(0,1)].intValue*7 + [value substringWithRange:NSMakeRange(10,1)].intValue *7 + [value substringWithRange:NSMakeRange(1,1)].intValue*9 + [value substringWithRange:NSMakeRange(11,1)].intValue *9 + [value substringWithRange:NSMakeRange(2,1)].intValue*10 + [value substringWithRange:NSMakeRange(12,1)].intValue *10 + [value substringWithRange:NSMakeRange(3,1)].intValue*5 + [value substringWithRange:NSMakeRange(13,1)].intValue *5 + [value substringWithRange:NSMakeRange(4,1)].intValue*8 + [value substringWithRange:NSMakeRange(14,1)].intValue *8 + [value substringWithRange:NSMakeRange(5,1)].intValue*4 + [value substringWithRange:NSMakeRange(15,1)].intValue *4 + [value substringWithRange:NSMakeRange(6,1)].intValue*2 + [value substringWithRange:NSMakeRange(16,1)].intValue *2 + [value substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                ///2：用加出来和除以11，看余数是多少？余数只可能有0－1－2－3－4－5－6－7－8－9－10这11个数字
                int Y = S %11;
                NSString *M =@"F";
                NSString *JYM =@"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)];// 3：获取校验位
                NSString *lastStr = [value substringWithRange:NSMakeRange(17,1)];
                ///4：检测ID的校验位
                if ([lastStr isEqualToString:@"x"]) {
                    if ([M isEqualToString:@"X"]) {
                        return YES;
                    }else{
                        return NO;
                    }
                }else{
                    if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                        return YES;
                    }else {
                        return NO;
                    }
                }
            }else {
                return NO;
            }
        }
            break;
            
        default:
            return NO;
    }
}

//计算年龄
- (NSString *)calculateAgeStr:(NSString *)str {
    //截取身份证的出生日期并转换为日期格式
    NSString *dateStr = [self subsIDStrToDate:str];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd";//注意这里的字母大小写
    NSDate *birthDate =  [formatter dateFromString:dateStr];
    NSTimeInterval dateDiff = [birthDate timeIntervalSinceNow];
    // 计算年龄
    int age = trunc(dateDiff/(60*60*24))/365;//trunc 取整
    NSString *ageStr = [NSString stringWithFormat:@"%d", -age];
    return ageStr;
}

//截取身份证的出生日期并转换为日期格式
- (NSString *)subsIDStrToDate:(NSString *)str {
    NSMutableString *result = [NSMutableString stringWithCapacity:0];
    NSString *dateStr = [str substringWithRange:NSMakeRange(6, 8)];
    NSString  *year = [dateStr substringWithRange:NSMakeRange(0, 4)];
    NSString  *month = [dateStr substringWithRange:NSMakeRange(4, 2)];
    NSString  *day = [dateStr substringWithRange:NSMakeRange(6,2)];
    [result appendString:year];
    [result appendString:@"-"];
    [result appendString:month];
    [result appendString:@"-"];
    [result appendString:day];
    return result;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationFullScreen;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    bSkip = false;
    self.view.backgroundColor = UIColor.grayColor;
    UITapGestureRecognizer* gr = [UITapGestureRecognizer new];
    [gr addTarget:self action:@selector(cancel:)];
    [self.view addGestureRecognizer:gr];
    
    UIView* background = [UIView new];
    background.backgroundColor = UIColor.whiteColor;
    background.layer.cornerRadius = 16.0;
    float w = 320,h = 320;
    int x = self.view.frame.size.width/2 - w/2;
    int y = self.view.frame.size.height/2 - h/2;
    background.frame = CGRectMake(x, y, w, h);
    [self.view addSubview:background];
    
    UIView* titleBackground = [UIView new];
    titleBackground.backgroundColor = UIColor.orangeColor;
    titleBackground.layer.cornerRadius = 16.0;
    titleBackground.frame = CGRectMake(0, 0, w, 40);
    [background addSubview:titleBackground];
    
    UIView* colover = [UIView new];
    colover.backgroundColor = UIColor.orangeColor;
    colover.frame = CGRectMake(0, 12, w, 40);
    [background addSubview:colover];
    
    UILabel* titleName = [UILabel new];
    titleName.frame = CGRectMake(0, -6, w, 40);
    titleName.textAlignment = NSTextAlignmentCenter;
    [titleName setText:@"游道易手机游戏实名认证"];
    [colover addSubview:titleName];
    
    UITextView* subText = [UITextView new];
    [subText setText:@"根据文化部《网络游戏管理暂行办法》规定，网络游戏用户需使用有效身份证进行实名认证，方可支付。"];
    subText.frame = CGRectMake(20, CGRectGetMaxY(colover.frame), w - 40, 60);
    subText.showsHorizontalScrollIndicator = NO;
    subText.showsVerticalScrollIndicator = NO;
    subText.scrollEnabled = NO;
    subText.backgroundColor = UIColor.whiteColor;
    subText.textColor = UIColor.blackColor;
    subText.editable = NO;
    [background addSubview:subText];
    
    idName = [UITextField new];
    idName.frame = CGRectMake(20, CGRectGetMaxY(subText.frame), w- 40, 40);
    idName.placeholder = @" 姓名";
    idName.clearButtonMode = UITextFieldViewModeAlways;
    idName.delegate = self;
    idName.returnKeyType = UIReturnKeyDone;
    idName.tag = 1008;
    idName.layer.cornerRadius = 4.0f;
    idName.layer.masksToBounds = YES;
    idName.layer.borderColor = [[UIColor grayColor]CGColor];
    idName.layer.borderWidth = 0.5f;
    idName.textColor = UIColor.blackColor;
    idName.backgroundColor = UIColor.whiteColor;
    
    [background addSubview:idName];
    
    idNunbers = [UITextField new];
    idNunbers.frame = CGRectMake(20, CGRectGetMaxY(idName.frame) + 5, w- 40, 40);
    idNunbers.placeholder = @" 身份证";
    idNunbers.clearButtonMode = UITextFieldViewModeAlways;
    idNunbers.delegate = self;
    idNunbers.keyboardType = UIKeyboardTypeNamePhonePad;
    idNunbers.returnKeyType = UIReturnKeyDone;
    idNunbers.tag = 1009;
    idNunbers.layer.cornerRadius = 4.0f;
    idNunbers.layer.masksToBounds = YES;
    idNunbers.layer.borderColor = [[UIColor grayColor]CGColor];
    idNunbers.layer.borderWidth = 0.5f;
    idNunbers.textColor = UIColor.blackColor;
    idNunbers.backgroundColor = UIColor.whiteColor;
    
    [background addSubview:idNunbers];
    
    tips = [UILabel new];
    tips.frame = CGRectMake(20, CGRectGetMaxY(idNunbers.frame), w - 40, 50);
    tips.text = @"请输入姓名";
    [background addSubview:tips];
    tips.hidden = YES;
    tips.textColor = UIColor.redColor;
    
    UIButton* submit = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.layer.cornerRadius = 10;
    submit.frame = CGRectMake(20, h - 40, w - 40, 30);
    [submit setTitle:@"完成认证" forState:UIControlStateNormal];
    submit.backgroundColor = UIColor.orangeColor;
    [submit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    [background addSubview:submit];
    if (_isSkipValidation) {
        UIButton* close = [UIButton buttonWithType:UIButtonTypeSystem];
        close.frame = CGRectMake(w - 44, 10, 44, 30);
        [close setTitle:@"体验" forState:UIControlStateNormal];
        [close addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [background addSubview:close];
    }
}

- (void)close:(id)sender {
    if (self.block) {
        RealNameParameterInfoRequestParameter* info = [RealNameParameterInfoRequestParameter new];
        info.idCode = idNunbers.text;
        info.idType = @"1";
        info.name = idName.text;
        info.signinType = @"online";
        info.age = -111;
        info.isSkip = YES;
        self.block(info);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)cancel:(id)sender {
    if ([idName isFirstResponder]) {
        [idName resignFirstResponder];
    }
    if ([idNunbers isFirstResponder]) {
        [idNunbers resignFirstResponder];
    }
}

- (void)submit:(id)sender {
    ///判断姓名不为空
    if (idName.text.length < 1) {
        tips.text = @"请输入姓名";
        tips.hidden = NO;
        return;
    }
    ///判断身份证
    if (![self validateIDCardNumber:idNunbers.text]) {
        tips.text = @"请输入正确的身份证号码";
        tips.hidden = NO;
        return;
    }
    
    if (self.block) {
        RealNameParameterInfoRequestParameter* info = [RealNameParameterInfoRequestParameter new];
        info.idCode = idNunbers.text;
        info.idType = @"1";
        info.name = idName.text;
        info.signinType = @"online";
        info.age = [[self calculateAgeStr:idNunbers.text]intValue];
        info.isSkip = false;
        self.block(info);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    tips.text = @"";
    tips.hidden = YES;
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    tips.text = @"";
    tips.hidden = YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason  API_AVAILABLE(ios(10.0)){
    tips.text = @"";
    tips.hidden = YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
