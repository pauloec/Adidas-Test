Pod::Spec.new do |s|
  s.name             = 'Review'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Review.'
  s.description      = 'Review module'
  s.homepage         = 'http://github.com/pauloec'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'paulo.ec@hotmail.com' => 'paulo.ec@hotmail.com' }
  s.source           = { :git => '',
 :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.swift_version    = '5.0'
  s.source_files     = 'Review/**/*'
  s.resource_bundles = {
    'Review' => ['Assets/**/*.{png,xcassets,json,txt,storyboard,xib,xcdatamodeld,strings}']
  }
  
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
  s.dependency 'SnapKit'
  s.dependency 'Core'
  
end
