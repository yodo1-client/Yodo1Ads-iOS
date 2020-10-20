//
//  Yodo1AntiIndulgedDialogVC.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSUInteger {
    Yodo1AntiIndulgedDialogStyleBuyDisable = 1001, // 只有游客禁止购买
    Yodo1AntiIndulgedDialogStyleBuyOverstep = 1002, // 超出购买额度
    Yodo1AntiIndulgedDialogStyleTimeDisable = 1003, // 禁玩时段
    Yodo1AntiIndulgedDialogStyleTimeOverstep = 1004, // 时间超出
    Yodo1AntiIndulgedDialogStyleVisitorOver = 1005, // 游客模式结束
    Yodo1AntiIndulgedDialogStyleNetError = 1006, // 网络错误
    Yodo1AntiIndulgedDialogStyleCheckDisable = 1007, // 验证次数用完
    Yodo1AntiIndulgedDialogStyleCheckUnable = 1008, // 无法通过审核
    Yodo1AntiIndulgedDialogStyleError = 1000
} Yodo1AntiIndulgedDialogStyle;

@interface Yodo1AntiIndulgedDialogVC : Yodo1AntiIndulgedBaseVC

@property (nonatomic, assign) Yodo1AntiIndulgedDialogStyle style;
@property (nonatomic, copy) NSString *msg;

+ (void)showDialog:(Yodo1AntiIndulgedDialogStyle)style error:(NSString * _Nullable)error;

@end

@interface YMCardPresentationController : UIPresentationController <UIViewControllerTransitioningDelegate>

@end

NS_ASSUME_NONNULL_END
