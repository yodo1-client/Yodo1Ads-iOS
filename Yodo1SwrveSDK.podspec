Pod::Spec.new do |s|
    s.name             = 'Yodo1SwrveSDK'
    s.version          = '3.0.2'
    s.summary          = 'Swrve 统计SDK [SDK v6.1.0]自己创建工程导出.a'
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
        "#{s.version}" + '/Yodo1Swrve/*.h'
    ]

    s.public_header_files = [
        "#{s.version}" + '/Yodo1Swrve/*.h'
    ]

    # s.resources = "#{s.version}" + '/*.bundle'

    # s.vendored_frameworks = [
    #     "#{s.version}" + '/SwrveSDK.framework',
    #     "#{s.version}" + '/SwrveSDKCommon.framework',
    #     "#{s.version}" + '/SwrveConversationSDK.framework'
    # ]
    s.vendored_libraries = "#{s.version}" + '/*.a'

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
