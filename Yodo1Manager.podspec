Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '3.8.0'
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

    s.ios.deployment_target = '9.0'
    
    valid_archs = ['armv7','arm64','x86_64']
    s.pod_target_xcconfig = {
        'ARCHS[sdk=iphonesimulator*]'=>'$(ARCHS_STANDARD_64_BIT)'
    }
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' '),
    }
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
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1KeyInfo','4.0.0'
        ss.dependency 'Yodo1Commons','4.0.0'
        ss.dependency 'Yodo1ZipArchive','4.0.0'
        ss.dependency 'Yodo1YYModel', '4.0.0'
        ss.dependency 'Yodo1Analytics','4.0.0'
        ss.dependency 'Yodo1ThirdsAnalytics','4.0.0'
        # ss.dependency 'Yodo1AdsConfig','4.0.0'
        ss.dependency 'Yodo1Track','4.0.0'
        ss.dependency 'Yodo1FeedbackError','4.0.0'
        ss.dependency 'Yodo1OnlineParameter','4.0.0'
        ss.dependency 'Yodo1AdvertSDK','4.0.0'
        ss.dependency 'Yodo1UDID','4.0.0'

    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = "#{s.version}" + '/Yodo1KeyConfig.bundle'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO",
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
    end

    s.subspec 'Yodo1_UnityConfigKey' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO",
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1UCenter','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Analytics','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1ThirdsAnalytics','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'Yodo1_MoreGame' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_MORE_GAME'
    #     }
    #     ss.dependency 'Yodo1MoreGame','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Share','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1FBSDKCoreKit','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1iRate','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1GameCenter','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1iCloud','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Notification','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Replay','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_AgePrivacy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'PRIVACY',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1AgePrivacy','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ################# 统计 ##############
     s.subspec 'Analytics_AppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterAppsFlyer','4.0.0'
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
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterTalkingData','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_Umeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterUmeng','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Analytics_Swrve' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AnalyticsAdapterSwrve','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Soomla ##############
    s.subspec 'Yodo1_Soomla' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'Yodo1Soomla','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'Soomla_AppLovin' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaAppLovin','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_InMobi' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaInMobi','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_MoPub' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaMoPub','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Facebook' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaFacebook','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Tapjoy' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaTapjoy','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_UnityAds' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaUnityAds','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Vungle' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaVungle','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_IronSource' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaIronSource','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_AdMob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaAdMob','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_Chartboost' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaChartboost','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    #  s.subspec 'Soomla_Toutiao' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaToutiao','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'Soomla_Mintegral' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA'
    #     }
    #     ss.dependency 'SoomlaMintegral','4.0.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    ################# YD1 广告 ##############
    s.subspec 'YD1_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Admob','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Applovin','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1IronSource','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Inmobi','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Mintegral','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Tapjoy','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1UnityAds','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Vungle','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Toutiao','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Baidu','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Facebook','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1GDT','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'YD1_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1ApplovinMax','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1Chartboost','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1AdColony','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'YD1MyTarget','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1 Admob ########
    s.subspec 'Admob_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobFacebook','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobIronSource','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobTapjoy','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobVungle','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobInmobi','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobUnityAds','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobChartboost','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobAppLovin','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

   s.subspec 'Admob_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'AdmobAdColony','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1 ApplovinMax ########

    s.subspec 'ApplovinMax_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxFacebook','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxAdmob','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxInmobi','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxIronSource','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxMintegral','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxTapjoy','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxUnityAds','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxVungle','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxToutiao','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxChartboost','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxAdColony','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'VALID_ARCHS' =>  valid_archs.join(' '),
        }
        ss.dependency 'ApplovinMaxMyTarget','4.0.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1ISource ########

    ##已经启用IronSource聚合
    # s.subspec 'IS_Facebook' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISFacebook','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_Admob' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISAdmob','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_Vungle' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISVungle','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_UnityAds' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISUnityAds','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    # s.subspec 'IS_Tapjoy' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISTapjoy','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end
    
    # s.subspec 'IS_AppLovin' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
    #         'VALID_ARCHS' =>  valid_archs.join(' '),
    #     }
    #     ss.dependency 'ISAppLovin','3.3.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

end
