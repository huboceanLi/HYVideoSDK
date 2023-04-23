#
# Be sure to run `pod lib lint HYVideoSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HYVideoSDK'
  s.version          = '0.0.1'
  s.summary          = 'A short description of HYVideoSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huboceanLi/HYVideoSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ocean' => 'li437277219@gmail.com' }
  s.source           = { :git => 'https://github.com/huboceanLi/HYVideoSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
  s.requires_arc = true
  s.swift_version = '5.0'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.static_framework = true
  s.source_files = 'HYVideoSDK/Classes/**/*'
  s.resources = "HYVideoSDK/Resources/*"


  # s.resource_bundles = {
  #   'HYVideoSDK' => ['HYVideoSDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # 

  s.dependency "QMUIKit"
  s.dependency "Masonry"
#  s.dependency "SJVideoPlayer"
#  s.dependency "SJUIKit/SQLite3"
#  s.dependency "SJMediaCacheServer"
  s.dependency "HYBaseTool", '~> 1.0.2'
  s.dependency "YYKit"
  s.dependency "AFNetworking"
  s.dependency "MBProgressHUD+JDragon"
  s.dependency "WCDB.swift"


end
