#
# Be sure to run `pod lib lint SwiftySunrise.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftySunrise'
  s.version          = '1.1.1'
  s.summary          = 'Sunrise and sunset times in Swift.'

  s.homepage         = 'https://github.com/tomw/SwiftySunrise'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Tom Weightman' => 'tomweightman.com' }
  s.source           = { :git => 'https://github.com/tomw/SwiftySunrise.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.requires_arc = true
  s.ios.deployment_target = '8.0'

  s.source_files = 'SwiftySunrise/*.swift'
  s.pod_target_xcconfig =  {
        'SWIFT_VERSION' => '3.0',
  }

  # s.resource_bundles = {
  #   'SwiftySunrise' => ['SwiftySunrise/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
