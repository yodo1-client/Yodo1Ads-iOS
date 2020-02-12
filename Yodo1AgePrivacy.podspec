Pod::Spec.new do |s|
    s.name             = 'Yodo1AgePrivacy'
    s.version          = '4.0.0'
    s.summary          = '添加隐私，未成年提示功能,兼容iOS 13 [优化多语言选择]添加隐私协议字段'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/foundation/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'

    s.source_files  = "#{s.version}" + '/*.h'

    s.public_header_files = "#{s.version}" + '/*.h'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'

    s.resources = "#{s.version}" + '/*.bundle'

    # s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    valid_archs = ['armv7','arm64','x86_64']
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' ')
    }
    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.libraries = 'sqlite3', 'z'
    s.requires_arc = true
    s.compiler_flags = '-Dunix'
    
    s.dependency 'Yodo1Commons','4.0.0'
    s.dependency 'Yodo1AFNetworking','4.0.0'
    s.dependency 'Yodo1YYModel','4.0.0'
    s.dependency 'Yodo1YYCache','4.0.0'
    s.dependency 'Yodo1Layout','4.0.0'
end
