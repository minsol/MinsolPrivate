

Pod::Spec.new do |s|
    s.name          = 'YDTAdvertising'
    s.version       = '2.0.5'
    s.summary       = 'YDTAdvertising广告私有库.'
    s.homepage      = "https://github.com/minsol/TestLib"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.ios.vendored_library = 'YDTAdvertising/YDTAdvertising/GDT_iOS_SDK_4.8.0/libGDTMobSDK.a'
    s.source_files = 'YDTAdvertising/YDTAdvertising/**'
    s.frameworks = "AdSupport","CoreLocation","QuartzCore","SystemConfiguration","CoreTelephony","Security","StoreKit","AVFoundation"
    s.weak_frameworks = "WebKit"
    s.libraries = "z","xml2"
    s.dependency "InMobiSDK"
    s.dependency "Masonry"
    s.dependency "OpenUDID"
end
