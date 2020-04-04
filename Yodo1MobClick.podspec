Pod::Spec.new do |s|
    s.name             = 'Yodo1MobClick'
    s.version          = '4.1.0'
    s.summary          = 'UMAnalytics 更新 V6.0.5+G_917526b7bc_20190701161549 [大更新];
                          6.1.0+G_0a2678de36_20191217134700
                        '
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

    s.source_files = "#{s.version}" +'/UMAnalytics.framework/Versions/A/Headers/*.h',"#{s.version}" +'/UMCommon.framework/Versions/A/Headers/*.h'
    
    s.public_header_files = "#{s.version}" +'/UMAnalytics.framework/Versions/A/Headers/*.h',"#{s.version}" +'/UMCommon.framework/Versions/A/Headers/*.h'
  
    s.vendored_frameworks = "#{s.version}" +'/*.framework'

    s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = 'CoreTelephony','SystemConfiguration','UIKit','Foundation'

    s.libraries = 'sqlite3', 'z'

end
