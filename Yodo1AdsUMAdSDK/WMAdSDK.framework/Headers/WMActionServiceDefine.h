//
//  WMActionServiceDefine.h
//  WMAdSDK
//
//  Created by carl on 2017/8/8.
//  Copyright © 2017年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WMDeepLink;

@protocol WMActionWebModel <NSObject>
// 创意的落地页URL
@property (nonatomic, copy) NSString *targetURL;
@end

@protocol WMActionPhoneModel <NSObject>
// 广告类型为电话时，电话号码必须
@property (nonatomic, copy) NSString *phone;

@end

@protocol WMActionAppModel <NSObject>
// 应用名称
@property (nonatomic, copy) NSString *appName;

@property (nonatomic,copy) NSString *appid;

// 应用下载URL，应用下载必须
@property (nonatomic, copy) NSString *downloadURL;

// deeplink信息
@property (nonatomic, strong) WMDeepLink *deepLink;

@end

