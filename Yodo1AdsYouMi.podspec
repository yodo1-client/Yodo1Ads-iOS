Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsYouMi'
    s.version          = '1.0.4'
    s.summary          = 'Youmi SDK v4.1.6'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                   DESC
    tags               = "#{s.name}"  
    s.homepage         = 'http://git.yodo1.cn'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/include/*.h'
    
    s.public_header_files = tags + '/include/*.h'
    
    s.resources = tags + '/*.bundle'
    
    s.preserve_path = 'ChangeLog.txt'
    
    s.vendored_libraries = tags + '/*.a'

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'UIKit', 'Security','CoreGraphics','AudioToolbox','AVFoundation','CoreMotion','Security','StoreKit','SystemConfiguration','CFNetwork','MediaPlayer','WebKit'

    s.libraries = 'sqlite3','z','c++','icucore'

end
