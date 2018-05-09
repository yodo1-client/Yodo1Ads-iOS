Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsUnityAds'
    s.version          = '1.0.3'
    s.summary          = 'UnityAds of v2.2.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"                    
    s.homepage         = 'http://git.yodo1.cn'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags +'/UnityAds.framework/Headers/*.h'

    s.public_header_files = tags +'/UnityAds.framework/Headers/*.h'
     
    s.vendored_frameworks = tags +'/UnityAds.framework'
    
    s.preserve_path = 'ChangeLog.txt'
    
    s.libraries = 'sqlite3.0','z'
    
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'UIKit', 'Security','SystemConfiguration','CoreGraphics','CoreTelephony','CoreFoundation','AdSupport','AVFoundation'
end
