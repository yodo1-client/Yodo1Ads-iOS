//
//  GDTDataDetector.h
//  GDTMobApp
//
//  Created by nimo on 2020/8/18.
//  Copyright © 2020 Tencent. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

// 预定义事件
/// 登录
extern NSString const *kDDLogin;
/// 初始化信息
extern NSString const *kDDInitInfo;
/// 广告请求
extern NSString const *kDDADRequest;
/// 广告返回
extern NSString const *kDDADSend;
/// 广告位按钮展示
extern NSString const *kDDADButtonShow;
/// 广告位按钮点击
extern NSString const *kDDADButtonClick;
/// 广告展示
extern NSString const *kDDADShow;
/// 广告展示完成
extern NSString const *kDDADShowEnd;
/// 新手引导
extern NSString const *kDDGuide;
/// 升级（不分场景）
extern NSString const *kDDLevelUp;
/// 升级（分场景）
extern NSString const *kDDPlayLevelUp;
/// 活动参与及奖励
extern NSString const *kDDActivity;
/// 开始主玩法
extern NSString const *kDDStartPlay;
/// 结束主玩法
extern NSString const *kDDEndPlay;
/// 复活
extern NSString const *kDDRevive;
/// 类装备获取
extern NSString const *kDDGetEqu;
/// 装备养成
extern NSString const *kDDEquGrowup;
/// 解锁玩法/系统
extern NSString const *kDDUnlockSystem;
/// 玩法/系统参与
extern NSString const *kDDJoinSystem;
/// 各类功能按钮展示
extern NSString const *kDDAllButtonShow;
/// 各类功能按钮的点击
extern NSString const *kDDAllButtonClick;
/// 某封邮件点击
extern NSString const *kDDMailClick;
/// 领取邮件奖励
extern NSString const *kDDMailReward;
/// 帮派/俱乐部
extern NSString const *kDDGroup;
/// 排行榜名次变动
extern NSString const *kDDRank;
/// 多个展示中选择
extern NSString const *kDDItemSelect;
/// 简单物品获得
extern NSString const *kDDGetItem;
/// 简单物品消耗
extern NSString const *kDDCostItem;
/// 复杂物品获得
extern NSString const *kDDGetProp;
/// 复杂物品升级
extern NSString const *kDDPropLevelup;
/// 任务达成
extern NSString const *kDDMissionEnd;
/// 任务奖励领取
extern NSString const *kDDMissionReward;
/// 获得游戏币
extern NSString const *kDDGetCoins;
/// 消耗游戏币
extern NSString const *kDDCostCoins;
/// 商城
extern NSString const *kDDShopTrade;
/// 分享点击
extern NSString const *kDDShareClick;
/// 分享结果
extern NSString const *kDDShareResult;
/// 路径转化
extern NSString const *kDDModuleConversion;
/// 切换账号
extern NSString const *kDDAccountChange;

@interface GDTDataDetector : NSObject

/// 发送事件
/// @param eventName 事件名，不能为nil或者空字符串
/// @param params 事件参数，为Dictionary类型，可以为空或者nil。如果param非空，需要可以序列化成jsonString。Param参数总长度不能超过10KB
+ (void)sendEventWithName:(NSString *)eventName extParams:(nullable NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END
