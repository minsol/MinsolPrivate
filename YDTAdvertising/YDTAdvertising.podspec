

Pod::Spec.new do |s|
    s.name          = 'YDTAdvertising'
    s.version       = '0.1.0'
    s.summary       = 'YDTAdvertising广告私有库.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "YDTAdvertising-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'YDTAdvertising/YDTAdvertising/**/*{h,m}'

    s.dependency "InMobiSDK"
    s.dependency "Masonry"
    s.dependency "OpenUDID"
    s.dependency "AFNetworking"
    s.dependency "GDTMobSDK", '~> 4.8.1' #这里改成你想要的版本号
end
