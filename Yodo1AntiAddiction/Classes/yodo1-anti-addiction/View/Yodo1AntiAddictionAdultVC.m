//
//  Yodo1AntiAddictionAdultVC.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionAdultVC.h"

@interface Yodo1AntiAddictionAdultVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

@implementation Yodo1AntiAddictionAdultVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat height = UIScreen.mainScreen.bounds.size.height / 3 * 2;
    CGFloat max = 265;
    if (@available(iOS 11.0, *)) {
        max = max + self.view.safeAreaInsets.bottom;
    }
    _contentHeight.constant = height > max ? max : height;
}

#pragma mark - Event
// 进入游戏
- (IBAction)onEnterClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        Yodo1AntiAddictionEvent *event = [[Yodo1AntiAddictionEvent alloc] init];
        event.eventCode = Yodo1AntiAddictionEventCodeNone;
        event.action = Yodo1AntiAddictionActionResumeGame;
        [[Yodo1AntiAddictionHelper shared] successful: event];
    }];
}

@end
