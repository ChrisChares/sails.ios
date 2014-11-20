#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
s.name             = "sails.ios"
s.version          = "0.2.3"
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
s.requires_arc = true

s.source_files = 'Pod/Classes'
s.resource_bundles = {
'sails.ios' => ['Pod/Assets/*.png']
}

s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'SomeFramework', 'AnotherFramework'

s.dependency 'SOCKit', '~> 1.1'
s.dependency 'AFNetworking', '~> 2.2.1'
s.dependency 'socket.IO', '~> 0.5.2'
end
