Pod::Spec.new do |s|
    s.name             = 'Yodo1iCloud'
    s.version          = '2.0.1'
    s.summary          = '更新到v2.0.1'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC

    tags               = "#{s.name}" 

    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/8AGame/Yodo1Libs.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/*.{h,m,mm}'
    s.public_header_files = tags + '/*.h'
    
    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }
    s.frameworks = 'UIKit', 'CloudKit'
    s.dependency 'Yodo1Commons','2.0.1'
end
