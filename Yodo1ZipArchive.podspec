Pod::Spec.new do |s|
    s.name             = 'Yodo1ZipArchive'
    s.version          = '4.0.0'
    s.summary          = 'A short description of ZipArchive.'

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

    s.source_files = "#{s.version}" + '/*.{h,m}',"#{s.version}" + '/minizip/crypt.h',"#{s.version}" + '/minizip/ioapi.{c,h}',"#{s.version}" + '/minizip/mztools.{c,h}',"#{s.version}" + '/minizip/unzip.{c,h}',"#{s.version}" + '/minizip/zip.{c,h}'
    s.public_header_files = "#{s.version}" + '/*.h',"#{s.version}" + '/minizip/crypt.h', "#{s.version}" + '/minizip/ioapi.h', "#{s.version}" + '/minizip/mztools.h', "#{s.version}" + '/minizip/unzip.h', "#{s.version}" + '/minizip/zip.h'

    s.libraries = 'z'
    s.requires_arc = true
    s.compiler_flags = '-Dunix'

    valid_archs = ['armv7','arm64','x86_64']
    s.xcconfig = {
        "OTHER_LDFLAGS" => "-ObjC",
        "ENABLE_BITCODE" => "NO",
        "ONLY_ACTIVE_ARCH" => "NO",
        'VALID_ARCHS' =>  valid_archs.join(' ')
    }

end
