Pod::Spec.new do |s|
    s.name             = 'Yodo1AppsFlyer'
    s.version          = '1.0.0'
    s.summary          = 'A short description of Yodo1AppsFlyer.'

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
    
    tags               = "#{s.name}"    
                    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files  = tags + '/AppsFlyerLib.framework/Versions/A/Headers/*.h'
    
    s.public_header_files = tags + '/AppsFlyerLib.framework/Versions/A/Headers/*.h'
    
    s.vendored_frameworks = tags + '/AppsFlyerLib.framework'
    
    s.preserve_paths = tags +'/ChangeLog.txt'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
   
    s.frameworks = 'iAd','Security', 'SystemConfiguration'

    s.weak_frameworks = 'AdSupport'

end
