//
//  Yodo1AntiIndulgedInputVC.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedInputVC.h"
#import "Yodo1AntiIndulgedUserManager.h"
#import "Yodo1AntiIndulgedDialogVC.h"
#import "Yodo1AntiIndulgedUtils.h"

@interface Yodo1AntiIndulgedInputVC ()<UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UITextField *nameField; // 姓名
@property (weak, nonatomic) IBOutlet UILabel *nameHint;

@property (weak, nonatomic) IBOutlet UITextField *identifyField; // 身份证
@property (weak, nonatomic) IBOutlet UILabel *identifyHint;

@property (weak, nonatomic) IBOutlet UIButton *unableButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (weak, nonatomic) IBOutlet UIButton *experienceButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation Yodo1AntiIndulgedInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _nameField.delegate = self;
    _identifyField.delegate = self;
    
    _nameHint.text = nil;
    _identifyHint.text = nil;
    _experienceButton.hidden = _hideGuest;
    _lineView.hidden = _hideGuest;
    
    [self setLoading:NO];
}

- (void)setLoading:(BOOL)loading {
    _nameField.enabled = !loading;
    _identifyField.enabled = !loading;
    _unableButton.enabled = !loading;
    _submitButton.enabled = !loading;
    _experienceButton.enabled = !loading;
    
    if (loading) {
        _submitButton.backgroundColor = [UIColor clearColor];
        [_submitButton setImage:nil forState:UIControlStateNormal];
        [_submitButton setTitle:@"正在核查 请稍后" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    } else {
        _submitButton.backgroundColor = [UIColor colorWithRed:63 / 255.0 green:143 / 255.0 blue:1 / 255.0 alpha:1];
        [_submitButton setImage:[UIImage imageNamed:@"right"] forState:UIControlStateNormal];
        [_submitButton setTitle:@"提交验证" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}

#pragma mark - Event
// 无法通过验证？
- (IBAction)onUnableClicked:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(didUnableClicked)]) {
        [_delegate didUnableClicked];
    }
}

// 提交
- (IBAction)onSubmitClicked:(id)sender {
    [_nameField resignFirstResponder];
    [_identifyField resignFirstResponder];
    
    NSString *name = [_nameField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![Yodo1AntiIndulgedUtils isChineseName:name]) {
        [self.view makeToast:@"请输入中文姓名"];
        return;
    }
    
    if (!name || name.length < 2) {
        [self.view makeToast:@"至少输入2个中文"];
        return;
    }
    
    if (name.length > 50) {
        [self.view makeToast:@"最多输入50个中文"];
        return;
    }
    
    NSString *identify = [_identifyField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (![Yodo1AntiIndulgedUtils isChineseId:identify]) {
        [self.view makeToast:@"请输入18位有效身份证"];
        return;
    }
    
    [self setLoading:YES];
    [[Yodo1AntiIndulgedUserManager manager] post:name identify:identify success:^(id data) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(didInfoChecked:)]) {
            NSInteger status = [data[@"status"] integerValue];
            if (status >= 0) {
                [self.delegate didInfoChecked:[Yodo1AntiIndulgedUserManager manager].currentUser];
            } else {
                [self setLoading:NO];
                NSInteger retryTimes = [data[@"retryTimes"] integerValue];
                if (status == -1) {
                    NSString *msg = [NSString stringWithFormat:@"请核对您的身份证是否输入正确或姓名和身份证是否匹配，然后重试。\n今日还剩有 %@  次核查机会", @(retryTimes)];
                    [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleCheckUnable error:msg];
                } else {
                    NSString *msg = [NSString stringWithFormat:@"抱歉！已达到今日可尝试验证的最高次数 %@ 次，请24小时后重试。如果您确保姓名和身份证号正确，您可以尝试回到认证界面，点击“无法通过实名验证”来获得更多帮助", @(retryTimes)];
                    [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleCheckDisable error:msg];
                }
            }
        }
    } failure:^(NSError *error) {
        [self setLoading:NO];
        if (error.code == -1009) {
            [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleNetError error:error.localizedDescription];
        } else {
            [Yodo1AntiIndulgedDialogVC showDialog:Yodo1AntiIndulgedDialogStyleError error:error.localizedDescription];
        }
    }];
}

// 游客体验
- (IBAction)onExperienceClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
        event.eventCode = Yodo1AntiIndulgedEventCodeNone;
        event.action = Yodo1AntiIndulgedActionResumeGame;
        [[Yodo1AntiIndulgedHelper shared] successful: event];
        
        if ([Yodo1AntiIndulgedHelper shared].autoTimer) {
            [[Yodo1AntiIndulgedHelper shared] startTimer];
        }
    }];
}

// 退出游戏
- (IBAction)onQuitClicked:(id)sender {
    
    Yodo1AntiIndulgedEvent *event = [[Yodo1AntiIndulgedEvent alloc] init];
    event.eventCode = Yodo1AntiIndulgedEventCodeNone;
    event.action = Yodo1AntiIndulgedActionEndGame;
    if (![[Yodo1AntiIndulgedHelper shared] successful: event]) {
        exit(0);
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSString *newText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if (textField == _nameField) {
        if (newText.length > 0) {
            if ([Yodo1AntiIndulgedUtils isChineseName:newText]) {
                if (newText.length < 2) {
                    _nameHint.text = @"至少2个中文";
                } else if (newText.length >= 50) {
                    _nameHint.text = @"最多输入50个中文";
                    return NO;
                } else {
                    _nameHint.text = nil;
                }
            } else {
                _nameHint.text = @"请输入中文";
            }
        } else {
            _nameHint.text = nil;
        }
    } else {
        if (newText.length > 0) {
            if (![Yodo1AntiIndulgedUtils isChineseId:newText]) {
                _identifyHint.text = @"请输入18位有效身份证";
            } else {
                _identifyHint.text = nil;
            }
        } else {
            _identifyHint.text = nil;
        }
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == _nameField) {
        [_identifyField becomeFirstResponder];
    } else {
        [self onSubmitClicked:nil];
    }
    return YES;
}

@end
