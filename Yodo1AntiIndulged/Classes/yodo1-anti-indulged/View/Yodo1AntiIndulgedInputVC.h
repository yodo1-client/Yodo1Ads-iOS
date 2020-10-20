//
//  Yodo1AntiIndulgedInputVC.h
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedBaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Yodo1AntiIndulgedInputDelegate <NSObject>

@optional
- (void)didUnableClicked;
- (void)didInfoChecked:(id)user;

@end

@interface Yodo1AntiIndulgedInputVC : Yodo1AntiIndulgedBaseVC

@property (nonatomic, weak) id<Yodo1AntiIndulgedInputDelegate> delegate;
@property (nonatomic, assign) BOOL hideGuest;

@end

NS_ASSUME_NONNULL_END
