Pod::Spec.new do |s|
    s.name             = 'Yodo1Video'
    s.version          = '2.0.2'
    s.summary          = '2018.1.3 Github'
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

    s.ios.deployment_target = '8.0'

    s.source_files = tags + '/*.h'
    
    s.public_header_files = tags + '/*.h'
    
    s.preserve_path = 'ChangeLog.txt'
    
    s.vendored_libraries = tags + '/*.a'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.requires_arc = true

    s.libraries = 'sqlite3', 'z', 'stdc++'

    s.frameworks = 'Foundation', 'UIKit'

    s.dependency 'Yodo1Commons','2.0.1'
    s.dependency 'Yodo1OnlineParameter','1.0.5'
    s.dependency 'Yodo1Analytics','2.0.2'
    s.dependency 'Yodo1AdsConfig','1.0.0'
end
