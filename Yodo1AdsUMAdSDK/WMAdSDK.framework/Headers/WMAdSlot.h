//
//  WMAdSlot.h
//  WMAdSDK
//
//  Created by chenren on 10/05/2017.
//  Copyright © 2017 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WMSize.h"

// 1:Banner横幅，2:插屏，3:开屏，4:信息流，5:资讯联播
typedef NS_ENUM(NSInteger, WMAdSlotAdType) {
    WMAdSlotAdTypeUnknown,
    WMAdSlotAdTypeBanner = 1,       // 横幅广告
    WMAdSlotAdTypeInterstitial = 2, // 插屏广告
    WMAdSlotAdTypeSplash = 3,       // 全屏广告
    WMAdSlotAdTypeFeed = 4,         // 信息流广告
    WMAdSlotAdTypeZixun = 5,        // 资讯联播
};

typedef NS_ENUM(NSInteger, WMAdSlotPosition) {
    WMAdSlotPositionFeed,
    WMAdSlotPositionTop,
    WMAdSlotPositionBottom,
    WMAdSlotPositionMiddle,
    WMAdSlotPositionFullscreen,
};


@interface WMAdSlot : NSObject

// 代码位ID required
@property (nonatomic, copy) NSString *ID;

// 广告类型 required
@property (nonatomic, assign) WMAdSlotAdType AdType;

// 广告展现位置 required
@property (nonatomic, assign) WMAdSlotPosition position;

// 接受一组图片尺寸，数组请传入WMSize对象
@property (nonatomic, strong) NSMutableArray *imgSizeArray;

// 图片尺寸 required
@property (nonatomic, strong) WMSize *imgSize;

// 图标尺寸
@property (nonatomic, strong) WMSize *iconSize;

// 标题的最大长度
@property (nonatomic, assign) NSInteger titleLengthLimit;

// 描述的最大长度
@property (nonatomic, assign) NSInteger descLengthLimit;

// 是否支持deeplink
@property (nonatomic, assign) BOOL isSupportDeepLink;

// 广告数量，主要针对feed流广告，对banner广告请求没有影响
@property (nonatomic, assign) NSInteger AdCount;

- (NSDictionary *)dictionaryValue;

@end

