Pod::Spec.new do |s|
    s.name             = 'VideoISUnityAds'
    s.version          = '3.0.21'
    s.summary          = 'Adapter和SDK分离,更新UnityAds v3.0.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/video/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    # s.source_files = "#{s.version}" + '/ISUnityAdsAdapter.framework/Versions/A/Headers/*.h'

    # s.public_header_files = "#{s.version}" + '/ISUnityAdsAdapter.framework/Versions/A/Headers/*.h'


    # s.vendored_frameworks = "#{s.version}" + '/ISUnityAdsAdapter.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.dependency 'VideoIronSource','3.0.19'

    s.dependency 'Yodo1IronSourceUnityAds','3.0.0'
end
