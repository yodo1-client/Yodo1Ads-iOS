//
//  MoreGameManager.h
//  MoreGameManager
//
//  Created by hyx on 12-11-28.
//  Copyright (c) 2012年 游道易. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MoreGameManagerDelegate <NSObject>

@optional

/**
 more game show callback
 */
- (void) moreGameManagerShow;

/**
 more game close callback
 */
- (void) moreGameManagerClose;

@end

@interface MoreGameManager : NSObject

@property(nonatomic, assign) id <MoreGameManagerDelegate>delegate;

/**
*  返回MoreGameManager单例
*
*  @return MoreGameManager实例
*/
+ (MoreGameManager*)sharedInstance;

/**
 *  设置game_appkey.
 *
 *  @param gameAppKey Yodo1每个项目游戏唯一的appkey
 */
- (void)setGameAppKey:(NSString*)gameAppKey;

/**
 *  检测是否有GMG数据
 *
 *  @return 返回YES,有数据可以展示，否则返回NO，没有数据
 */
- (BOOL)isHasData;

/**
 *  more game 友盟在线参数
 *
 *  @return 返回YES,友盟在线参数开启，否则返回NO，友盟在线参数没有开启或者获取不到在线参数
 */
- (BOOL)switchYodo1GMG;

/**
 *  展示GMG
 */
- (void)present;

/**
 *   more game sdk的版本号
 *
 *  @return sdk版本号
 */
- (NSString*)sdkVersion;

/**
 *  设置debug模式
 *
 *  @param debugMode YES开启测试模式，NO是正式模式release
 */
- (void)setDebugMode:(BOOL)debugMode;

/**
 *  debug模式
 *
 *  @return 返回YES,开启测试模式，否则返回NO，正式模式release
 */
- (BOOL)isDebugMode;

@end
