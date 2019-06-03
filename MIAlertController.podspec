Pod::Spec.new do |spec|
  spec.name             = 'MIAlertController'
  spec.version          = '1.4'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage         = 'https://github.com/MarioIannotta/MIAlertController'
  spec.authors          = { 'Mario Iannotta' => 'info@marioiannotta.com' }
  spec.summary          = 'A simple fully customizable alert controller'
  spec.source           = { :git => 'https://github.com/MarioIannotta/MIAlertController.git', :tag => spec.version.to_s }
  spec.source_files     = 'MIAlertController/*'
  spec.ios.deployment_target = '9.0'
end