//
//  Yodo1AntiAddictionDialogVC.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSUInteger {
    Yodo1AntiAddictionDialogStyleBuyDisable = 1001, // 只有游客禁止购买
    Yodo1AntiAddictionDialogStyleBuyOverstep = 1002, // 超出购买额度
    Yodo1AntiAddictionDialogStyleTimeDisable = 1003, // 禁玩时段
    Yodo1AntiAddictionDialogStyleTimeOverstep = 1004, // 时间超出
    Yodo1AntiAddictionDialogStyleVisitorOver = 1005, // 游客模式结束
    Yodo1AntiAddictionDialogStyleNetError = 1006, // 网络错误
    Yodo1AntiAddictionDialogStyleCheckDisable = 1007, // 验证次数用完
    Yodo1AntiAddictionDialogStyleCheckUnable = 1008, // 无法通过审核
    Yodo1AntiAddictionDialogStyleError = 1000
} Yodo1AntiAddictionDialogStyle;

@interface Yodo1AntiAddictionDialogVC : Yodo1AntiAddictionBaseVC

@property (nonatomic, assign) Yodo1AntiAddictionDialogStyle style;
@property (nonatomic, copy) NSString *msg;

+ (void)showDialog:(Yodo1AntiAddictionDialogStyle)style error:(NSString * _Nullable)error;

@end

@interface YMCardPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

@end

NS_ASSUME_NONNULL_END
