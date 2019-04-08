Pod::Spec.new do |s|
    s.name             = 'Yodo1SwrveSDK'
    s.version          = '3.0.1'
    s.summary          = 'Swrve 统计SDK [SDK v6.1.0]'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = [
        "#{s.version}" + '/SwrveSDK.framework/Headers/*.h',
        "#{s.version}" + '/SwrveSDKCommon.framework/Headers/*.h',
        "#{s.version}" + '/SwrveConversationSDK.framework/Headers/*.h'
    ]

    s.public_header_files = [
        "#{s.version}" + '/SwrveSDK.framework/Headers/*.h',
        "#{s.version}" + '/SwrveSDKCommon.framework/Headers/*.h',
        "#{s.version}" + '/SwrveConversationSDK.framework/Headers/*.h'
    ]

    # s.resources = "#{s.version}" + '/*.bundle'

    s.vendored_frameworks = [
        "#{s.version}" + '/SwrveSDK.framework',
        "#{s.version}" + '/SwrveSDKCommon.framework',
        "#{s.version}" + '/SwrveConversationSDK.framework'
    ]


    s.libraries = 'sqlite3'
    s.compiler_flags = '-Dunix'
    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = [  
        'UIKit', 
        'QuartzCore', 
        'CFNetwork', 
        'StoreKit', 
        'Security', 
        'AVFoundation',
        'CoreText',
        'MessageUI',
        'CoreTelephony', 
        'CoreLocation'
    ]

    s.weak_frameworks = [
        'Contacts', 
        'AssetsLibrary', 
        'Photos', 
        'AddressBook', 
        'UserNotifications'
    ]

end
