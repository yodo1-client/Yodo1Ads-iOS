//
//  Yodo1AdVideoManager.h
//  Yodo1Ads
//
//  Created by hyx on 14-10-14.
//  Copyright (c) 2014年 yodo1. All rights reserved.
//

typedef void (*award_callback) (bool finished);

class Yodo1AdVideoManagerC {

public:
    
    /**
     *  初始化视频广告sdk，需要先设置各家广告的key
     */
    static void InitAdVideoSDK();
    
    /**
     *  检测是否有视频可以播放
     *
     *  @return YES有广告，NO没有广告。
     */
    static bool HasAdVideo();
    
    /**
     *   视频广告在线参数总开关VideoAd_All
     *
     *  @return YES打开，NO关闭。
     */
    static bool SwitchAdVideo();
    
    /**
     *  显示视频广告
     *
     *  @param callback      回调
     */
    static void ShowAdVideo(award_callback callback);
};
