Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsIronSource'
    s.version          = '3.0.4'
    s.summary          = 'IronSource更新6.8.0.0'
    s.description      = <<-DESC
    TODO: Add long description of the pod here 测试.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = "#{s.version}" + '/IronSource.framework/Versions/A/Headers/*.h'
    s.preserve_paths = "#{s.version}" + '/IronSource.framework/*'
    s.vendored_frameworks = "#{s.version}" + '/IronSource.framework'
    s.public_header_files = "#{s.version}" + '/IronSource.framework/Versions/A/Headers/*.h'
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }
    s.requires_arc = true
    s.frameworks = 'UIKit', 'Foundation','AVFoundation','CoreMedia','CoreVideo','QuartzCore','SystemConfiguration','CoreGraphics','CFNetwork','MobileCoreServices','StoreKit','AdSupport','CoreLocation','CoreTelephony','Security','WebKit'
    s.libraries = 'z'
end
