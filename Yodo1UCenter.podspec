Pod::Spec.new do |s|
    s.name             = 'Yodo1UCenter'
    s.version          = '2.0.4'
    s.summary          = 'v2.0.4,添加AppsFlyer 内付费验证和事件统计'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    tags               = "#{s.name}" 

    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files  = tags + '/*.{h,mm,m}',tags + '/PayAdapter/*.{h,m}'

    s.public_header_files = tags + '/*.h',tags + '/PayAdapter/*.h'

    #s.vendored_frameworks = tags + '/UCenter.framework'
    
    s.vendored_libraries = tags + '/*.a'

    s.resources = tags + '/*.bundle'

    s.preserve_path = 'ChangeLog.txt'
    
    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }
    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.libraries = 'sqlite3', 'z'
    s.requires_arc = false
    s.compiler_flags = '-Dunix'
    
    s.dependency 'Yodo1Commons','2.0.1'
    s.dependency 'Yodo1WeiboSDK','1.0.2'
    s.dependency 'Yodo1QQSDK','1.0.2'
    s.dependency 'Yodo1AFNetworking','2.0.4'
    s.dependency 'Yodo1Reachability','1.0.2'
    s.dependency 'Yodo1KeyInfo','2.0.1'
    s.dependency 'Yodo1ThirdsAnalytics','1.0.0'
end
