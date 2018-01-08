Pod::Spec.new do |s|
    s.name             = 'Yodo1ZipArchive'
    s.version          = '1.0.2'
    s.summary          = 'A short description of ZipArchive.'

    s.description      = <<-DESC
    TODO: Add long description of the pod here.
                       DESC
    tags               = "#{s.name}"                  
    s.homepage         = 'http://git.yodo1.cn/'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'yixian huang' => 'huangyixian@yodo1.com' }
    s.source           = { :git => "https://github.com/Yodo1/Yodo1Ads-iOS.git", :tag => tags + "#{s.version}" }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '7.0'

    s.source_files = tags + '/*.{h,m}',tags + '/minizip/crypt.h',tags + '/minizip/ioapi.{c,h}',tags + '/minizip/mztools.{c,h}',tags + '/minizip/unzip.{c,h}',tags + '/minizip/zip.{c,h}'
    s.public_header_files = tags + '/*.h',tags + '/minizip/crypt.h', tags + '/minizip/ioapi.h', tags + '/minizip/mztools.h', tags + '/minizip/unzip.h', tags + '/minizip/zip.h'

    s.libraries = 'z'
    s.requires_arc = true
    s.compiler_flags = '-Dunix'

    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO"
    }

end
