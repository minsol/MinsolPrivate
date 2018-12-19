

Pod::Spec.new do |s|
    s.name          = 'ActionTrack'
    s.version       = '0.0.1'
    s.summary       = 'ActionTrack埋点.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "ActionTrack-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'ActionTrack/ActionTrack/**/*{h,m}'
end
