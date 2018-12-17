Pod::Spec.new do |s|
    s.name             = 'Yodo1Video'
    s.version          = '3.0.10'
    s.summary          = '2018.1.3 Github'
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
    
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.requires_arc = true

    s.libraries = 'sqlite3', 'z', 'c++'

    s.frameworks = 'Foundation', 'UIKit'

    s.dependency 'Yodo1Commons','3.0.2'
    s.dependency 'Yodo1OnlineParameter','3.0.2'
    s.dependency 'Yodo1Analytics','3.0.3'
    s.dependency 'Yodo1AdsConfig','3.0.5'
end
