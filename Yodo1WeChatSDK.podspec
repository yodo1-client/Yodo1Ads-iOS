Pod::Spec.new do |s|
    s.name             = 'Yodo1WeChatSDK'
    s.version          = '1.0.3'
    s.summary          = 'A short description of Yodo1WeChatSDK.'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"  
    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/*.h'

    s.public_header_files = tags + '/*.h'

    s.preserve_path = 'ChangeLog.txt',tags + '/README.txt'
    
    s.vendored_libraries = tags + '/*.a'
    
    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

    s.frameworks = 'UIKit', 'ImageIO','SystemConfiguration','Security','CoreTelephony'

    s.libraries = 'z','sqlite3','stdc++'

end
