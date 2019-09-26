Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsFacebook'
    s.version          = '3.1.1'
    s.summary          = 'FBAudienceNetwork v5.5.1 [支持iOS13]'
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

    s.source_files =  "#{s.version}" + '/FBAudienceNetwork.framework/Headers/*.h',"#{s.version}"

    s.public_header_files =  "#{s.version}" + '/FBAudienceNetwork.framework/Headers/*.h',"#{s.version}"

    s.preserve_paths = 'ChangeLog.txt',"#{s.version}" + '/FBAudienceNetwork.framework'
    
    s.vendored_frameworks = "#{s.version}" + '/FBAudienceNetwork.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth','VideoToolbox'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'
    s.libraries = 'xml2','c++'
    
    s.dependency 'Yodo1FBSDKCoreKit','3.1.0'
end
