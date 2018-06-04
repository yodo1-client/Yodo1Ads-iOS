//
//  AdCompViewDelegate.h
//  KuaiYouAdHello
//
//  Created by adview on 13-12-12.
//
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>

//开屏位置 1居上 2居下
typedef enum{
    AdCompSpreadShowTypeTop = 1,
    AdCompSpreadShowTypeBottom = 2,
}AdCompSpreadShowType;

@class AdCompView;
@protocol AdCompViewDelegate <NSObject>

@optional
- (NSString*)appPwd;

- (UIColor*)adTextColor;
- (UIColor*)adBackgroundColor;
- (NSString*)adBackgroundImgName;
- (NSString*)logoImgName;//开屏logo图片的名字;

- (BOOL)usingHTML5;//是否使用html5广告

- (BOOL)usingSKStoreProductViewController;//是否使用应用内打开AppStore

/**
 * 广告请求成功
 */

- (void)didReceivedAd:(AdCompView*)adView reuse:(BOOL)isReuse;

/**
 * 广告请求失败
 */

- (void)didFailToReceiveAd:(AdCompView*)adView Error:(NSError*)error;

- (NSString*)AdCompViewHost;
- (int)autoRefreshInterval;	//<=0 - none, <15 - 15, unit: seconds
- (int)gradientBgType;		//-1 - none, 0 - fix, 1 - random

- (UIViewController*)viewControllerForShowModal;

/**
 * 广告网页将要展示回调
 */

- (void)adViewWillPresentScreen:(AdCompView *)adView;

/**
 * 广告网页将要关闭回调
 */

- (void)adViewDidDismissScreen:(AdCompView *)adView;

/**
 * 插屏/开屏关闭回调
 */

- (void)adInstlDidDismissScreen:(AdCompView *)adInstl;

/**
 * 是否为测试模式
 */
- (BOOL)testMode;

/**
 * 是否使用缓存
 */
- (BOOL)usingCache;

/**
 * 是否打印日志
 */
- (BOOL)logMode;

- (int)configVersion;

/**
 * 获取 location 信息
 */
- (CLLocation*)getLocation;
/**
 * 有些开发者需要展示广告的位置变动 默认为屏幕中心 例子: return 20 即广告中心点向上移动 20
 */

- (float)moveCentr;
/**
 * 等比例缩放 有限制范围为 0.8 - 1.2 之间
 */
- (float)scaleProportion;

@required

- (NSString*)appId;

@end
