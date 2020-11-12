//
//  Yodo1AntiAddictionHelpVC.m
//  yodo1-anti-Addiction-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiAddictionHelpVC.h"
#import "Yodo1AntiAddictionRulesManager.h"
#import "Yodo1AntiAddictionUserManager.h"

@interface Yodo1AntiAddictionHelpVC ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
/*
 邮件内容如下：
 发送至：{xxxxx@xxxxx.com}
 标题：实名验证 {GID}
 
 邮件正文
 姓名：
 证件类型：护照/身份证/驾照等（可以正确显示您的出生年月日的有效证件）
 
 邮件附件
 附件1：证件扫描件
 附件2：本人手持证件照片
 */

@end

@implementation Yodo1AntiAddictionHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *email = [Yodo1AntiAddictionRulesManager manager].currentRules.csEmail;
    NSString *yid = [Yodo1AntiAddictionUserManager manager].currentUser.yid;
    self.contentLabel.text = [NSString stringWithFormat:@"邮件内容如下：\n发送至：%@\n标题：实名验证 %@\n\n邮件正文\n姓名：\n证件类型：护照/身份证/驾照等（可以正确显示您的出生年月日的有效证件）\n\n邮件附件\n附件1：证件扫描件\n附件2：本人手持证件照片", email, yid];
    [self changePartColorWithAllText:self.contentLabel.text andSpecialText:@[@"邮件内容如下：",@"邮件正文",@"邮件附件"] andfont:[UIFont boldSystemFontOfSize:18] andColor:[UIColor blackColor] andLable:self.contentLabel];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat height = UIScreen.mainScreen.bounds.size.height / 3 * 2;
    CGFloat max = 440;
    if (@available(iOS 11.0, *)) {
        max = max + self.view.safeAreaInsets.bottom;
    }
    _contentHeight.constant = height > max ? max : height;
}

#pragma mark - Event
- (IBAction)onBackClicked:(id)sender {
    if (_onBackClicked) {
        _onBackClicked();
    }
}

- (void)changePartColorWithAllText:(NSString *)allstr andSpecialText:(NSArray *)specialarry andfont:(UIFont *)sfont andColor:(UIColor *)scolor andLable:(UILabel *)lsl
{
    if(allstr.length == 0 || specialarry.count == 0){
        return;
    }
    if(sfont == nil || scolor == nil || lsl == nil){
        return;
    }
    NSMutableAttributedString *tempstr = [[NSMutableAttributedString alloc] initWithString:allstr];
    for(NSString * ss in specialarry){
        NSRange range1=[allstr rangeOfString:ss];
        if(range1.length == 0){
            lsl.attributedText=tempstr;
            return;
        }
        if((range1.length+range1.location<allstr.length)||(range1.length+range1.location == allstr.length)){
            [tempstr addAttribute:NSFontAttributeName value:sfont range:NSMakeRange(range1.location,ss.length)];
            [tempstr addAttribute:NSForegroundColorAttributeName value:scolor range:NSMakeRange(range1.location,ss.length)];
        }
    }
    lsl.attributedText=tempstr;
    [lsl sizeToFit];
}

@end
