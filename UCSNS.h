//
//  KTSNS.h
//  kryptanium_plugin
//
//  Created by xingbin on 2/12/14.
//  Copyright (c) 2014 ktplay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class UCSNSUser;
@class UCSNSAccount;
@interface UCSNS : NSObject

@property (nonatomic,copy) NSString * qqAppId;
@property (nonatomic,copy) NSString * sinaAppId;
@property (nonatomic,copy) NSString * sinaCallbackUrl;
@property (nonatomic,assign) BOOL isUCAuthorzie;

+ (UCSNS*)sharedInstance;

+(UCSNSAccount *)accountWithName:(NSString *)snsName;

+ (BOOL)handleOpenUrl:(NSURL *)url;
+(NSArray *)snsPlugins;
+(NSArray *)pluginsWithRegion:(NSString *)region;
+(NSArray *)pluginsWithActionSupported:(NSString *)action region:(NSString *)region;
+(NSArray *) filterWithSupportSNSLogin:(NSString *)region;
+(NSArray *) filterWithSupportSNSFriends:(NSString *)region;
+(NSArray *) filterWithSupportSNSShare:(NSString *)region;
+(NSArray *) checkSNSIntegrationError;
+(void)clearAllAuthorize;
+ (void)clearAuthorize:(NSString *)snsName;
+ (NSString *)localizedName:(NSString *)snsName;
+ (BOOL)isAuthorize:(NSString *)name;

+ (void) authorize:(NSString *)name  success:(void (^)(UCSNSAccount *account))success failure:(void (^)( NSError *error))failure;
+ (void) postStatus:(NSString *)name target:(NSString *)target title:(NSString *)title status:(NSString *)status imageDict:(NSDictionary *) imageDict url:(NSString *)url success:(void (^)(NSInteger code))success failure:(void (^)( NSError *error))failure;
+ (void) postStatus:(NSString *)name target:(NSString *)target title:(NSString *)title status:(NSString *)status image:(UIImage *) image url:(NSString *)url success:(void (^)(NSInteger code))success failure:(void (^)( NSError *error))failure;
+ (void) requestUserInfo:(NSString *)name  success:(void (^)(UCSNSUser *user))success failure:(void (^)( NSError *error))failure;
+ (void) requestUserInfo:(NSString *)name  userId:(NSString *)userId success:(void (^)(UCSNSUser *user))success failure:(void (^)( NSError *error))failure;

+ (void) requestFriends:(NSString *)name  success:(void (^)(NSArray* users))success failure:(void (^)( NSError *error))failure;
+ (NSString *)localizedName:(NSString *)snsName shareTarget:(NSString *)shareTarget;
+ (NSString *)localizedIconPath:(NSString *)snsName size:(NSString *)size shareTarget:(NSString *)shareTarget;
+ (NSString *)localizedIconPath:(NSString *)snsName size:(NSString *)size type:(NSString *)type shareTarget:(NSString *)shareTarget;


+ (NSArray *)shareableTargets:(NSString *)snsName;
@end
