

Pod::Spec.new do |s|
    s.name          = 'WJRouter'
    s.version       = '0.0.1'
    s.summary       = 'URL routing library for iOS with a simple block-based API'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "WJRouter-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'WJRouter/WJRouter/*{h,m}'
end
