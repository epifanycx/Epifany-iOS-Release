#
# Be sure to run `pod lib lint Epifany.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Epifany'
  s.version          = '0.1.0'
  s.summary          = 'a simple survey SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A easy to use survey tool using beacon technology.
                       DESC

  s.homepage         = 'https://github.com/stealznc/Epifany-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shawn Murphy' => 'shawn.murphy@epifany.com' }
  s.source           = { :http => 'https://github.com/stealzinc/Epifany-iOS-Release/realeases/download/0.0.1/EpifanyPod.zip'}
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.ios.vendored_frameworks = 'Epifany.framework'
  s.source_files = 'Epifany.framework/Headers/Epifany.Swift.h', 'Epfiany.framework/Headers/Epifany-umbrella.h', 'Epifany.framework/Headers/Epifany.h'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.vendored_frameworks = 'Epifany/ProximityKit.framework'
  s.dependency 'Balderdash', '0.0.3'
  s.dependency 'Moya' 
  s.dependency 'Moya-ModelMapper', '6.0.0-beta.1'
  s.framework = 'CoreBluetooth'
  s.library = 'sqlite3'
end
