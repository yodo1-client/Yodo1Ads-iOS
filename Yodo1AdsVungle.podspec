Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsVungle'
    s.version          = '3.0.2'
    s.summary          = '更新sdk v6.3.2,支持DGPR'
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

    s.source_files = "#{s.version}" + '/VungleSDK.framework/Headers/*.h'

    s.public_header_files = "#{s.version}" + '/VungleSDK.framework/Headers/*.h'

    #s.resources = "#{s.version}" + '/Classes/VungleSDK.embeddedframework/Resources/*.*'
    
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.vendored_frameworks = "#{s.version}" + '/VungleSDK.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC'
    }

    s.frameworks = 'AdSupport', 'AudioToolbox', 'AVFoundation', 'CFNetwork', 'CoreGraphics', 'CoreMedia', 'Foundation', 'MediaPlayer', 'QuartzCore', 'StoreKit', 'SystemConfiguration', 'UIKit', 'WebKit'

    s.libraries = 'z'

end
