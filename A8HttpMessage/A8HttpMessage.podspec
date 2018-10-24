

Pod::Spec.new do |s|
    s.name          = 'A8HttpMessage'
    s.version       = '0.0.1'
    s.summary       = 'A8HttpMessage网络请求私有库.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "A8HttpMessage-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'A8HttpMessage/A8HttpMessage/**/*{h,m}'

    s.dependency "AFNetworking"

end
