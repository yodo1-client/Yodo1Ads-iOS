Pod::Spec.new do |s|
    s.name             = 'InterstitialMobvista'
    s.version          = '1.0.3'
    s.summary          = 'Interstitial Mobvista'
    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"

    s.homepage         = 'https://github.com/yixian huang/InterstitialMobvista'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }

    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

   s.ios.deployment_target = '8.0'

    #s.source_files = tags + '/*.{h,m}'

    #s.public_header_files = tags + '/*.h'

    s.vendored_libraries = tags + '/*.a'

    s.requires_arc = true

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

    s.dependency 'Yodo1Interstitial','2.0.3'
    s.dependency 'Yodo1AdsMobvista','1.0.5'

end
