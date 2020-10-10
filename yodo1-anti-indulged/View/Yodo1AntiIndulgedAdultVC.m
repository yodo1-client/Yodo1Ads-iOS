//
//  Yodo1AntiIndulgedAdultVC.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedAdultVC.h"

@interface Yodo1AntiIndulgedAdultVC ()

@end

@implementation Yodo1AntiIndulgedAdultVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
