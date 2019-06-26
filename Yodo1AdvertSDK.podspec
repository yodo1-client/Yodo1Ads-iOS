Pod::Spec.new do |s|
    s.name             = 'Yodo1AdvertSDK'
    s.version          = '3.0.3'
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

    s.ios.deployment_target = '8.0'

    s.source_files = "#{s.version}"  + '/*.h'

    s.public_header_files = "#{s.version}"  + '/*.h'

    s.vendored_libraries = "#{s.version}"  + '/*.a'

    # s.preserve_paths = "#{s.version}"  + '/ChangeLog.txt'

    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'UIKit'
 
    s.dependency 'Yodo1Commons','3.0.4'
    s.dependency 'Yodo1OnlineParameter','3.0.3'
    s.dependency 'Yodo1Analytics','3.0.4'
    s.dependency 'Yodo1AdsConfig','3.0.9'
    s.dependency 'Yodo1FeedbackError','3.0.0'
    
end
