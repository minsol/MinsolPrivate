

Pod::Spec.new do |s|
    s.name          = 'A8CycleScrollView'
    s.version       = '0.0.2'
    s.summary       = 'A8CycleScrollView滚动视图.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "A8CycleScrollView-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'A8CycleScrollView/A8CycleScrollView/*{h,m}'

    s.dependency "SDWebImage"

end
