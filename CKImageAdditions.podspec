Pod::Spec.new do |s|
  s.name         = "CKImageAdditions"
  s.version      = "1.0"
  s.summary      = "Additional functions and methods for working with Core Graphics and UIImages on iOS."
  s.homepage     = "https://github.com/cmkilger/CKImageAdditions"
  s.license      = 'MIT'
  s.author       = { "Cory Kilger" => "cmkilger@gmail.com" }
  s.source       = { :git => "https://github.com/cmkilger/CKImageAdditions.git", :tag => "1.0" }
  s.platform     = :ios, '3.0'
  s.source_files = 'ImageAdditions'
  s.framework 'Foundation'
end
