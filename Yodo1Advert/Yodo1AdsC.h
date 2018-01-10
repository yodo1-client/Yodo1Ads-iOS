//
//  Yodo1AdsC.h
//  Yodo1Ads
//
//  Created by yixian huang on 2017/9/13.
//  Copyright © 2017年 yixian huang. All rights reserved.
//
//  v1.0.5
//

#ifndef Yodo1AdsC_h
#define Yodo1AdsC_h

typedef enum {
    Yodo1AdsCEventClose     = 0,//Close
    Yodo1AdsCEventFinish    = 1,//Finish playing
    Yodo1AdsCEventClick     = 2,//Click ad
    Yodo1AdsCEventLoaded    = 3,//Ad load finish
    Yodo1AdsCEventDisplay   = 4,//Display success
    Yodo1AdsCEventError     = -1,//Error
}Yodo1AdsCEvent;

typedef enum {
    Yodo1AdsCBannerAdAlignLeft               = 1 << 0,
    Yodo1AdsCBannerAdAlignHorizontalCenter   = 1 << 1,
    Yodo1AdsCBannerAdAlignRight              = 1 << 2,
    Yodo1AdsCBannerAdAlignTop                = 1 << 3,
    Yodo1AdsCBannerAdAlignVerticalCenter     = 1 << 4,
    Yodo1AdsCBannerAdAlignBottom             = 1 << 5,
}Yodo1AdsCBannerAdAlign;

typedef void (*Banner_callback) (Yodo1AdsCEvent event);
typedef void (*Interstitial_callback) (Yodo1AdsCEvent event);
typedef void (*Video_callback) (bool finished);


class Yodo1AdsC {
    
public:
    /**
     *  Init
     */
    static void InitWithAppKey(const char* appKey);
 
    /**
     *  Enable/Disable log
     */
    static void SetLogEnable(bool enable);
    
#pragma mark- YODO1_BANNER
    
    /**
     *  Set banner's align
     */
    static void SetBannerAlign(Yodo1AdsCBannerAdAlign align);
    
    /**
     *  Set banner's callback
     */
    static void SetBannerCallback(Banner_callback callback);
    
    /**
     *  Show banner
     */
    static void ShowBanner();
    
    /**
     *  Hide banner
     */
    static void HideBanner();
    
    /**
     *  Remove Banner from
     */
    static void RemoveBanner();
    
#pragma mark- YODO1_INTERSTITIAL
    
    /**
     *  Set interstitial's callback
     */
    static void SetInterstitialCallback(Interstitial_callback callback);
    
    /**
     *  Check if interstitial is ready to show
     */
    static bool InterstitialIsReady();
    
    /**
     *  Show interstitial ad
     */
    static void ShowInterstitial();
    
#pragma mark- YODO1_VIDEO
    
    /**
     *  Set video's callback
     */
    static void SetVideoCallback(Video_callback callback);
    
    /**
     *  Check if vedeo ad is ready to paly
     *
     *  @return YES/NO
     */
    static bool VideoIsReady();
    
    /**
     *  Show the video ad
     */
    static void ShowVideo();
    
};

#endif /* Yodo1AdsC_h */
