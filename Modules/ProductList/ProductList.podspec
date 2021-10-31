Pod::Spec.new do |s|
  s.name             = 'ProductList'
  s.version          = '0.1.0'
  s.summary          = 'A short description of ProductList.'
  s.description      = 'ProductList module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'
  s.source_files     = 'ProductList/**/*'
  s.resource_bundles = {
    'ProductList' => ['Assets/**/*.{png,xcassets,json,txt,storyboard,xib,xcdatamodeld,strings}']
  }
  
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'SnapKit'
  s.dependency 'Core'

end
