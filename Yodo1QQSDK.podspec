Pod::Spec.new do |s|
    s.name              = 'Yodo1QQSDK'
    s.version           = '3.0.1'
    s.summary           = 'QQ v3.3.3'
    s.description       = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = "#{s.version}" + '/TencentOpenAPI.framework/Headers/*.h'

    # s.resources = "#{s.version}" + '/TencentOpenApi_IOS_Bundle.bundle'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.public_header_files = "#{s.version}" + '/TencentOpenAPI.framework/Headers/*.h'

    s.vendored_frameworks = "#{s.version}" + '/TencentOpenAPI.framework'


    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

    s.requires_arc = true

    s.frameworks = 'UIKit', 'Security','SystemConfiguration','CoreGraphics','CoreTelephony','ImageIO','CloudKit','GameKit'


    s.libraries = 'iconv','sqlite3.0','z','c++'

end
