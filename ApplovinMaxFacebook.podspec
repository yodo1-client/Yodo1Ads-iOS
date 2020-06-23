Pod::Spec.new do |s|
    s.name             = 'ApplovinMaxFacebook'
    s.version          = '4.1.4'
    s.summary          = 'v6.12.8 更新Facebook的adapter v5.9.0'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ApplovinMax/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    #s.source_files = "#{s.version}" +'/*.{h,m}'
    #s.public_header_files = "#{s.version}" +'/*.h'

    # s.vendored_libraries = "#{s.version}" + '/*.a'
    s.vendored_frameworks = "#{s.version}" + '/*.framework'
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
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

    s.dependency 'YD1ApplovinMax','4.1.4'
    s.dependency 'Yodo1AdsFacebook','4.1.2'
end
