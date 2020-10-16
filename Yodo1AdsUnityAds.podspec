Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsUnityAds'
    s.version          = '4.1.6'
    s.summary          = 'UnityAds of v3.5.0,修改命名冲突和Unity引擎 支持iOS 14'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files = "#{s.version}" +'/UnityAds.framework/Headers/*.h'

    s.public_header_files = "#{s.version}" +'/UnityAds.framework/Headers/*.h'
     
    s.vendored_frameworks = "#{s.version}" +'/UnityAds.framework'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.libraries = 'sqlite3.0','z'
    
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = [
        'UIKit',
        'Security',
        'SystemConfiguration',
        'CoreGraphics',
        'CoreTelephony',
        'CoreFoundation',
        'AdSupport',
        'AVFoundation'
     ]

end
