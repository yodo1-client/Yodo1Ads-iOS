//
//  Yodo1NetworkManager.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionNet.h"
#import <Yodo1AFNetworking/Yodo1AFNetworking.h>
#import <Yodo1YYModel/Yodo1Model.h>
#import <Yodo1OnlineParameter/Yd1OnlineParameter.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Commons.h>
#import <Yodo1OnlineParameter/Yodo1Tool+Storage.h>
#import "Yodo1AntiAddictionHelper.h"
#import "Yodo1AntiAddictionUserManager.h"

@implementation Yodo1AntiAddictionResponse

@end

@interface Yodo1AntiAddictionNet()

@property (nonatomic, strong) Yodo1AFHTTPSessionManager *manager;

@end

@implementation Yodo1AntiAddictionNet

+ (Yodo1AntiAddictionNet *)manager {
    static Yodo1AntiAddictionNet *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Yodo1AntiAddictionNet alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
#ifdef DEBUG
        NSURL *baseURL = [NSURL URLWithString:@"https://ais-frontend.cb64eaf4841914d918c93a30369d6bbc6.cn-beijing.alicontainer.com/ais"];
#else
        NSURL *baseURL = [NSURL URLWithString:@"https://ais.yodo1api.com/ais"];
#endif
        _manager = [[Yodo1AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        _manager.requestSerializer = [Yodo1AFJSONRequestSerializer serializer];
        _manager.responseSerializer = [Yodo1AFJSONResponseSerializer serializer];
#ifdef DEBUG
        Yodo1AFSecurityPolicy *security = [Yodo1AFSecurityPolicy policyWithPinningMode:Yodo1AFSSLPinningModeNone];
        [security setValidatesDomainName:NO];
        security.allowInvalidCertificates = YES;
        _manager.securityPolicy = security;
#endif
    }
    return self;
}

- (NSURLSessionDataTask *)GET:(NSString *)path parameters:parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self request:@"GET" path:path parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)POST:(NSString *)path parameters:parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self request:@"POST" path:path parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)DELETE:(NSString *)path parameters:parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self request:@"DELETE" path:path parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)PUT:(NSString *)path parameters:parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    return [self request:@"PUT" path:path parameters:parameters success:success failure:failure];
}

- (NSURLSessionDataTask *)request:(NSString *)method path:(NSString *)path parameters:parameters success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
        failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure
{
    NSURLSessionDataTask *dataTask = [self dataTaskWithHTTPMethod:method URLString:path parameters:parameters success:success failure:failure];
    [dataTask resume];
    return dataTask;
}


- (NSURLSessionDataTask *)dataTaskWithHTTPMethod:(NSString *)method
                                       URLString:(NSString *)URLString
                                      parameters:(id)parameters
                                         success:(void (^)(NSURLSessionDataTask *, id))success
                                         failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [_manager.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:_manager.baseURL] absoluteString] parameters:parameters error:&serializationError];
    
    [request setValue:[Yd1OnlineParameter shared].appKey forHTTPHeaderField:@"game-id"];
    [request setValue:[Yd1OnlineParameter shared].channelId forHTTPHeaderField:@"channel-id"];
    [request setValue:[[Yodo1AntiAddictionHelper shared] getSdkVersion] forHTTPHeaderField:@"sdk-version"];
    [request setValue:[Yodo1Tool shared].keychainDeviceId forHTTPHeaderField:@"device-id"];
    [request setValue:[Yodo1Tool shared].appVersion forHTTPHeaderField:@"game-version"];
    
    Yodo1AntiAddictionUser *user = [Yodo1AntiAddictionUserManager manager].currentUser;
    if (user) {
        if (user.uid) {
            [request setValue:user.uid forHTTPHeaderField:@"uid"];
        }
        if (user.yid) {
            [request setValue:user.yid forHTTPHeaderField:@"yid"];
        }
    }
    
    
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(_manager.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }

        return nil;
    }

    __block NSURLSessionDataTask *dataTask = nil;
    dataTask = [_manager dataTaskWithRequest:request
                          uploadProgress:nil
                        downloadProgress:nil
                       completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
        if (error) {
            if (failure) {
                failure(dataTask, error);
            }
        } else {
            if (success) {
                success(dataTask, responseObject);
            }
        }
    }];

    return dataTask;
}

@end
