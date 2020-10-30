Pod::Spec.new do |s|
    s.name             = 'Yodo1Manager'
    s.version          = '4.4.1'
    s.summary          = 'v4.4.1- 2020-10-28
                            ---------------------------
                            1.更新各渠道广告-->
                                Applovin v6.14.4
                                GDT v4.11.11
                                MyTarget v5.8.0
                                IronSource v7.0.1.0 [支持iOS 14]
                                Mintegral v6.6.0
                                Toutiao v3.2.6.2
                                Soomla v5.11.3
                                UnityAds v3.4.8 [支持iOS 14]
                                Inmobi v9.1.0 [去掉]
                                Tapjoy v12.7.0
                                Admob v7.65.0 [支持iOS 14]
                                Facebook v5.10.1
                                AdColony v4.4.0
                                Baidu v4.71
                                Chartboost v8.3.1
                                Smaato v21.6.2
                                vungle v6.8.0 [修复冲突KTPlay]
                            2.修改Yodo1数据统计支持iOS 14
                            3.修改错误上报支持iOS 14
                            4.添加ApplovinMax 聚合中的Flyber,Verizon,Amazon
                            5.添加大转盘
                            6.更新统计AF和Soomla,解决bug
                            7.统计Umeng 使用海外版
                            8.添加ATT [去掉暂时]
                            9.添加开屏广告

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
    
    s.subspec 'Yodo1_Manager' do |ss|
        ss.source_files = "#{s.version}" + '/*.{h,mm,m}'
        ss.public_header_files = "#{s.version}" + '/*.h'

        ss.vendored_libraries = "#{s.version}" + '/*.a'

        ss.preserve_path = "#{s.version}" + '/ChangeLog.txt'
        ss.resources = "#{s.version}" + '/Yodo1Ads.bundle'
        ss.requires_arc = true
        
        ss.frameworks = 'CoreTelephony','AppTrackingTransparency'

        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }

        ss.dependency 'Yodo1KeyInfo','4.1.0'
        ss.dependency 'Yodo1Commons','4.1.1'
        ss.dependency 'Yodo1ZipArchive','4.1.0'
        ss.dependency 'Yodo1YYModel', '4.1.0'
        ss.dependency 'Yodo1Analytics','4.2.4'
        ss.dependency 'Yodo1ThirdsAnalytics','4.2.5'
        ss.dependency 'Yodo1Track','4.1.2'
        ss.dependency 'Yodo1FeedbackError','4.1.3'
        ss.dependency 'Yodo1OnlineParameter','4.2.4'
        ss.dependency 'Yodo1AdvertSDK','4.2.5'
        ss.dependency 'Yodo1UDID','4.1.0'
        ss.dependency 'Yodo1SaAnalytics','4.1.1'
        ss.dependency 'Yodo1Bugly','4.1.2'
        ss.dependency 'Yodo1Reachability', '4.1.0'
        ss.dependency 'Yodo1AFNetworking', '4.1.0'

    end

    s.subspec 'Yodo1_ConfigKey' do |ss|
        ss.resources = "#{s.version}" + '/Yodo1KeyConfig.bundle'
        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_UnityConfigKey' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_UCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_UCCENTER',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1UCenter','4.2.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Yodo1_Analytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Analytics','4.2.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_ThirdsAnalytics' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1ThirdsAnalytics','4.2.5'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    # s.subspec 'Yodo1_MoreGame' do |ss|
    #     ss.xcconfig = {
    #         "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_MORE_GAME'
    #     }
    #     ss.dependency 'Yodo1MoreGame','4.1.0'
    #     ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    # end

    s.subspec 'Yodo1_Share' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SNS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Share','4.1.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_FBSDKCoreKit' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_FACEBOOK_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1FBSDKCoreKit','4.1.2'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_iRate' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'IRATE',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iRate','4.1.0'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

     s.subspec 'Yodo1_GameCenter' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'GAMECENTER',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1GameCenter','4.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
     s.subspec 'Yodo1_iCloud' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ICLOUD',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1iCloud','4.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Yodo1_Notification' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'NOTIFICATION',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Notification','4.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_Replay' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'REPLAY',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Replay','4.1.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_AgePrivacy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'PRIVACY',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1AgePrivacy','4.2.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Yodo1_AntiAddiction' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'ANTI_ADDICTION',
             'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1AntiAddiction','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# 统计 ##############
     s.subspec 'Analytics_AppsFlyer' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
                         'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnalyticsAdapterAppsFlyer','4.2.7'
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
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnalyticsAdapterTalkingData','4.2.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'Analytics_Umeng' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnalyticsAdapterUmeng','4.2.7'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Analytics_Swrve' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ANALYTICS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnalyticsAdapterSwrve','4.2.6'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ################# Soomla ##############
    s.subspec 'Yodo1_Soomla' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_SOOMLA',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'Yodo1Soomla','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

   #  ################# YD1 广告 ##############
    s.subspec 'YD1_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Admob','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Applovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Applovin','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1IronSource','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Inmobi','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Mintegral','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Tapjoy','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1UnityAds','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Vungle','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Toutiao','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Baidu','4.1.4'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Facebook','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1GDT','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'YD1_ApplovinMax' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1ApplovinMax','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Chartboost','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1AdColony','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1MyTarget','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'YD1_Yandex' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Yandex','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'YD1_Smaato' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Smaato','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'YD1_Topon' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'YD1Topon','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1 Admob ########
    s.subspec 'Admob_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobFacebook','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobIronSource','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobTapjoy','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'Admob_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobVungle','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobInmobi','4.1.8'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobUnityAds','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobChartboost','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_AppLovin' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobAppLovin','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

   s.subspec 'Admob_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobAdColony','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'Admob_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AdmobMyTarget','4.0.3'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    ######## YD1 ApplovinMax ########

    s.subspec 'ApplovinMax_Facebook' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxFacebook','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxAdmob','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Inmobi' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxInmobi','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_IronSource' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxIronSource','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxMintegral','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Tapjoy' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxTapjoy','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxUnityAds','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxVungle','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Toutiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxToutiao','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Chartboost' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxChartboost','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_AdColony' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxAdColony','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_MyTarget' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxMyTarget','4.1.10'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    
    s.subspec 'ApplovinMax_Yandex' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxYandex','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'ApplovinMax_Smaato' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxSmaato','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxGDT','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Amazon' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxAmazon','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Verizon' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxVerizon','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'ApplovinMax_Fyber' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'ApplovinMaxFyber','4.1.9'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    ######## YD1Topon ########
    s.subspec 'AnyThink_Baidu' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkBaidu','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'AnyThink_Mintegral' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkMintegral','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end
    s.subspec 'AnyThink_Sigmob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkSigmob','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'AnyThink_UnityAds' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkUnityAds','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'AnyThink_GDT' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkGDT','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'AnyThink_Admob' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkAdmob','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'AnyThink_Vungle' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkVungle','4.0.1'
        ss.dependency 'Yodo1Manager/Yodo1_Manager',"#{s.version}"
    end

    s.subspec 'AnyThink_TouTiao' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'YODO1_ADS',
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
            "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
        }
        ss.dependency 'AnyThinkTouTiao','4.0.1'
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
