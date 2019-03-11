#
# Be sure to run `pod lib lint MNIncreaseTextView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MNIncreaseTextView'
  s.version          = '1'
  s.summary          = 'A short description of MNIncreaseTextView.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://coding.net/u/tianmindianshang/p/MNIncreaseTextView/git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tianmindianshang' => '724896800@qq.com' }
  s.source           = { :git => 'https://git.coding.net/tianmindianshang/MNIncreaseTextView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MNIncreaseTextView/Classes/**/*'
  
  s.resource_bundles = {
      'MNIncreaseTextView' => ['MNIncreaseTextView/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'YYText'
end
