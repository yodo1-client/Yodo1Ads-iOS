//
//  Yodo1AntiAddictionInputVC.h
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Yodo1AntiAddictionInputDelegate <NSObject>

@optional
- (void)didUnableClicked;
- (void)didInfoChecked:(id)user;

@end

@interface Yodo1AntiAddictionInputVC : Yodo1AntiAddictionBaseVC

@property (nonatomic, weak) id<Yodo1AntiAddictionInputDelegate> delegate;
@property (nonatomic, assign) BOOL hideGuest;

@end

NS_ASSUME_NONNULL_END
