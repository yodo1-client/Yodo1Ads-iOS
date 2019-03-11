Pod::Spec.new do |s|
    s.name             = 'InterstitialAdmobVungle'
    s.version          = '3.0.19'
    s.summary          = 'Admob 更新v7.40.0'
    s.description      = <<-DESC
    TODO: Add long description of the pod here 测试.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/interstitial/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = "#{s.version}" + '/VungleAdapter.framework/Versions/A/Headers/*.h'
    s.preserve_paths = "#{s.version}" + '/VungleAdapter.framework/*'
    s.vendored_frameworks = "#{s.version}" + '/VungleAdapter.framework'
    s.public_header_files = "#{s.version}" + '/VungleAdapter.framework/Versions/A/Headers/*.h'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }
    s.requires_arc = true
    s.frameworks = 'UIKit', 'Foundation','AVFoundation','CoreMedia','CoreVideo','QuartzCore','SystemConfiguration','CoreGraphics','CFNetwork','MobileCoreServices','StoreKit','AdSupport','CoreLocation','CoreTelephony','Security','WebKit'
    s.libraries = 'z'
    
    s.dependency 'InterstitialAdmob','3.0.19'
    s.dependency 'Yodo1AdsVungle','3.0.2'

end
