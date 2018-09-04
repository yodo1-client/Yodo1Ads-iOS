Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsUMAdSDK'
    s.version          = '3.0.3'
    s.summary          = '头条sdk v1.9.4.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'
    s.source_files = "#{s.version}" + '/WMAdSDK.framework/Headers/*.h'
    s.public_header_files = "#{s.version}" + '/WMAdSDK.framework/Headers/*.h'
    s.resources = "#{s.version}" + '/*.bundle'
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    s.vendored_frameworks = "#{s.version}" + '/WMAdSDK.framework'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'CoreMotion','UIKit', 'Foundation','AVFoundation','CoreMedia','CoreVideo','QuartzCore','SystemConfiguration','CoreGraphics','CFNetwork','MobileCoreServices','StoreKit','AdSupport','CoreLocation','CoreTelephony','Security','WebKit'

    s.weak_frameworks = 'AdSupport'

    s.libraries = 'c++','resolv.9'
end
