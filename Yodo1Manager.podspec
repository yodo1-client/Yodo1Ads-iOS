Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '2.0.12'
    s.summary          = 'v2.0.12- 2018-05-14
                          1、修复数据统计BUG
                          2、更新Mobvista v3.8.0,Vungle v6.2.0,
                          Applovin v5.0.1,UnityAds v2.2.1,Inmobi v7.1.1,
                          GDTMob v4.7.4,Tapjoy v11.12.1
                          '
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    tags               = "#{s.name}" 
    
    versions           = "#{s.version}" 
    
    Yodo1VideoVersion  = '2.0.4'

    s.homepage         = 'https://github.com/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.subspec 'Yodo1_Manager' do |ss|
        ss.source_files = tags + '/*.{h,mm}'
        ss.public_header_files = tags + '/*.h'
        ss.preserve_path = 'ChangeLog.txt'
        ss.requires_arc = true
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
        ss.dependency 'Yodo1KeyInfo','2.0.1'
        ss.dependency 'Yodo1Commons','2.0.1'
        ss.dependency 'Yodo1ZipArchive','1.0.2'
        ss.dependency 'Yodo1YYModel', '2.0.2'
        ss.dependency 'Yodo1Analytics','2.0.4'
        ss.dependency 'Yodo1ThirdsAnalytics','1.0.3'
        ss.dependency 'Yodo1AdsConfig','1.0.2'

    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = tags + '/Yodo1KeyConfig.bundle'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
    end

    s.subspec 'Yodo1_UnityConfigKey' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER'
        }
        ss.dependency 'Yodo1UCenter','2.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1Analytics','2.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1ThirdsAnalytics','1.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_MoreGame' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_MORE_GAME'
        }
        ss.dependency 'Yodo1MoreGame','2.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS'
        }
        ss.dependency 'Yodo1Share','2.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS'
        }
        ss.dependency 'Yodo1FBSDKCoreKit','1.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE'
        }
        ss.dependency 'Yodo1iRate','1.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER'
        }
        ss.dependency 'Yodo1GameCenter','2.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD'
        }
        ss.dependency 'Yodo1iCloud','2.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION'
        }
        ss.dependency 'Yodo1Notification','2.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY'
        }
        ss.dependency 'Yodo1Replay','2.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    ################# Banner ##############
    s.subspec 'Banner_Adview' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerAdview','1.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    s.subspec 'Banner_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerAdmob','2.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Banner_Wmad' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerWmad','2.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    s.subspec 'Banner_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerInmobi','1.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
        s.subspec 'Banner_GDTMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerGDTMob','1.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    s.subspec 'Banner_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerApplovin','1.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    ################# Intertitial ##############
    s.subspec 'Interstitial_Supersonic' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialSupersonic','1.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmob','2.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialTapjoy','1.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    
    # s.subspec 'Interstitial_KTplay' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
    #     }
    #     ss.dependency 'InterstitialKTplay','2.0.2'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    # end

    s.subspec 'Interstitial_Adview' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdview','2.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
 
    s.subspec 'Interstitial_Wmad' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialWmad','2.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovin','2.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_GDTMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialGDTMob','2.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialFacebook','1.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialVungle','1.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Interstitial_Mobvista' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMobvista','1.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    ################# Video ##############
    # s.subspec 'Video_Chance' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
    #     }
    #     ss.dependency 'VideoChance','2.0.2'
    #     ss.dependency 'Yodo1Video', Yodo1VideoVersion
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    # end

    s.subspec 'Video_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovin','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_Centrixlink' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoCentrixlink','2.0.5'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoChartboost','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    # s.subspec 'Video_Domob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
    #     }
    #     ss.dependency 'VideoDomob','2.0.2'
    #     ss.dependency 'Yodo1Video', Yodo1VideoVersion
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    # end

    s.subspec 'Video_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoFacebook','2.0.5'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_Mobvista' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMobvista','2.0.8'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoTapjoy','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoUnityAds','2.0.5'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoVungle','2.0.8'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    # s.subspec 'Video_YouMi' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
    #     }
    #     ss.dependency 'VideoYouMi','2.0.2'
    #     ss.dependency 'Yodo1Video', Yodo1VideoVersion
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    # end

    s.subspec 'Video_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoInmobi','2.0.4'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
    
    s.subspec 'Video_Supersonic' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoSupersonic','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
  
    # s.subspec 'Video_KTplay' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
    #     }
    #     ss.dependency 'VideoKTplay','2.0.2'
    #     ss.dependency 'Yodo1Video', Yodo1VideoVersion
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    # end

    s.subspec 'Video_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoAdmob','2.0.4'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoAdColony','2.0.3'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end
 
    s.subspec 'Video_Wmad' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoWmad','2.0.5'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    ######## Supersonic Video ########

    s.subspec 'Video_ISApplovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISAppLovin','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISChartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISChartboost','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISUnityAds','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISVungle','2.0.7'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISTapjoy','2.0.8'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISFacebook','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

    s.subspec 'Video_ISAdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISAdColony','2.0.6'
        ss.dependency 'Yodo1Video', Yodo1VideoVersion
        ss.dependency 'Yodo1Manager/Yodo1_Manager',versions
    end

end
