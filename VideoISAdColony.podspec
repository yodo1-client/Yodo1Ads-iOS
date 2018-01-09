Pod::Spec.new do |s|
    s.name             = 'VideoISAdColony'
    s.version          = '2.0.1'
    s.summary          = 'Adcolony SDK 和 adapter 分离(更新Adcolony 3.2.1)'

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

    s.source_files =  tags + '/ISAdColonyAdapter.framework/Versions/A/Headers/*.h'

    s.public_header_files =  tags + '/ISAdColonyAdapter.framework/Versions/A/Headers/*.h'

    s.preserve_path =  'ChangeLog.txt'

    s.vendored_frameworks =  tags + '/ISAdColonyAdapter.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z'

    s.dependency 'VideoSupersonic','2.0.1'

    s.dependency 'Yodo1AdsAdColony','1.0.0'
    
end
