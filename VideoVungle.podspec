Pod::Spec.new do |s|
    s.name             = 'VideoVungle'
    s.version          = '2.0.6'
    s.summary          = '更新VungleSDk 5.4.0,最低支持iOS 8,添加广告位'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"
    s.homepage         = 'http://git.yodo1.cn'
    # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files = tags +'/*.{h,m}'

    #s.public_header_files = tags +'/*.h'
    
    s.vendored_libraries = tags + '/*.a'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.dependency 'Yodo1Video','2.0.2'
    s.dependency 'Yodo1AdsVungle','1.0.5'
end
