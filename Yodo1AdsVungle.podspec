Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsVungle'
    s.version          = '4.0.0'
    s.summary          = '更新sdk v6.5.1 [iOS 13]remove UIWebview'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files = "#{s.version}" + '/VungleSDK.framework/Headers/*.h'

    s.public_header_files = "#{s.version}" + '/VungleSDK.framework/Headers/*.h'

    #s.resources = "#{s.version}" + '/Classes/VungleSDK.embeddedframework/Resources/*.*'
    
    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.vendored_frameworks = "#{s.version}" + '/VungleSDK.framework'

    s.requires_arc = true

    valid_archs = ['armv7','arm64','x86_64']
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' ')
    }

    s.frameworks = [
        'AdSupport',
        'AudioToolbox', 
        'AVFoundation', 
        'CFNetwork', 
        'CoreGraphics', 
        'CoreMedia', 
        'Foundation', 
        'MediaPlayer', 
        'QuartzCore', 
        'StoreKit', 
        'SystemConfiguration', 
        'UIKit', 
        'WebKit'
    ]

    s.libraries = 'z'

end
