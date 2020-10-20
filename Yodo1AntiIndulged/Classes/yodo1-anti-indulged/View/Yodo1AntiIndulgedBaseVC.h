//
//  Yodo1AntiIndulgedBaseVC.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <Toast/Toast.h>
#import "Yodo1AntiIndulgedHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface Yodo1AntiIndulgedBaseVC : UIViewController

+ (instancetype)loadFromStoryboard;
+ (NSString *)identifier;

- (void)didInitialize;

@end

NS_ASSUME_NONNULL_END
