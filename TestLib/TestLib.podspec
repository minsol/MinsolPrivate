
Pod::Spec.new do |s|
    s.name         = "TestLib"
    s.version      = "0.0.2"
    s.summary      = "A delightful iOS and OS X networking framework."
    s.homepage     = "https://github.com/minsol/TestLib"
    s.license      = { :type => 'MIT', :file => 'LICENSE'  }
    s.author             = { "wanjian" => "wanjian@a8sport.com" }
    s.source       = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "#{s.version}" }
    s.source_files  =  'Classes/Person.h'
    s.public_header_files = 'Classes/Person.h'
    s.ios.deployment_target = '7.0'

    s.frameworks = "Foundation","UIKit"
    # s.dependency "JSONKit", "~> 1.4"
end
