Pod::Spec.new do |s|
    s.name             = 'Yodo1Advert'
    s.version          = '3.0.8'
    s.summary          = '2018.10.11 9月份list更新版本 国内外版本
                            Yodo1Ads v3.0.12'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.subspec 'Advert' do |ss|
            ss.source_files = "#{s.version}" + '/*.h'
            ss.public_header_files = "#{s.version}" + '/*.h'
            ss.preserve_path = "#{s.version}" + '/ChangeLog.txt',"#{s.version}" + '/VERSION'
            ss.vendored_libraries = "#{s.version}" + '/*.a'
            ss.requires_arc = false
            ss.xcconfig = {
                'OTHER_LDFLAGS' => '-ObjC',
                'ENABLE_BITCODE' => 'NO',
                'ONLY_ACTIVE_ARCH' => 'NO'
            }
            ss.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'
            ss.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
            ss.libraries = 'sqlite3.0','z','stdc++'
            
            ss.dependency 'Yodo1Banner','3.0.5'
            ss.dependency 'Yodo1Video','3.0.4'
            ss.dependency 'Yodo1Interstitial','3.0.5'
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
    
    # s.dependency 'Yodo1AdsConfig',      '1.0.1'

    ##Video

    s.dependency 'VideoUnityAds',       '3.0.7'
    s.dependency 'VideoMintegral',      '3.0.7'
    s.dependency 'VideoVungle',         '3.0.6'
    s.dependency 'VideoAdmob',          '3.0.7'
    s.dependency 'VideoToutiao',        '3.0.9'
    s.dependency 'VideoTapjoy',         '3.0.7'

    s.dependency 'VideoIronSource',     '3.0.8'
    s.dependency 'VideoFacebook',       '3.0.7'
    # s.dependency 'VideoAdColony',       '2.0.3'
    #s.dependency 'VideoApplovin',       '2.0.6'

    # s.dependency 'VideoCentrixlink',    '2.0.1'
    # s.dependency 'VideoChance',         '2.0.1'
    # s.dependency 'VideoChartboost',     '2.0.1'
    # s.dependency 'VideoDomob',          '2.0.1'
    # s.dependency 'VideoInmobi',         '2.0.1'
    # s.dependency 'VideoKTplay',         '2.0.1'
    # s.dependency 'VideoYouMi',          '2.0.1'

    # s.dependency 'VideoISAdColony',     '2.0.6'
    # s.dependency 'VideoISAppLovin',     '2.0.6'
    # s.dependency 'VideoISChartboost',   '2.0.6'
    
    # IronSource 聚合
    s.dependency 'VideoISFacebook',     '3.0.8'
    s.dependency 'VideoISUnityAds',     '3.0.9'
    s.dependency 'VideoISVungle',       '3.0.8'
    s.dependency 'VideoISTapjoy',       '3.0.9'

    ##Interstitial
    s.dependency 'InterstitialAdmob',       '3.0.7'
    s.dependency 'InterstitialVungle',      '3.0.7'
    s.dependency 'InterstitialMintegral',   '3.0.8'
    s.dependency 'InterstitialTapjoy',      '3.0.8' 
    s.dependency 'InterstitialToutiao',     '3.0.10'
    s.dependency 'InterstitialGDTMob',      '3.0.8'

    # s.dependency 'InterstitialIronSource',  '3.0.8' 
    # s.dependency 'InterstitialFacebook',    '3.0.7'

    # s.dependency 'InterstitialApplovin',    '3.0.6'

    # s.dependency 'InterstitialAdview',      '3.0.0'

    ##Banner
    s.dependency 'BannerAdmob',         '3.0.5'
    s.dependency 'BannerToutiao',       '3.0.9'
    s.dependency 'BannerGDTMob',        '3.0.6'
    # s.dependency 'BannerAdview',        '1.0.4'
    # s.dependency 'BannerApplovin',      '3.0.2'
    # s.dependency 'BannerInmobi',        '3.0.2'

end
