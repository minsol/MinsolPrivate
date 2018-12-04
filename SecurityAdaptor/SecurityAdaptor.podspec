Pod::Spec.new do |s|
    s.name          = 'SecurityAdaptor'
    s.version       = '0.0.1'
    s.summary       = 'iOS数据相关整理.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "SecurityAdaptor-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'SecurityAdaptor/SecurityAdaptor/**.{h,m}'
    s.frameworks = 'Foundation', 'Security'
    s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/CommonCrypto" }
end
