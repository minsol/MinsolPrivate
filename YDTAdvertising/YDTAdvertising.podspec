

Pod::Spec.new do |s|
    s.name          = 'YDTAdvertising'
    s.version       = '2.0.3'
    s.summary       = 'YDTAdvertising广告私有库.'
    s.homepage      = "https://github.com/minsol/TestLib"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.ios.vendored_library = 'YDTAdvertising/Advertising/GDT_iOS_SDK_4.8.0/libGDTMobSDK.a'
    s.source_files = 'YDTAdvertising/Advertising/AdHeader.h'
    s.frameworks = "AdSupport","CoreLocation","QuartzCore","SystemConfiguration","CoreTelephony","Security","StoreKit","AVFoundation"
    s.weak_frameworks = "WebKit"
    s.libraries = "z","xml2"
    s.dependency "InMobiSDK"
    s.dependency "Masonry"
    s.dependency "OpenUDID"

    #配置层级目录
    s.subspec 'AdHandler' do |ss|
        ss.source_files = 'YDTAdvertising/Advertising/AdHandler/**/*.{h,m}'
    end

    s.subspec 'Model' do |ss|
        ss.source_files = 'YDTAdvertising/Advertising/Model/*.{h,m}'
    end

    s.subspec 'View' do |ss|
        ss.source_files = 'YDTAdvertising/Advertising/View/**/*.{h,m}'
    end

    s.subspec 'GDT_iOS_SDK_4.8.0' do |ss|
        ss.source_files = 'YDTAdvertising/Advertising/GDT_iOS_SDK_4.8.0/*.{h,m}'
    end
end
