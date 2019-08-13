#
# Be sure to run `pod lib lint Epifany.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Epifany'
  s.version          = '0.2.0'
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
  s.source           = { :git => 'https://github.com/stealznc/Epifany-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'Epifany/Classes/**/*'

  s.resource_bundles = {
     'Epifany' => ['Epifany/Assets/*.json']
   }

  s.dependency 'Balderdash', '0.0.4'
  s.dependency 'Moya', '14.0.0-alpha.2'
  s.dependency 'ModelMapper'
  s.library = 'sqlite3'
end
