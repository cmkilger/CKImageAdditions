Pod::Spec.new do |s|
  s.name         = "CKImageAdditions"
  s.version      = "2.0.0"
  s.summary      = "Additional functions and methods for working with Core Graphics and UIImages on iOS."
  s.homepage     = "https://github.com/cmkilger/CKImageAdditions"
  s.license      = 'MIT'
  s.author       = { "Cory Kilger" => "cmkilger@gmail.com" }
  s.source       = { :git => "https://github.com/cmkilger/CKImageAdditions.git", :branch => "master" }
  s.platform     = :ios, '13.0'
  s.source_files = 'Sources/CKImageAdditions'
end
