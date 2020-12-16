Pod::Spec.new do |s|
    s.name             = 'Yodo1AntiIndulged'
    s.version          = '2.0.4'
    s.summary          = 'release'
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
    s.source_files = "#{s.version}" + '/Yodo1AntiIndulged/Classes/**/*'
    s.public_header_files = "#{s.version}" + '/Yodo1AntiIndulged/Classes/**/*.h'

    # 用于解决Unity2019.3.0(包含2019.3.0)以上无法读取问题，Unity会添加CCopy资源脚本
    s.resource_bundles = {
        'Yodo1AntiIndulgedResource' => ["#{s.version}" + '/Yodo1AntiIndulged/Assets/*']
    }

    # 用于解决Unity2019.3.0(不包含2019.3.0)以下以及native原生资源无法读取问题
    s.resources = "#{s.version}" + '/Yodo1AntiIndulged/Assets/*.png'

    # s.source_files  = "#{s.version}" + '/*/*/*.{h,mm,m}',"#{s.version}" + '/*/*.{h,mm,m}'
    # s.public_header_files = "#{s.version}" + '/*/*/*.h',"#{s.version}" + '/*/*.h'
    
    # s.resources = "#{s.version}" + '/yodo1-anti-indulged/*.bundle', "#{s.version}" + '/yodo1-anti-indulged/View/*.{storyboard,xib,xcassets,json,png}', "#{s.version}" + '/yodo1-anti-indulged/View/*.storyboard'
    
    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'
    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'sqlite3', 'z'
    s.compiler_flags = '-Dunix'
    
    s.dependency 'Yodo1OnlineParameter','4.2.6'
    s.dependency 'Yodo1UCenter', '4.2.11'
    s.dependency 'Yodo1AFNetworking','4.1.0'
    s.dependency 'Yodo1Commons','4.1.2'
    s.dependency 'FMDB'
    s.dependency 'Masonry'
    s.dependency 'Toast'
    s.dependency 'TPKeyboardAvoiding'

end
