//
//  Yodo1AntiAddictionHelpVC.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnBackClickedBlock)(void);

@interface Yodo1AntiAddictionHelpVC : Yodo1AntiAddictionBaseVC

@property (nonatomic, copy) OnBackClickedBlock onBackClicked;

@end

NS_ASSUME_NONNULL_END
