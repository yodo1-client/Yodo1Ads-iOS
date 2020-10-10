//
//  Utils.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/6.
//

#import "Yodo1AntiIndulgedUtils.h"
#import <CommonCrypto/CommonDigest.h>
#import "Yodo1AntiIndulgedMainVC.h"

@implementation Yodo1AntiIndulgedUtils

+ (NSString *)dateString:(NSDate *)date {
    return [self dateString:date format:nil];
}

+ (NSString *)dateString:(NSDate *)date format:(NSString * _Nullable)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format ? format : @"yyyy-MM-dd";
    return [formatter stringFromDate:date];
}

+ (NSString *)md5String:(NSString *)input {
    const char *str = [input UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        //%02意思是不足两位将用0补齐，如果多于两位则不影响
        //小写x表示输出小写，大写X表示输出大写,可以根据需求更改
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+ (BOOL)isChineseName:(NSString *)input {
    if (!input) {
        return NO;
    }
    input = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *regex = @"^[\u4e00-\u9fa5]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:input];
}

+ (BOOL)isChineseId:(NSString *)input {
    if (!input || input.length == 0) {
        return NO;
    }
    NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:input];
}

+ (NSRange)getAgeRange:(NSString *)range {
    if (range) {
        NSArray *ages = [range componentsSeparatedByString:@"-"];
        if (ages && ages.count == 2) {
            NSInteger min = [ages[0] integerValue];
            NSInteger max = [ages[1] integerValue];
            return NSMakeRange(min, max - min);
        }
    }
    return NSMakeRange(0, 0);
}

+ (NSRange)getTimeRange:(NSString *)range {
    if (range) {
        NSArray *times = [range componentsSeparatedByString:@"-"];
        if (times && times.count == 2) {
            NSInteger min = [self timeToInt:times[0]];
            NSInteger max = [self timeToInt:times[1]];
            return NSMakeRange(min, max - min);
        }
    }
    return NSMakeRange(480, 840); // 08:00 - 22:00
}

+ (BOOL)locationInRange:(NSInteger)location range:(NSRange)range {
    return location >= range.location && location <= range.location + range.length;
}

+ (BOOL)age:(NSInteger)age inRange:(NSString *)range {
    return [self locationInRange:age range:[self getAgeRange:range]];
}

+ (NSInteger)timeToInt:(NSString *)time {
    NSArray *times = [time componentsSeparatedByString:@":"];
    return [times[0] integerValue] * 60 + [times[1] integerValue];
}

+ (NSRange)time:(NSInteger)time inRange:(NSString *)range {
    NSRange timeRange = [self getTimeRange:range];
    if ([self locationInRange:time range:timeRange]) {
        return timeRange;
    } else {
        return NSMakeRange(0, 0);
    }
}

+ (UIWindow *)getTopWindow {
    UIWindow *rootWindow;
    NSArray<UIWindow *> *windows;
    
    if (windows == nil) {
        UIApplication *app = [UIApplication sharedApplication];
        if (@available(iOS 13.0, *)) {
            if (app.supportsMultipleScenes) {
                for (UIScene *scene in app.connectedScenes) {
                    if (scene.activationState == UISceneActivationStateForegroundActive && [scene isKindOfClass:[UIWindowScene class]]) {
                        windows = ((UIWindowScene *)scene).windows;
                        break;
                    }
                }
            }
        }
        if (windows == nil) {
            windows = app.windows;
        }
    }
    
    if (windows != nil) {
        if (rootWindow == nil) {
            for (UIWindow *window in windows) {
                if (window.isKeyWindow) {
                    rootWindow = window;
                    break;
                }
            }
        }
        
        if (rootWindow == nil) {
            for (UIWindow *window in windows) {
                if (window.windowLevel == 0) {
                    rootWindow = window;
                    break;
                }
            }
        }
    }
    return rootWindow;
}

+ (void)showVerifyUI {
    [self showVerifyUI:NO];
}

+ (void)showVerifyUI:(BOOL)hideGuest {
    UIViewController *controller = [self getTopViewController];
    if (controller) {
        Yodo1AntiIndulgedMainVC *mainVC = (Yodo1AntiIndulgedMainVC *)[Yodo1AntiIndulgedMainVC loadFromStoryboard];
        mainVC.hideGuest = hideGuest;
        mainVC.modalPresentationStyle = UIModalPresentationOverFullScreen;
        [controller presentViewController:mainVC animated:YES completion:nil];
    }
}

+ (UIViewController *)getTopViewController {
    UIWindow *window = [self getTopWindow];
    if (window) {
        return [self getTopViewController:window.rootViewController];
    }
    return nil;
}

+ (UIViewController *)getTopViewController: (UIViewController *)controller {
    if (controller.presentedViewController) {
        return [self getTopViewController:controller.presentedViewController];
    } else if ([controller isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)controller;
        return [self getTopViewController:tabBarController.selectedViewController];
    } else if ([controller isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navController = (UINavigationController *)controller;
        return [self getTopViewController:navController.visibleViewController];
    } else {
        return controller;
    }
}

+ (NSError *)errorWithCode:(NSInteger)code msg:(NSString *)msg {
    return [NSError errorWithDomain:@"https://api.yodo1.com" code:code userInfo:@{NSLocalizedDescriptionKey : msg ? msg : @"未知错误"}];
}

@end
