Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsMobvista'
    s.version          = '1.0.5'
    s.summary          = '更新Yodo1MobvistaManager.'
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

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/MVSDK.framework/Versions/A/Headers/*.h',tags + '/MVSDKReward.framework/Versions/A/Headers/*.h'

    s.public_header_files = tags + '/MVSDK.framework/Versions/A/Headers/*.h',tags + '/MVSDKReward.framework/Versions/A/Headers/*.h'
    
    s.vendored_libraries = tags + '/*.a'

    s.preserve_path = 'ChangeLog.txt'

    s.vendored_frameworks = tags + '/MVSDK.framework',tags + '/MVSDKReward.framework'

    s.requires_arc = false

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z','stdc++','xml2'
end
