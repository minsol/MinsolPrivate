Pod::Spec.new do |s|
    s.name          = 'A8FMDB'
    s.version       = '0.0.3'
    s.summary       = '基于 FFDB 的封装 OC 版.'
    s.homepage      = "https://github.com/minsol/MinsolSpec.git"
    s.license       = { :type => 'MIT', :file => 'LICENSE'  }
    s.author        = { "wanjian" => "wanjian@a8sport.com" }
    s.source        = { :git => "https://github.com/minsol/MinsolPrivate.git", :tag => "A8FMDB-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files = 'A8FMDB/A8FMDB/DatabaseAdaptor.{h,m}','A8FMDB/A8FMDB/BaseTable.{h,m}'

    s.dependency "FFDB"
end
