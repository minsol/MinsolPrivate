
Pod::Spec.new do |spec|
    spec.name         = 'YDTAppPrivate'
    spec.version      = '1.0.5'
    spec.summary      = 'A8隐私权验证页面'
    spec.license      = { :type => 'MIT', :file => 'LICENSE'  }
    spec.homepage     = 'http://gitrepo.fungotv.com'
    spec.authors      = { '白云' => 'yuancheng@a8sport.com' }
    spec.source       = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "#{spec.version}" }
    spec.source_files  = 'YDTAppPrivate/Lib/**'
    spec.ios.deployment_target = '8.0'
    spec.frameworks  = "UIKit"
    spec.dependency 'Masonry'
end
