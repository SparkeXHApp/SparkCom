#
# Be sure to run `pod lib lint SparkCom.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SparkCom'
  s.version          = '0.1.0'
  s.summary          = 'A short description of SparkCom.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/SparkeXHApp/SparkCom'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SparkeXHApp' => 'sfhery@foxmail.com' }
  s.source           = { :git => 'https://github.com/SparkeXHApp/SparkCom.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '12.0'

  s.source_files = 'SparkCom/Classes/**/*'
  
  s.resource_bundles = {
    'SparkCom' => ['SparkCom/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
  s.dependency 'Kingfisher', '4.1.1'
  s.dependency 'SVGKit', '3.0.0'
  s.dependency 'FDFullscreenPopGesture', '1.1'
  s.dependency 'SwiftyJSON', '4.0.0'
  s.dependency 'SVProgressHUD'
  s.dependency 'SnapKit', '4.0.1'
  s.dependency 'LottieService'
  s.dependency 'CYLTabBarController/Lottie'
  
end
