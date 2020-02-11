Pod::Spec.new do |s|
    s.name             = 'AdmobTapjoy'
    s.version          = '3.2.7'
    s.summary          = 'Admob 更新v7.55.0'
    s.description      = <<-DESC
    TODO: Add long description of the pod here 测试.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1Admob/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = "#{s.version}" + '/TapjoyAdapter.framework/Versions/A/Headers/*.h'
    s.preserve_paths = "#{s.version}" + '/TapjoyAdapter.framework/*'
    s.vendored_frameworks = "#{s.version}" + '/TapjoyAdapter.framework'
    s.public_header_files = "#{s.version}" + '/TapjoyAdapter.framework/Versions/A/Headers/*.h'

    valid_archs = ['armv7', 'x86_64', 'arm64']

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO',
        'VALID_ARCHS' =>  valid_archs.join(' '),
    }

    s.requires_arc = true
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

    s.libraries = 'z'
    
    s.dependency 'YD1Admob','3.2.6'
    s.dependency 'Yodo1AdsTapjoy','3.2.1'

end
