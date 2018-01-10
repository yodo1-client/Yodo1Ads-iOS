Pod::Spec.new do |s|
    s.name             = 'Yodo1Advert'
    s.version          = '1.0.6'
    s.summary          = '2018.01.10 1月份list
                            Yodo1Ads v1.0.6'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    
    tags               = "#{s.name}"

    s.homepage         = 'https://github.com/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = tags + '/*.h'

    s.public_header_files = tags + '/*.h'

    #s.resources = tags + '/*.*'
    
    s.preserve_path = 'ChangeLog.txt'
    
    s.vendored_libraries = tags + '/*.a'

    s.requires_arc = false

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.libraries = 'sqlite3.0','z','stdc++'


    s.subspec 'Yodo1_UnityConfig' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT',
            "OTHER_LDFLAGS" => "-ObjC",
            "ENABLE_BITCODE" => "NO",
            "ONLY_ACTIVE_ARCH" => "NO"
        }
    end
    
    s.dependency 'Yodo1AdsConfig',      '1.0.0'

    ##Video

    s.dependency 'VideoUnityAds',       '2.0.1'
    s.dependency 'VideoMobvista',       '2.0.1'
    s.dependency 'VideoSupersonic',     '2.0.1'
    s.dependency 'VideoCentrixlink',    '2.0.1'
    s.dependency 'VideoApplovin',       '2.0.1'
    s.dependency 'VideoVungle',         '2.0.1'

    # s.dependency 'VideoChance',         '2.0.1'
    # s.dependency 'VideoChartboost',     '2.0.1'
    # s.dependency 'VideoDomob',          '2.0.1'
    # s.dependency 'VideoFacebook',       '2.0.1'
    # s.dependency 'VideoInmobi',         '2.0.1'
    # s.dependency 'VideoKTplay',         '2.0.1'
    # s.dependency 'VideoTapjoy',         '2.0.1'
    # # s.dependency 'VideoYouMi',          '2.0.1'

    s.dependency 'VideoISAdColony',     '2.0.1'
    s.dependency 'VideoISUnityAds',     '2.0.1'
    s.dependency 'VideoISAppLovin',     '2.0.1'
    s.dependency 'VideoISChartboost',   '2.0.1'
    s.dependency 'VideoISFacebook',     '2.0.1'
    s.dependency 'VideoISTapjoy',       '2.0.1'
    s.dependency 'VideoISVungle',       '2.0.1'

    ##Interstitial
    s.dependency 'InterstitialAdmob',       '2.0.1'
    s.dependency 'InterstitialApplovin',    '2.0.1'
    s.dependency 'InterstitialTapjoy',      '1.0.1' 
    s.dependency 'InterstitialSupersonic',  '1.0.1' 
    s.dependency 'InterstitialGDTMob',      '2.0.1'

    # s.dependency 'InterstitialAdview',      '2.0.1'
    # s.dependency 'InterstitialFacebook',    '1.0.1'
    # s.dependency 'InterstitialKTplay',      '2.0.1'
    # s.dependency 'InterstitialWmad',        '2.0.1'

    ##Banner
    s.dependency 'BannerAdmob',         '2.0.1'
    s.dependency 'BannerAdview',        '1.0.1'
    s.dependency 'BannerApplovin',      '1.0.1'
    s.dependency 'BannerGDTMob',        '1.0.1'
    s.dependency 'BannerInmobi',        '1.0.1'

    # s.dependency 'BannerWmad',          '2.0.1'

end
