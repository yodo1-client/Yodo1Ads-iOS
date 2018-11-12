Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsBaidu'
    s.version          = '3.0.0'
    s.summary          = 'Baidu v4.5.0'
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

    s.source_files = "#{s.version}" + '/BaiduMobAdSDK.framework/Headers/*.h'
    
    s.public_header_files = "#{s.version}" + '/BaiduMobAdSDK.framework/Headers/*.h'
    
    s.vendored_frameworks = "#{s.version}" + '/BaiduMobAdSDK.framework'
    
    s.resources = "#{s.version}" +'/*.bundle'

    s.preserve_paths = "#{s.version}" + '/ChangeLog.txt'
    
    s.frameworks = 'CoreLocation', 'SystemConfiguration', 'CoreGraphics', 'CoreMotion', 'CoreTelephony', 'AdSupport', 'SystemConfiguration', 'QuartzCore', 'WebKit', 'MessageUI','SafariServices','AVFoundation','EventKit','QuartzCore','CoreMedia'
    s.weak_frameworks = 'WebKit'
    
    s.libraries = 'c++'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

end
