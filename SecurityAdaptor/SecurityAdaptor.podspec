Pod::Spec.new do |s|
    s.name          = 'SecurityAdaptor'
    s.version       = '0.0.2'
    s.summary       = 'iOS数据相关整理.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "SecurityAdaptor-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'SecurityAdaptor/SecurityAdaptor/**/*.{h,m}','SecurityAdaptor/SecurityAdaptor/*.{h,m}'
    s.public_header_files = 'SecurityAdaptor/SecurityAdaptor/SecurityAdaptor.h'
end
