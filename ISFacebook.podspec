Pod::Spec.new do |s|
    s.name             = 'ISFacebook'
    s.version          = '4.0.2'
    s.summary          = 'Facebook SDK 和Adapter 分离'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ISource/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    # s.source_files = "#{s.version}" + '/ISFacebookAdapter.framework/Versions/A/Headers/*.h'

    # s.public_header_files = "#{s.version}" + '/ISFacebookAdapter.framework/Versions/A/Headers/*.h'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.vendored_frameworks = "#{s.version}" + '/*.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = [
        'Accounts', 
        'AssetsLibrary',
        'AVFoundation', 
        'CoreTelephony',
        'CoreLocation', 
        'CoreMotion',
        'CoreMedia',
        'EventKit',
        'EventKitUI', 
        'iAd', 
        'ImageIO',
        'MobileCoreServices', 
        'MediaPlayer',
        'MessageUI',
        'MapKit',
        'Social',
        'StoreKit',
        'Twitter',
        'WebKit',
        'SystemConfiguration',
        'AudioToolbox',
        'Security',
        'CoreBluetooth'
    ]
    s.libraries = 'sqlite3', 'z'
    
    s.dependency 'YD1IronSource','4.1.13'

    s.dependency 'Yodo1AdsFacebook','4.1.4'
    
end
