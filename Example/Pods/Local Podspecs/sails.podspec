#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "sails"
  s.version          = "0.1.0"
  s.summary          = "iOS client for interacting with sails.js apps over http or ws"
  s.description      = <<-DESC
                       I was told this could be optional
                       Although now it says this has to be longer than the summary
                       And throws an error if I comment it out
                       DESC
  s.homepage         = "https://github.com/ChrisChares/sails.ios"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Chris Chares" => "chrisc@eunoia.cc" }
  s.source           = { :git => "https://github.com/ChrisChares/sails.ios.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes/ios'

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  # s.frameworks = 'SomeFramework', 'AnotherFramework'
  s.dependency 'SOCKit', '~> 1.1'
  s.dependency 'AFNetworking', '~> 2.2.1'
  s.dependency 'socket.IO', '~> 0.5.2'
end
