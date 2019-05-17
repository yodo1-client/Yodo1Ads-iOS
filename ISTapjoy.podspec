Pod::Spec.new do |s|
    s.name             = 'ISTapjoy'
    s.version          = '3.1.1'
    s.summary          = 'Adapter和SDK分离'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ISource/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    # s.source_files =  "#{s.version}" + '/ISTapjoyAdapter.framework/Versions/A/Headers/*.h'

    # s.public_header_files =  "#{s.version}" + '/ISTapjoyAdapter.framework/Versions/A/Headers/*.h'

    s.preserve_path =  "#{s.version}" + '/ChangeLog.txt'
        
    # s.vendored_frameworks =  "#{s.version}" + '/ISTapjoyAdapter.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth','UIKit','CoreGraphics'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.libraries = 'sqlite3.0','z'

    s.dependency 'YD1IronSource','3.1.1'

    s.dependency 'Yodo1IronSourceTapjoy', '3.0.2'

end
