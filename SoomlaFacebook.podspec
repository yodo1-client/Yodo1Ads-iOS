Pod::Spec.new do |s|
    s.name             = 'SoomlaFacebook'
    s.version          = '3.0.10'
    s.summary          = 'A short description of SoomlaFacebook. v4.25.0-v5.3.2 [回滚Facebook v5.3.2]'

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    #s.source_files  = ["#{s.version}" + '/*.h']
    
    #s.public_header_files = ["#{s.version}" + '/*.h']
    
    s.vendored_libraries = ["#{s.version}" + '/*.a']
    
    # s.preserve_paths = "#{s.version}" + '/ChangeLog.txt'
    
    s.requires_arc = true
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
   
    s.frameworks = [
        "JavaScriptCore",
        "WebKit",
        "StoreKit",
        "AdSupport"
    ]

    s.libraries = [
        "z",
        "sqlite3.0"
    ]
    s.dependency 'Yodo1Soomla','3.0.7'
    s.dependency 'Yodo1AdsFacebook','3.0.5'
end
