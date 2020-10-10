//
//  Yodo1AntiIndulgedUtils.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

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

+ (void)showVerifyUI;
+ (void)showVerifyUI:(BOOL)hideGuest;
+ (UIWindow *)getTopWindow;
+ (UIViewController *)getTopViewController;

+ (NSError *)errorWithCode:(NSInteger)code msg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
