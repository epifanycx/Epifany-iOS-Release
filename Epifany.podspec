#
# Be sure to run `pod lib lint Epifany.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Epifany'
  s.version          = '0.1.1'
  s.summary          = 'a simple survey SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A easy to use survey tool using beacon technology.
                       DESC

  s.homepage         = 'https://github.com/stealzinc/Epifany-iOS-Release'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shawn Murphy' => 'shawn.murphy@epifany.com' }
  s.source           = { :http => 'https://github.com/stealzinc/Epifany-iOS-Release/releases/download/0.0.5/EpifanyPod.zip'}

  s.ios.deployment_target = '8.0'
  s.ios.vendored_frameworks = 'Epifany.framework'
  s.vendored_frameworks = 'ProximityKit.framework'
  s.dependency 'Balderdash', '0.0.3'
  s.dependency 'Moya'
  s.dependency 'Moya-ModelMapper', '6.0.0-beta.1'
  s.framework = 'CoreBluetooth', 'CoreLocation'
  s.library = 'sqlite3'
end:
