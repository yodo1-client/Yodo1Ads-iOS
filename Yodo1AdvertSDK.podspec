Pod::Spec.new do |s|
    s.name             = 'Yodo1AdvertSDK'
    s.version          = '4.2.2'
    s.summary          = 'Yodo1AdvertSDK Have Banner,Intersttial,Video [修改广点通特殊处理逻辑]'
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

    s.source_files = "#{s.version}"  + '/*.h'

    s.public_header_files = "#{s.version}"  + '/*.h'

    s.vendored_libraries = "#{s.version}"  + '/*.a'

     s.requires_arc = true

    s.xcconfig = {
        'OTHER_LDFLAGS' => '-ObjC',
        'ENABLE_BITCODE' => "NO",
        "VALID_ARCHS": "armv7 arm64",
        "VALID_ARCHS[sdk=iphoneos*]": "armv7 arm64",
        "VALID_ARCHS[sdk=iphonesimulator*]": "x86_64"
    }

    s.frameworks = 'UIKit'
 
    s.dependency 'Yodo1Commons','4.1.0'
    s.dependency 'Yodo1OnlineParameter','4.2.2'
    s.dependency 'Yodo1Analytics','4.2.2'
    s.dependency 'Yodo1FeedbackError','4.1.1'
    s.dependency 'Yodo1SaAnalytics','4.1.0'
    
end
