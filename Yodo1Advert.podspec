Pod::Spec.new do |s|
    s.name             = 'Yodo1Advert'
    s.version          = '3.7.0'
    s.summary          = '2020.04.14'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.subspec 'Advert' do |ss|
            ss.source_files = "#{s.version}" + '/*.h'
            ss.public_header_files = "#{s.version}" + '/*.h'
            ss.preserve_path = "#{s.version}" + '/ChangeLog.txt'
            ss.vendored_libraries = "#{s.version}" + '/*.a'
            ss.resource = "#{s.version}" + "/*.bundle"
            ss.requires_arc = true
            ss.xcconfig = {
                'OTHER_LDFLAGS' => '-ObjC',
                'ENABLE_BITCODE' => "NO",
                "VALID_ARCHS": "armv7 arm64",
                "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
                "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
            }
            ss.dependency 'Yodo1Commons','4.1.0'
            ss.dependency 'Yodo1Analytics','4.1.0'
            ss.dependency 'Yodo1ThirdsAnalytics','4.1.0'
            ss.dependency 'Yodo1FeedbackError','4.1.0'
            ss.dependency 'Yodo1OnlineParameter','4.1.0'
            ss.dependency 'Yodo1AdvertSDK','4.1.0'
            ss.dependency 'Yodo1SaAnalytics','4.1.0'
            ss.dependency 'Yodo1Bugly','4.1.0'
    end
    
     s.subspec 'Yodo1Advert_iOS' do |ss|
        ss.xcconfig = {
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        }
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
    end

    s.subspec 'Yodo1Advert_Unity3d' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => "UNITY_PROJECT",
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "VALID_ARCHS": "armv7 arm64",
            "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        }
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Admob','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Applovin','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1IronSource','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Inmobi','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Mintegral','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Tapjoy','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1UnityAds','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Vungle','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Toutiao','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Baidu','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Facebook','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1GDT','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1ApplovinMax','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Chartboost','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1AdColony','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1MyTarget','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Yandex','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'YD1Smaato','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobFacebook','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobIronSource','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobTapjoy','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobVungle','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobInmobi','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobUnityAds','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobChartboost','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobAppLovin','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'AdmobAdColony','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxFacebook','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxAdmob','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxInmobi','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxIronSource','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxMintegral','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxTapjoy','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxUnityAds','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxVungle','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxToutiao','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxChartboost','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxAdColony','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxMyTarget','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxYandex','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
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
        ss.dependency 'ApplovinMaxSmaato','4.1.0'
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
    end

end
