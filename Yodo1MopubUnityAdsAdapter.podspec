Pod::Spec.new do |s|
    s.name             = 'Yodo1MopubUnityAdsAdapter'
    s.version          = '3.0.4'
    s.summary          = 'Mopub sdk v5.5.0 聚合'
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
    
    s.source_files = "#{s.version}" + '/*.{h,m}'
    s.public_header_files = "#{s.version}" + '/*.h'
    
    # s.resources = "#{s.version}" + '/*.bundle'
    # s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    # s.vendored_frameworks = "#{s.version}" + '/MOAT/MPUBMoatMobileAppKit.framework'
    # s.vendored_libraries = "#{s.version}" + '/*.a',"#{s.version}" + '/Avid/*.a'
    
    # s.compiler_flags = '-Wdocumentation','-Wundeclared-selector'
    
    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'CoreMotion','UIKit', 'Foundation','AVFoundation','CoreMedia','CoreVideo','QuartzCore','SystemConfiguration','CoreGraphics','CFNetwork','MobileCoreServices','StoreKit','AdSupport','CoreLocation','CoreTelephony','Security','WebKit','MediaPlayer','SafariServices'

    s.weak_frameworks = 'AdSupport'

    s.dependency 'Yodo1AdsMopub','3.0.1'
    s.dependency 'Yodo1AdsUnityAds','3.0.5'
    # s.libraries = 'c++'
end
