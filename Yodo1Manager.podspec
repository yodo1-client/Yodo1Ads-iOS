Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '3.8.0.pre'
    s.summary          = 'v3.8.0 - 2020-02-11
                            ---------------------------
                            1.AdColony  v4.1.3
                            2.Admob v7.55.0
                            3.Applovin v6.11.1
                            4.Vungle v6.5.1
                            5.UnityAds v3.4.2
                            6.Facebook v5.6.1
                            7.GDT v4.11.3
                            8.Inmobi v9.0.4.0
                            9.IronSource v6.14.0.0
                            10.Mintegral v5.8.8
                            11.Toutiao v2.7.5.2
                            12.Tapjoy v12.4.1

                            13.更新 Soomla v5.6.6 [移除UIWebView]
                            ---------------------------
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
    
    valid_archs = ['armv7', 'x86_64', 'arm64']

    s.subspec 'Yodo1_Manager' do |ss|
        ss.source_files = "#{s.version}" + '/*.{h,mm}'
        ss.public_header_files = "#{s.version}" + '/*.h'

        ss.vendored_libraries = "#{s.version}" + '/*.a'

        ss.preserve_path = "#{s.version}" + '/ChangeLog.txt'
        ss.resources = "#{s.version}" + '/Yodo1Ads.bundle'
        ss.requires_arc = true
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO",
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1KeyInfo','3.0.0'
        ss.dependency 'Yodo1Commons','3.1.0'
        ss.dependency 'Yodo1ZipArchive','3.0.0'
        ss.dependency 'Yodo1YYModel', '3.0.1'
        ss.dependency 'Yodo1Analytics','3.0.5'
        ss.dependency 'Yodo1ThirdsAnalytics','3.1.1'
        # ss.dependency 'Yodo1AdsConfig','3.1.1'
        ss.dependency 'Yodo1Track','3.0.6'
        ss.dependency 'Yodo1FeedbackError','3.0.0'
        ss.dependency 'Yodo1OnlineParameter','3.0.4'
        ss.dependency 'Yodo1AdvertSDK','3.1.0'
        ss.dependency 'Yodo1UDID','3.0.0'

    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = "#{s.version}" + '/Yodo1KeyConfig.bundle'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO",
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
    end

    s.subspec 'Yodo1_UnityConfigKey' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO",
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1UCenter','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Analytics','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1ThirdsAnalytics','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'Yodo1_MoreGame' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_MORE_GAME'
    #     }
    #     ss.dependency 'Yodo1MoreGame','3.0.6'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Share','3.1.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1FBSDKCoreKit','3.2.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1iRate','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1GameCenter','3.0.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1iCloud','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Notification','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Replay','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_AgePrivacy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'PRIVACY',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1AgePrivacy','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ################# 统计 ##############
     s.subspec 'Analytics_AppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterAppsFlyer','3.1.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    # s.subspec 'Analytics_GameAnalytics' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
    #     }
    #     ss.dependency 'AnalyticsAdapterGameAnalytics','3.0.10'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    s.subspec 'Analytics_TalkingData' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterTalkingData','3.1.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_Umeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterUmeng','3.1.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Analytics_Swrve' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterSwrve','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Soomla ##############
    s.subspec 'Yodo1_Soomla' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Soomla','3.2.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'Soomla_AppLovin' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaAppLovin','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_InMobi' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaInMobi','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_MoPub' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaMoPub','3.0.5'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Facebook' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaFacebook','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Tapjoy' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaTapjoy','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_UnityAds' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaUnityAds','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Vungle' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaVungle','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_IronSource' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaIronSource','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_AdMob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaAdMob','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_Chartboost' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaChartboost','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Toutiao' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaToutiao','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_Mintegral' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaMintegral','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    ################# YD1 广告 ##############
    s.subspec 'YD1_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Admob','3.2.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Applovin','3.2.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1IronSource','3.2.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Inmobi','3.2.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Mintegral','3.2.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Tapjoy','3.2.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1UnityAds','3.2.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Vungle','3.2.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Toutiao','3.2.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Baidu','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Facebook','3.2.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1GDT','3.2.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'YD1_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1ApplovinMax','3.2.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Chartboost','3.2.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1AdColony','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1MyTarget','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1 Admob ########
    s.subspec 'Admob_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobFacebook','3.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobIronSource','3.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobTapjoy','3.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobVungle','3.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobInmobi','3.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobUnityAds','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobChartboost','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobAppLovin','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

   s.subspec 'Admob_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobAdColony','3.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1 ApplovinMax ########

    s.subspec 'ApplovinMax_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxFacebook','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxAdmob','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxInmobi','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxIronSource','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxMintegral','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxTapjoy','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxUnityAds','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxVungle','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxToutiao','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxChartboost','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxAdColony','3.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            "VALID_ARCHS" =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxMyTarget','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1ISource ########

    ##已经启用IronSource聚合
    # s.subspec 'IS_Facebook' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISFacebook','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_Admob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISAdmob','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_Vungle' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISVungle','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_UnityAds' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISUnityAds','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'IS_Tapjoy' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISTapjoy','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_AppLovin' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         "VALID_ARCHS" =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISAppLovin','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

end
