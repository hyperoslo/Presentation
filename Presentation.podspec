Pod::Spec.new do |s|
  s.name             = "Presentation"
  s.summary          = "Presentation helps you to make tutorials, release notes and animated pages."
  s.version          = "4.1.2"
  s.homepage         = "https://github.com/hyperoslo/Presentation"
  s.license          = 'MIT'
  s.author           = { "Hyper" => "ios@hyper.no" }
  s.source           = { :git => "https://github.com/hyperoslo/Presentation.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/hyperoslo'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Source/**/*'
end
