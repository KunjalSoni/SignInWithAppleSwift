#
# Be sure to run `pod lib lint SignInWithAppleSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SignInWithAppleSwift'
  s.version          = '0.1.0'
  s.summary          = 'Custom class to authenticate users with Sign Apple account in the simplest way, ever'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'SignInWithAppleSwift is a custom class to authenticate users with Apple account in the simplest way, ever'
                       DESC

  s.homepage         = 'https://github.com/Kunjal Soni/SignInWithAppleSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Kunjal Soni' => 'sonikunj141297@gmail.com' }
  s.source           = { :git => 'https://github.com/KunjalSoni/SignInWithAppleSwift.git', :tag => s.version.to_s }

  s.ios.deployment_target = '12.0'
  s.swift_versions = '5.0'

  s.source_files = 'SignInWithAppleSwift/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SignInWithAppleSwift' => ['SignInWithAppleSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SwiftKeychainWrapper', '~> 4.0.1'
end
