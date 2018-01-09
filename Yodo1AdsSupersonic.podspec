Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsSupersonic'
    s.version          = '1.0.0'
    s.summary          = 'IronSource更新6.6.7.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here 测试.
                       DESC
    tags               = "#{s.name}"                 
    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/IronSource.framework/Versions/A/Headers/*.h'
    s.preserve_paths = tags + '/IronSource.framework/*'
    s.vendored_frameworks = tags + '/IronSource.framework'
    s.public_header_files = tags + '/IronSource.framework/Versions/A/Headers/*.h'
    s.preserve_path = 'ChangeLog.txt'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }
    s.requires_arc = true
    s.frameworks = 'UIKit', 'Foundation','AVFoundation','CoreMedia','CoreVideo','QuartzCore','SystemConfiguration','CoreGraphics','CFNetwork','MobileCoreServices','StoreKit','AdSupport','CoreLocation','CoreTelephony','Security','WebKit'
    s.libraries = 'z'
end
