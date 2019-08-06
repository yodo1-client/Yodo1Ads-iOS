Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '3.4.1'
    s.summary          = 'v3.4.1 - 2019-08-05
                            1.回滚Applvoin的版本v6.6.0
                            2.修复Soomla 统计Applovin出现的BUG
                            3.换spec地址
                            4.更新今日头条sdk v2.2.0.2
                            5.更新Soomla v4.12.2
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

        ss.vendored_libraries = "#{s.version}" + '/*.a'

        ss.preserve_path = "#{s.version}" + '/ChangeLog.txt'
        ss.resources = "#{s.version}" + '/Yodo1Ads.bundle'
        ss.requires_arc = true
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
        ss.dependency 'Yodo1KeyInfo','3.0.0'
        ss.dependency 'Yodo1Commons','3.0.4'
        ss.dependency 'Yodo1ZipArchive','3.0.0'
        ss.dependency 'Yodo1YYModel', '3.0.1'
        ss.dependency 'Yodo1Analytics','3.0.4'
        ss.dependency 'Yodo1ThirdsAnalytics','3.0.13'
        ss.dependency 'Yodo1AdsConfig','3.1.0'
        ss.dependency 'Yodo1Track','3.0.4'
        ss.dependency 'Yodo1FeedbackError','3.0.0'
        ss.dependency 'Yodo1SDWebImage','3.0.0'
        ss.dependency 'Yodo1OnlineParameter','3.0.3'
        ss.dependency 'Yodo1AdvertSDK','3.0.4'

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
        ss.dependency 'Yodo1UCenter','3.0.19'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1Analytics','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'Yodo1ThirdsAnalytics','3.0.13'
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
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS'
        }
        ss.dependency 'Yodo1Share','3.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS'
        }
        ss.dependency 'Yodo1FBSDKCoreKit','3.0.2'
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
        ss.dependency 'Yodo1GameCenter','3.0.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD'
        }
        ss.dependency 'Yodo1iCloud','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION'
        }
        ss.dependency 'Yodo1Notification','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY'
        }
        ss.dependency 'Yodo1Replay','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ################# 统计 ##############
     s.subspec 'Analytics_AppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterAppsFlyer','3.0.12'
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
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterTalkingData','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_Umeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterUmeng','3.0.11'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Analytics_Swrve' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS'
        }
        ss.dependency 'AnalyticsAdapterSwrve','3.0.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Soomla ##############
    s.subspec 'Yodo1_Soomla' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'Yodo1Soomla','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Soomla_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaAppLovin','3.0.11'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Soomla_InMobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaInMobi','3.0.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    #  s.subspec 'Soomla_MoPub' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaMoPub','3.0.5'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

     s.subspec 'Soomla_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaFacebook','3.0.11'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaTapjoy','3.0.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaUnityAds','3.0.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaVungle','3.0.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaIronSource','3.0.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_AdMob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaAdMob','3.0.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Soomla_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaChartboost','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Soomla_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
        }
        ss.dependency 'SoomlaToutiao','3.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# YD1 广告 ##############
    s.subspec 'YD1_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Admob','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Applovin','3.1.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1IronSource','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Inmobi','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Mintegral','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Tapjoy','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1UnityAds','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Vungle','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Toutiao','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Baidu','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Facebook','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1GDT','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'YD1_OneWay' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'YD1OneWay','3.1.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    # s.subspec 'YD1_Mopub' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'YD1Mopub','3.1.1'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    s.subspec 'YD1_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1ApplovinMax','3.1.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'YD1Chartboost','3.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1 Admob ########
    s.subspec 'Admob_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'AdmobFacebook','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'AdmobIronSource','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'AdmobTapjoy','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'AdmobVungle','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'AdmobInmobi','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1 Mopub ########
    # s.subspec 'Mopub_Vungle' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubVungle','3.0.7'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_Tapjoy' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubTapjoy','3.0.7'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_Facebook' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubFacebook','3.0.8'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_Admob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubAdmob','3.0.8'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_UnityAds' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubUnityAds','3.0.9'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_Applovin' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubApplovin','3.0.9'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Mopub_IronSource' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'MopubIronSource','3.0.8'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    ######## YD1 ApplovinMax ########

    s.subspec 'ApplovinMax_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxFacebook','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxAdmob','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxInmobi','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxIronSource','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxMintegral','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    # s.subspec 'ApplovinMax_Mopub' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
    #     }
    #     ss.dependency 'ApplovinMaxMopub','3.0.7'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    s.subspec 'ApplovinMax_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxTapjoy','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxUnityAds','3.0.13'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxVungle','3.0.12'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxToutiao','3.0.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ApplovinMaxChartboost','3.0.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1ISource ########

    s.subspec 'IS_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISFacebook','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'IS_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISAdmob','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'IS_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISVungle','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'IS_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISUnityAds','3.1.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'IS_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISTapjoy','3.1.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'IS_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS'
        }
        ss.dependency 'ISAppLovin','3.1.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

end
