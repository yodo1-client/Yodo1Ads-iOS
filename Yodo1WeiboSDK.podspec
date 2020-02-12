Pod::Spec.new do |s|
    s.name             = 'Yodo1WeiboSDK'
    s.version          = '4.0.0'
    s.summary          = '微博移动SDK3.2.5具体的变动如下：替换UIWebView控件,
                            适配iOS13，禁用暗黑模式，全屏展示页面删除无用代码及“支付”相关字符，
                            优化内容，缩减包大小.[专用]'
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


    s.source_files = "#{s.version}" + '/*.h'
    
    s.public_header_files = "#{s.version}" + '/*.h'
    
    s.vendored_libraries = "#{s.version}" + '/*.a'
    
    s.resources = "#{s.version}" + '/*.bundle'

    valid_archs = ['armv7','arm64','x86_64']
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' ')
    }

    s.requires_arc = true
    s.frameworks = 'UIKit', 'Foundation','ImageIO','SystemConfiguration','CoreText','QuartzCore','Security','CoreGraphics','CoreTelephony','Photos','WebKit'

    s.libraries = 'sqlite3','z'

end
