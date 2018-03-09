//
//  WMRewardedVideoModel.h
//  WMAdSDK
//
//  Created by gdp on 2018/1/18.
//  Copyright © 2018年 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMRewardedVideoModel : NSObject

// 第三方游戏 user_id 标识，必传
@property (nonatomic, copy) NSString *userId;

// 奖励名称，可选
@property (nonatomic, copy) NSString *rewardName;

// 奖励数量，可选
@property (nonatomic, assign) NSInteger rewardAmount;

// 序列化后的字符串，可选
@property (nonatomic, copy) NSString *extra;

// 是否展示下载 Bar，默认 YES
@property (nonatomic, assign) BOOL isShowDownloadBar;

@end
