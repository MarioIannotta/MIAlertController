Pod::Spec.new do |spec|
  spec.name             = 'MIAlertController'
  spec.version          = '1.4'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage         = 'https://github.com/Song-Street/MIAlertController'
  spec.authors          = { 'Mario Iannotta' => 'info@marioiannotta.com' }
  spec.summary          = 'A simple fully customizable alert controller'
  spec.source           = { :git => 'https://github.com/Song-Street/MIAlertController.git', :tag => spec.version.to_s, :commit => 'fc835c84f1ae758b569b87d0d6c73fa44de2b40d',  }
  spec.source_files     = 'MIAlertController/*'
  spec.ios.deployment_target = '9.0'
end