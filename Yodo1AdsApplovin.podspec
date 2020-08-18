Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsApplovin'
    s.version          = '4.1.5'
    s.summary          = 'sdk v6.13.4'
    s.description      = <<-DESC
                        TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    
    s.ios.deployment_target = '9.0'

    s.source_files =  "#{s.version}" + '/AppLovinSDK.framework/headers/*.h'

    s.public_header_files =  "#{s.version}" + '/AppLovinSDK.framework/headers/*.h'

    # s.vendored_libraries =  "#{s.version}" + '/*.a'
    s.resource = "#{s.version}" + '/*.bundle'
    s.vendored_frameworks = "#{s.version}" + '/AppLovinSDK.framework'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = 'AdSupport', 'AVFoundation', 'CoreTelephony', 'CoreGraphics', 'CoreMedia', 'StoreKit', 'SystemConfiguration', 'UIKit','WebKit','AudioToolbox'

    s.weak_frameworks = 'SafariServices'


    s.libraries = 'sqlite3.0','z'
    
end