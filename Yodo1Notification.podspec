Pod::Spec.new do |s|
    s.name             = 'Yodo1Notification'
    s.version          = '2.0.1'
    s.summary          = 'A short description of Yodo1Notification.'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    tags               = "#{s.name}" 

    s.homepage         = 'http://git.yodo1.cn/Yodo1sdk/Yodo1Notification.git'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/*.{h,mm}'
    s.public_header_files = tags + '/*.h'
    s.requires_arc  = true
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'UIKit'
    s.dependency 'Yodo1Commons','2.0.1'
end
