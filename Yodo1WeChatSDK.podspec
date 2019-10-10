Pod::Spec.new do |s|
    s.name             = 'Yodo1WeChatSDK'
    s.version          = '3.0.2'
    s.summary          = 'v1.8.6.1 移除UIWebview'
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

    s.source_files = "#{s.version}" + '/*.h'

    s.public_header_files = "#{s.version}" + '/*.h'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt',"#{s.version}" + '/README.txt'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'
    
    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

    s.frameworks = 'UIKit', 'ImageIO','SystemConfiguration','Security','CoreTelephony','WebKit'

    s.libraries = 'z','sqlite3','stdc++'

end
