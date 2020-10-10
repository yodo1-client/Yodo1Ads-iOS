//
//  Yodo1AntiIndulgedHelpVC.m
//  yodo1-anti-indulged-ios
//
//  Created by ZhouYuzhen on 2020/10/3.
//

#import "Yodo1AntiIndulgedHelpVC.h"

@interface Yodo1AntiIndulgedHelpVC ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
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

@implementation Yodo1AntiIndulgedHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self changePartColorWithAllText:self.contentLabel.text andSpecialText:@[@"邮件内容如下：",@"邮件正文",@"邮件附件"] andfont:[UIFont boldSystemFontOfSize:18] andColor:[UIColor blackColor] andLable:self.contentLabel];
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
