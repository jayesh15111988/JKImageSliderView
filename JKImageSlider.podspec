Pod::Spec.new do |s|
  s.name          = 'JKImageSliderView'
  s.version       = '0.4'
  s.license       = 'MIT'
  s.summary       = 'Native image slider'
  s.homepage      = 'https://github.com/jayesh15111988'
  s.author        = 'Jayesh Kawli'
  s.source        = {  :git => 'https://github.com/jayesh15111988/JKImageSliderView.git', :tag => "#{s.version}" }
  s.source_files  = 'JKImageSlider/library/*.swift'
  s.resources     = 'JKImageSlider/assets/*.png'
  s.dependency 'SDWebImage', '~> 3.7'
  s.requires_arc  = true
  s.ios.deployment_target = '8.0'  
end

