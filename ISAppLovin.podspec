Pod::Spec.new do |s|
    s.name             = 'ISAppLovin'
    s.version          = '3.1.5'
    s.summary          = 'Applovin SDK 和 adapter 分离(更新Applovin 6.7.1)'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/advert/YD1ISource/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'


    # s.source_files = "#{s.version}" + '/ISAppLovinAdapter.framework/Versions/A/Headers/*.h'

    # s.public_header_files = "#{s.version}" + '/ISAppLovinAdapter.framework/Versions/A/Headers/*.h'


    # s.vendored_frameworks = "#{s.version}" + '/ISAppLovinAdapter.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'Accounts', 'AssetsLibrary','AVFoundation', 'CoreTelephony','CoreLocation', 'CoreMotion' ,'CoreMedia', 'EventKit','EventKitUI', 'iAd', 'ImageIO','MobileCoreServices', 'MediaPlayer' ,'MessageUI','MapKit','Social','StoreKit','Twitter','WebKit','SystemConfiguration','AudioToolbox','Security','CoreBluetooth'

    s.weak_frameworks = 'AdSupport','SafariServices','ReplayKit','CloudKit','GameKit'

    s.dependency 'YD1IronSource','3.1.4'
    
    s.dependency 'Yodo1IronSourceApplovin','3.0.5'
end
