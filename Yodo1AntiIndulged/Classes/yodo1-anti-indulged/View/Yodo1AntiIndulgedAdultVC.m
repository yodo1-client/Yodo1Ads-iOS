//
//  Yodo1AntiIndulgedAdultVC.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedAdultVC.h"

@interface Yodo1AntiIndulgedAdultVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;

@end

@implementation Yodo1AntiIndulgedAdultVC

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
        Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
        event.eventCode = Yodo1AntiIndulgedEventCodeNone;
        event.action = Yodo1AntiIndulgedActionResumeGame;
        [[Yodo1AntiIndulgedHelper shared] successful: event];
    }];
}

@end
