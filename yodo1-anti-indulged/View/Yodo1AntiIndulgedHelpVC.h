//
//  Yodo1AntiIndulgedHelpVC.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^OnBackClickedBlock)(void);

@interface Yodo1AntiIndulgedHelpVC : Yodo1AntiIndulgedBaseVC

@property (nonatomic, copy) OnBackClickedBlock onBackClicked;

@end

NS_ASSUME_NONNULL_END
