//
//  Yodo1AntiAddictionUtils.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSInteger {
    Yodo1AntiAddictionTimeUnitMS = 0,  // 毫秒
    Yodo1AntiAddictionTimeUnitSecond = 1, // 秒
    Yodo1AntiAddictionTimeUnitMinute = 2, // 分钟
    Yodo1AntiAddictionTimeUnitHour = 3, // 小时
    Yodo1AntiAddictionTimeUnitDay = 4 // 天
} Yodo1AntiAddictionTimeUnit;

@interface Yodo1AntiAddictionUtils : NSObject

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
+ (NSTimeInterval)convert:(NSTimeInterval)time fromUnit:(Yodo1AntiAddictionTimeUnit)from toUnit:(Yodo1AntiAddictionTimeUnit)to;

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
