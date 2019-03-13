Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '3.2.0'
    s.summary          = 'v3.2.0 - 2019-03-11
                            1.更新Facebook v5.2.0
                            2.更新Inmobi v7.2.7
                            3.更新Admob v7.40.0
                            4.更新Applovin v6.3.0
                            5.添加ApplovinMax 插屏，视频聚合
                            6.添加IronSource 插屏，视频聚合
                          '
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.subspec 'Yodo1_Manager' do |ss|
        ss.source_files = "#{s.version}" + '/*.{h,mm}'
        ss.public_header_files = "#{s.version}" + '/*.h'
        ss.preserve_path = "#{s.version}" + '/ChangeLog.txt'
        ss.resources = "#{s.version}" + '/Yodo1Ads.bundle'
        ss.requires_arc = true
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
        ss.dependency 'Yodo1KeyInfo','3.0.0'
        ss.dependency 'Yodo1Commons','3.0.2'
        ss.dependency 'Yodo1ZipArchive','3.0.0'
        ss.dependency 'Yodo1YYModel', '3.0.1'
        ss.dependency 'Yodo1Analytics','3.0.3'
        ss.dependency 'Yodo1ThirdsAnalytics','3.0.10'
        ss.dependency 'Yodo1AdsConfig','3.0.6'
        ss.dependency 'Yodo1Track','3.0.2'
        ss.dependency 'Yodo1FeedbackError','3.0.0'

    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = "#{s.version}" + '/Yodo1KeyConfig.bundle'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
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
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER'
        }
        ss.dependency 'Yodo1UCenter','3.0.15'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1Analytics','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1ThirdsAnalytics','3.0.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_MoreGame' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_MORE_GAME'
        }
        ss.dependency 'Yodo1MoreGame','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS'
        }
        ss.dependency 'Yodo1Share','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS'
        }
        ss.dependency 'Yodo1FBSDKCoreKit','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE'
        }
        ss.dependency 'Yodo1iRate','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER'
        }
        ss.dependency 'Yodo1GameCenter','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD'
        }
        ss.dependency 'Yodo1iCloud','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION'
        }
        ss.dependency 'Yodo1Notification','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY'
        }
        ss.dependency 'Yodo1Replay','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ################# 统计 ##############
     s.subspec 'Analytics_AppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterAppsFlyer','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_GameAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterGameAnalytics','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_TalkingData' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterTalkingData','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_Umeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterUmeng','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Analytics_Swrve' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterSwrve','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

	################# Soomla ##############
    s.subspec 'Yodo1_Soomla' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'Yodo1Soomla','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Soomla_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaAppLovin','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Soomla_InMobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaInMobi','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_MoPub' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaMoPub','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaFacebook','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaTapjoy','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaUnityAds','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaVungle','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaIronSource','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_AdMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaAdMob','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Banner ##############

    s.subspec 'Banner_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerAdmob','3.0.15'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Banner_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerToutiao','3.0.18'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Banner_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerInmobi','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
        s.subspec 'Banner_GDTMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerGDTMob','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Banner_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_BANNER'
        }
        ss.dependency 'BannerApplovin','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Intertitial ##############
    s.subspec 'Interstitial_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialIronSource','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmob','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialTapjoy','3.0.18'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
 
    s.subspec 'Interstitial_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialToutiao','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovin','3.0.16'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_GDTMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialGDTMob','3.0.17'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialFacebook','3.0.18'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialVungle','3.0.15'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMintegral','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialInmobi','3.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_Mopub' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopub','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMax','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## Admob Interstitial ########
    s.subspec 'Interstitial_AdmobFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmobFacebook','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_AdmobIronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmobIronSource','3.0.23'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_AdmobTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmobTapjoy','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_AdmobVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmobVungle','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_AdmobInmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialAdmobInmobi','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## Mopub Interstitial ########
    s.subspec 'Interstitial_MopubVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubVungle','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_MopubTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubTapjoy','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_MopubApplovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubApplovin','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_MopubFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubFacebook','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_MopubAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubAdmob','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_MopubIronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialMopubIronSource','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## ApplovinMax Interstitial ########
    s.subspec 'Interstitial_ApplovinMaxFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxFacebook','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_ApplovinMaxAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxAdmob','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Interstitial_ApplovinMaxInmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxInmobi','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxIronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxIronSource','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxMintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxMintegral','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxMopub' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxMopub','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxTapjoy','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxUnityAds','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Interstitial_ApplovinMaxVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialApplovinMaxVungle','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## IronSource 插屏聚合 ########

    s.subspec 'Interstitial_ISAdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISAdColony','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISFacebook','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISAdmob','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISVungle','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISUnityAds','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISChartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISChartboost','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISTapjoy','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Interstitial_ISApplovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_INTERSTITIAL'
        }
        ss.dependency 'InterstitialISApplovin','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## Video ########
    s.subspec 'Video_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovin','3.0.16'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoChartboost','3.0.16'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoFacebook','3.0.18'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMintegral','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoTapjoy','3.0.17'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoUnityAds','3.0.17'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoVungle','3.0.15'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoInmobi','3.0.17'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Video_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoIronSource','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoAdmob','3.0.20'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoAdColony','3.0.16'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
 
    s.subspec 'Video_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoToutiao','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoBaidu','3.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_GDTMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoGDTMob','3.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_Mopub' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopub','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMax','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## IronSource Video ########

    s.subspec 'Video_ISApplovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISAppLovin','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISChartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISChartboost','3.0.20'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISUnityAds','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISVungle','3.0.20'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISTapjoy','3.0.21'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISFacebook','3.0.22'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ISAdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISAdColony','3.0.20'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Video_ISAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoISAdmob','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## Mopub Video ########

    s.subspec 'Video_MopubVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubVungle','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubTapjoy','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubFacebook','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubAdmob','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubUnityAds','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubApplovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubApplovin','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_MopubIronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoMopubIronSource','3.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    ######## ApploinMax Video ########
    s.subspec 'Video_ApplovinMaxFacebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxFacebook','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Video_ApplovinMaxAdmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxAdmob','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxInmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxInmobi','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxIronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxIronSource','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxMintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxMintegral','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxMopub' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxMopub','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxTapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxTapjoy','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxUnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxUnityAds','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Video_ApplovinMaxVungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS_VIDEO'
        }
        ss.dependency 'VideoApplovinMaxVungle','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

end
