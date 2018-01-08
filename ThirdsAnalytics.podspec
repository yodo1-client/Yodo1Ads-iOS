Pod::Spec.new do |s|
    s.name             = 'ThirdsAnalytics'
    s.version          = '1.0.0'
    s.summary          = 'A short description of Yodo1Analytics.'

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
    
    tags               = "#{s.name}"    
                    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files  = tags + '/*.{h,mm}',tags + '/Adapter/**/*.{h,m}'
    
    s.public_header_files = tags + '/*.h',tags + '/Adapter/**/*.h'
    
    s.vendored_libraries = tags + '/*.a'
    
    s.preserve_paths = 'ChangeLog.txt'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
   
    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z'
    
    s.dependency 'Yodo1Commons','2.0.1'
    s.dependency 'Yodo1TalkingData','1.0.1'
    s.dependency 'Yodo1MobClick','1.0.1'
    s.dependency 'Yodo1GameAnalytics','1.0.1'
    s.dependency 'Yodo1KeyInfo','2.0.1'
    s.dependency 'Yodo1OnlineParameter','1.0.5'

end
