//
//  Yodo1AntiIndulgedUtils.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSInteger {
    Yodo1AntiIndulgedTimeUnitMS = 0,  // 毫秒
    Yodo1AntiIndulgedTimeUnitSecond = 1, // 秒
    Yodo1AntiIndulgedTimeUnitMinute = 2, // 分钟
    Yodo1AntiIndulgedTimeUnitHour = 3, // 小时
    Yodo1AntiIndulgedTimeUnitDay = 4 // 天
} Yodo1AntiIndulgedTimeUnit;

@interface Yodo1AntiIndulgedUtils : NSObject

+ (NSString *)dateString:(NSDate *)date;
+ (NSString *)dateString:(NSDate *)date format:(NSString * _Nullable)format;

+ (NSString *)md5String:(NSString *)input;
+ (BOOL)isChineseName:(NSString *)input;
+ (BOOL)isChineseId:(NSString *)input;

+ (NSRange)getAgeRange:(NSString *)range;
+ (NSRange)getTimeRange:(NSString *)range;
+ (NSInteger)timeToInt:(NSString *)time;
+ (BOOL)locationInRange:(NSInteger)location range:(NSRange)range;
+ (BOOL)age:(NSInteger)age inRange:(NSString *)range;
+ (NSRange)time:(NSInteger)time inRange:(NSString *)range;
+ (NSTimeInterval)convert:(NSTimeInterval)time fromUnit:(Yodo1AntiIndulgedTimeUnit)from toUnit:(Yodo1AntiIndulgedTimeUnit)to;

+ (void)showVerifyUI;
+ (void)showVerifyUI:(BOOL)hideGuest;
+ (UIWindow *)getTopWindow;
+ (UIViewController *)getTopViewController;

+ (NSError *)errorWithCode:(NSInteger)code msg:(NSString *)msg;
+ (BOOL)isNetError:(NSError *)error;
+ (NSError *)convertError:(NSError *)error;
+ (NSString *)stringWithJSONObject:(id)obj error:(NSError**)error;

+ (NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
