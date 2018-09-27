Pod::Spec.new do |s|
    s.name             = 'Yodo1AdsApplovin'
    s.version          = '3.0.1'
    s.summary          = 'sdk v5.1.2'
    s.description      = <<-DESC
                        TODO: Add long description of the pod here.
                       DESC
    s.homepage         = 'https://github.com'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => "#{s.version}" + "/LICENSE" }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :http => "https://cocoapods.yodo1api.com/thirdsdks/" + "#{s.name}" + "/"+ "#{s.version}" + ".zip" }
    
    s.ios.deployment_target = '8.0'

    s.source_files =  "#{s.version}" + '/headers/*.h'

    s.public_header_files =  "#{s.version}" + '/headers/*.h'

    s.vendored_libraries =  "#{s.version}" + '/*.a'

    s.preserve_path = "#{s.version}" + '/ChangeLog.txt'
    
    s.requires_arc = false

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => 'NO',
        'ONLY_ACTIVE_ARCH' => 'NO'
    }

    s.frameworks = 'AdSupport', 'AVFoundation', 'CoreTelephony', 'CoreGraphics', 'CoreMedia', 'StoreKit', 'SystemConfiguration', 'UIKit','WebKit'

    s.weak_frameworks = 'SafariServices'


    s.libraries = 'sqlite3.0','z'
    
end