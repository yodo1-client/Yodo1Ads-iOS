Pod::Spec.new do |s|
    s.name              = 'Yodo1SaAnalytics'
    s.version           = '4.0.0'
    s.summary           = 'Sa SDK  v1.0.0'
    s.description       = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files = "#{s.version}" + '/*.framework/Headers/*.h'

    s.resources = "#{s.version}" + '/*.bundle'

    # s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.public_header_files = "#{s.version}" + '/*.framework/Headers/*.h'

    s.vendored_frameworks = "#{s.version}" + '/*.framework'


    valid_archs = ['armv7','arm64','x86_64']
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' ')
    }

    s.requires_arc = true

    s.frameworks = 'UIKit', 'Security','SystemConfiguration','CoreGraphics','CoreTelephony','ImageIO','CloudKit','GameKit','WebKit'


    s.libraries = 'c++'

end
