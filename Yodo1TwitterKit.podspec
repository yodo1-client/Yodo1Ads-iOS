Pod::Spec.new do |s|
    s.name             = 'Yodo1TwitterKit'
    s.version          = '1.0.2'
    s.summary          = 'TwitterKit SDK 分享,TwitterKit v3.2.1,TwitterCore v3.0.2'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    tags               = "#{s.name}"  
    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.source_files = tags + '/Fabric.framework/Headers/*.h',tags + '/TwitterCore.framework/Headers/*.h',tags + '/TwitterKit.framework/Headers/*.h'

    s.public_header_files = tags + '/Fabric.framework/Headers/*.h',tags + '/TwitterCore.framework/Headers/*.h',tags + '/TwitterKit.framework/Headers/*.h'

    s.resources = tags + '/*.bundle'

    s.vendored_frameworks = tags + '/Fabric.framework',tags + '/TwitterCore.framework',tags + '/TwitterKit.framework'
    s.libraries = 'sqlite3', 'z', 'stdc++'
    s.compiler_flags = '-Dunix'
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

end
