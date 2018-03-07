Pod::Spec.new do |s|
    s.name             = 'Yodo1Advert'
    s.version          = '1.0.10'
    s.summary          = '2018.03.07 3月份list
                            Yodo1Ads v1.0.10'

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

    s.subspec 'Advert' do |ss|
            ss.source_files = tags + '/*.h'
            ss.public_header_files = tags + '/*.h'
            #ss.resources = tags + '/*.*'
            ss.preserve_path = 'ChangeLog.txt',tags + '/VERSION'
            ss.vendored_libraries = tags + '/*.a'
            ss.requires_arc = false
            ss.xcconfig = {
                'OTHER_LDFLAGS' => '-ObjC',
                'ENABLE_BITCODE' => 'NO',
                'ONLY_ACTIVE_ARCH' => 'NO'
            }
            ss.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'
            ss.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
            ss.libraries = 'sqlite3.0','z','stdc++'
            
            ss.dependency 'Yodo1Banner','2.0.1'
            ss.dependency 'Yodo1Video','2.0.1'
            ss.dependency 'Yodo1Interstitial','2.0.1'
    end
    
     s.subspec 'Yodo1Advert_iOS' do |ss|
        ss.xcconfig = {
            'OTHER_LDFLAGS' => '-ObjC',
            'ENABLE_BITCODE' => 'NO',
            'ONLY_ACTIVE_ARCH' => 'NO'
        }
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
    end

    s.subspec 'Yodo1Advert_Unity3d' do |ss|
        ss.xcconfig = {
            "GCC_PREPROCESSOR_DEFINITIONS" => 'UNITY_PROJECT'
        }
        ss.dependency 'Yodo1Advert/Advert',"#{s.version}"
    end
    
    # s.dependency 'Yodo1AdsConfig',      '1.0.0'

    ##Video

    s.dependency 'VideoUnityAds',       '2.0.2'
    s.dependency 'VideoMobvista',       '2.0.2'
    s.dependency 'VideoSupersonic',     '2.0.2'
    s.dependency 'VideoApplovin',       '2.0.2'
    s.dependency 'VideoVungle',         '2.0.3'
    s.dependency 'VideoAdColony',       '2.0.0'
    s.dependency 'VideoAdmob',          '2.0.0'

    #s.dependency 'VideoCentrixlink',    '2.0.1'
    # s.dependency 'VideoChance',         '2.0.1'
    # s.dependency 'VideoChartboost',     '2.0.1'
    # s.dependency 'VideoDomob',          '2.0.1'
    # s.dependency 'VideoFacebook',       '2.0.1'
    # s.dependency 'VideoInmobi',         '2.0.1'
    # s.dependency 'VideoKTplay',         '2.0.1'
    # s.dependency 'VideoTapjoy',         '2.0.1'
    # # s.dependency 'VideoYouMi',          '2.0.1'

    s.dependency 'VideoISAdColony',     '2.0.2'
    s.dependency 'VideoISUnityAds',     '2.0.2'
    s.dependency 'VideoISAppLovin',     '2.0.2'
    s.dependency 'VideoISChartboost',   '2.0.2'
    s.dependency 'VideoISFacebook',     '2.0.2'
    # s.dependency 'VideoISTapjoy',       '2.0.1'
    s.dependency 'VideoISVungle',       '2.0.2'

    ##Interstitial
    s.dependency 'InterstitialAdmob',       '2.0.2'
    s.dependency 'InterstitialApplovin',    '2.0.2'
    s.dependency 'InterstitialSupersonic',  '1.0.2' 
    s.dependency 'InterstitialGDTMob',      '2.0.2'
    s.dependency 'InterstitialVungle',      '1.0.0'
    s.dependency 'InterstitialAdview',      '2.0.1'

    # s.dependency 'InterstitialTapjoy',      '1.0.1' 
    # s.dependency 'InterstitialFacebook',    '1.0.1'
    # s.dependency 'InterstitialKTplay',      '2.0.1'
    # s.dependency 'InterstitialWmad',        '2.0.1'

    ##Banner
    s.dependency 'BannerAdmob',         '2.0.2'
    s.dependency 'BannerAdview',        '1.0.1'
    s.dependency 'BannerApplovin',      '1.0.2'
    s.dependency 'BannerGDTMob',        '1.0.2'
    s.dependency 'BannerInmobi',        '1.0.1'

    # s.dependency 'BannerWmad',          '2.0.1'

end
