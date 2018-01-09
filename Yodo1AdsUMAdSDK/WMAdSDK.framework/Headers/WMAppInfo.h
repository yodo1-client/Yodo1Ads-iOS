//
//  WMAppInfo.h
//  WMAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMDeepLink.h"
#import "WMActionServiceDefine.h"


@interface WMAppInfo : NSObject <WMActionAppModel, NSCoding>

// 应用名称
@property (nonatomic, copy) NSString *appName;

@property (nonatomic, copy) NSString *appid;

//// 应用下载包名
//@property (nonatomic, copy) NSString *packageName;

// 应用下载URL，应用下载必须
@property (nonatomic, copy) NSString *downloadURL;

// 应用app的评分，默认为0
@property (nonatomic, assign) NSInteger appScore;

// 下载量或使用人数
@property (nonatomic, assign) NSInteger userNumber;

// deeplink信息
@property (nonatomic, strong) WMDeepLink *deepLink;

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError * __autoreleasing *)error;

@end

