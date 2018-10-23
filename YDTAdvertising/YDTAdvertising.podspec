

Pod::Spec.new do |s|
    s.name          = 'YDTAdvertising'
    s.version       = '2.0.5'
    s.summary       = 'YDTAdvertising广告私有库.'
    s.homepage      = "https://github.com/minsol/MinsolPrivate.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'YDTAdvertising/**/*{h,m}'

    s.dependency "InMobiSDK"
    s.dependency "Masonry"
    s.dependency "OpenUDID"

    # 表示建立一个名字为 xxx 的子文件夹，可以将文件分类
    s.subspec 'GDT_iOS_SDK_4.8.0' do |ss|
        ss.ios.vendored_library = 'GDT_iOS_SDK_4.8.0/libGDTMobSDK.a'
        ss.source_files = 'GDT_iOS_SDK_4.8.0/*.h'
        ss.frameworks = "AdSupport","CoreLocation","QuartzCore","SystemConfiguration","CoreTelephony","Security","StoreKit","AVFoundation"
        ss.weak_frameworks = "WebKit"
        ss.libraries = "z","xml2"
    end
end
