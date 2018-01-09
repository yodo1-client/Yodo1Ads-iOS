Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsKTplay'
    s.version          = '1.0.0'
    s.summary          = 'KTplay Of Video and Interstital.'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"
    s.homepage         = 'https://github.com/yixian huang/Yodo1KTplay'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/KTplayAds/*.h'

    s.public_header_files = tags + '/KTplayAds/*.h'

    s.preserve_path = 'ChangeLog.txt'

    s.vendored_libraries = tags + '/**/**/*.a'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC'
    }
    s.frameworks = 'AdSupport', 'SystemConfiguration','CoreTelephony', 'QuartzCore','MobileCoreServices', 'AVFoundation' ,'ImageIO', 'Security'

#s.weak_frameworks = ''


    s.libraries = 'sqlite3.0','z','xml2'
end
