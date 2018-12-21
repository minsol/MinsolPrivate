

Pod::Spec.new do |s|
    s.name          = 'RuntimeInfo'
    s.version       = '0.0.1'
    s.summary       = 'Simple NSObject-category wrapper for <objc/runtime.h>'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "RuntimeInfo-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'RuntimeInfo/RuntimeInfo/*{h,m}'
end
