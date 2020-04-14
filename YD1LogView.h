//
//  YD1LogView.h
//  YD1LogView
//
//  Created by HuangYixian on 2018/1/29.
//  Copyright © 2018年 HuangYixian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YD1LogView : UIView

+ (BOOL)allXSeriesDevices;

+ (NSString*)idfaString;

+ (NSString *)language;

+ (void)startLog:(NSString*)appKey;

+ (NSString *)outputString:(NSString *)string;

+ (void)hideLogView;

+ (void)showLogView;
@end
