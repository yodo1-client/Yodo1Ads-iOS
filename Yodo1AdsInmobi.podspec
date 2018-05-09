Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsInmobi'
    s.version          = '1.0.2'
    s.summary          = 'Inmobi v7.1.1'
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

    s.ios.deployment_target = '8.0'

    s.source_files = tags + '/InMobiSDK.framework/Headers/*.h'
    s.public_header_files = tags + '/InMobiSDK.framework/Headers/*.h'
    s.vendored_frameworks = tags + '/InMobiSDK.framework'
    s.preserve_paths = tags + '/InMobiSDK.framework', 'ChangeLog.txt'
    
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
