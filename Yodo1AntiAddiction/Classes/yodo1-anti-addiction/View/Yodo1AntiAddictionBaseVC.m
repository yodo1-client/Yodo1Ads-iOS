//
//  Yodo1AntiAddictionBaseVC.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionBaseVC.h"
#import "Yodo1AntiAddictionUtils.h"

@interface Yodo1AntiAddictionBaseVC ()

@end

@implementation Yodo1AntiAddictionBaseVC

+ (instancetype)loadFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AntiAddiction" bundle:[Yodo1AntiAddictionUtils bundle]];
    return (Yodo1AntiAddictionBaseVC *)[storyboard instantiateViewControllerWithIdentifier:[self identifier]];
}

+ (NSString *)identifier {
    return NSStringFromClass([self class]);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self didInitialize];
    }
    return self;
}

- (void)didInitialize {
    if (@available(iOS 13.0, *)) {
        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (BOOL)shouldAutorotate {
    return NO;
}

@end
