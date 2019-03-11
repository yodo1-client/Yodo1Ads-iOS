Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsAdmob'
    s.version          = '3.0.6'
    s.summary          = '2019.03.08 Admob sdk v7.40.0'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = "#{s.version}" + '/GoogleMobileAds.framework/Headers/**/*.h'

    s.public_header_files = "#{s.version}" + '/GoogleMobileAds.framework/Headers/**/*.h'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.requires_arc = true
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.vendored_frameworks = "#{s.version}" + '/GoogleMobileAds.framework'

    s.frameworks = 'AudioToolbox', 'AVFoundation','CoreGraphics', 'CoreMedia','CoreMotion', 'CoreTelephony' ,'CoreVideo', 'GLKit','MediaPlayer', 'MessageUI', 'MobileCoreServices','OpenGLES','Security','StoreKit' ,'SystemConfiguration'

    s.weak_frameworks = 'AdSupport','SafariServices','JavaScriptCore','WebKit'

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.libraries = 'sqlite3.0','z','c++'
    
end
