//
//  Yodo1AntiIndulgedBaseVC.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedBaseVC.h"
#import "Yodo1AntiIndulgedUtils.h"

@interface Yodo1AntiIndulgedBaseVC ()

@end

@implementation Yodo1AntiIndulgedBaseVC

+ (instancetype)loadFromStoryboard {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"AntiIndulged" bundle:[Yodo1AntiIndulgedUtils bundle]];
    return (Yodo1AntiIndulgedBaseVC *)[storyboard instantiateViewControllerWithIdentifier:[self identifier]];
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
