Pod::Spec.new do |s|
    s.name             = 'Yodo1TwitterKit'
    s.version          = '3.0.0'
    s.summary          = 'TwitterKit SDK 分享,TwitterKit v3.2.1,TwitterCore v3.0.2'

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

    s.source_files = "#{s.version}" + '/Fabric.framework/Headers/*.h',"#{s.version}" + '/TwitterCore.framework/Headers/*.h',"#{s.version}" + '/TwitterKit.framework/Headers/*.h'

    s.public_header_files = "#{s.version}" + '/Fabric.framework/Headers/*.h',"#{s.version}" + '/TwitterCore.framework/Headers/*.h',"#{s.version}" + '/TwitterKit.framework/Headers/*.h'

    s.resources = "#{s.version}" + '/*.bundle'

    s.vendored_frameworks = "#{s.version}" + '/Fabric.framework',"#{s.version}" + '/TwitterCore.framework',"#{s.version}" + '/TwitterKit.framework'
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
