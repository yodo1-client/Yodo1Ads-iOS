Pod::Spec.new do |s|
    s.name             = 'VideoKTplay'
    s.version          = '2.0.2'
    s.summary          = 'A short description of VideoKTplay.'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"

    s.homepage         = 'https://github.com/yixian huang/VideoKTplay'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter

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

    s.libraries = 'sqlite3', 'z'

    s.dependency 'Yodo1Video','2.0.2'
    s.dependency 'Yodo1AdsKTplay', '1.0.0'
end
