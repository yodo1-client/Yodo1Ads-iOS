Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsInmobi'
    s.version          = '3.0.1'
    s.summary          = 'Inmobi v7.2.1'
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

    s.source_files = "#{s.version}" + '/InMobiSDK.framework/Headers/*.h'
    s.public_header_files = "#{s.version}" + '/InMobiSDK.framework/Headers/*.h'
    s.vendored_frameworks = "#{s.version}" + '/InMobiSDK.framework'
    s.preserve_paths = "#{s.version}" + '/InMobiSDK.framework', 'ChangeLog.txt'
    
    s.frameworks = 'AdSupport','AudioToolbox','AVFoundation','CoreTelephony','CoreLocation','Foundation','MediaPlayer','MessageUI','StoreKit','Social','SystemConfiguration','Security','SafariServices','UIKit'
    s.weak_frameworks = 'WebKit'
    s.libraries = 'sqlite3.0','z'
    s.requires_arc = true
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

end
