#
#  Be sure to run `pod spec lint GXPlugin.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "GXPlugin"
  s.version       = "1.0.1"
  s.swift_version = "5.0"
  s.summary       = "iOS插件开发的基础类"
  s.homepage      = "https://github.com/gsyhei/GXPlugin"
  s.license       = { :type => "MIT", :file => "LICENSE" }
  s.author        = { "Gin" => "279694479@qq.com" }
  s.platform      = :ios, "13.0"
  s.source        = { :git => "https://github.com/gsyhei/GXPlugin.git", :tag => "1.0.1" }
  s.requires_arc  = true
  s.source_files  = "GXPlugin"
 #s.resources     = 'GXPlugin/Resource/**/*'
  s.frameworks    = "UIKit"

end
