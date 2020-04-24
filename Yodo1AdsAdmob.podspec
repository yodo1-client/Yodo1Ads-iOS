Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsAdmob'
    s.version          = '4.1.1'
    s.summary          = 'Admob sdk v7.58.0'
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

    s.source_files = "#{s.version}" + '/GoogleMobileAds.framework/Headers/**/*.h',"#{s.version}" + '/GoogleUtilities.framework/Headers/*.h',"#{s.version}" + '/nanopb.framework/Headers/*.h'



    s.public_header_files = "#{s.version}" + '/GoogleMobileAds.framework/Headers/**/*.h',"#{s.version}" + '/GoogleUtilities.framework/Headers/*.h',"#{s.version}" + '/nanopb.framework/Headers/*.h'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    # s.vendored_libraries = "#{s.version}" + '/*.a'

    s.vendored_frameworks = "#{s.version}" + '/GoogleMobileAds.framework',"#{s.version}" + '/GoogleUtilities.framework',"#{s.version}" + '/nanopb.framework',"#{s.version}" + '/GoogleAppMeasurement.framework'

    s.frameworks = 'AudioToolbox', 'AVFoundation','CoreGraphics', 'CoreMedia','CoreMotion', 'CoreTelephony' ,'CoreVideo', 'GLKit','MediaPlayer', 'MessageUI', 'MobileCoreServices','OpenGLES','Security','StoreKit' ,'SystemConfiguration'

    s.weak_frameworks = 'AdSupport','SafariServices','JavaScriptCore','WebKit'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }
    
    s.libraries = 'sqlite3.0','z','c++'
    
end
