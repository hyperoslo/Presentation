Pod::Spec.new do |s|
  s.name             = "Presentation"
  s.summary          = "A short description of Presentation."
  s.version          = "0.1"
  s.homepage         = "https://github.com/hyperoslo/Presentation"
  s.license          = 'MIT'
  s.author           = { "Hyper" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/Presentation.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'
  s.dependency 'Hex', '~> 1.1.1'
  s.dependency 'Pages', '~> 0.6.0'
  s.dependency 'Cartography', '~> 0.5.0'
end
