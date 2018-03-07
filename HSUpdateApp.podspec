#
#  Be sure to run `pod spec lint HSUpdateApp.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "HSUpdateApp"
s.version      = "2.2.4"
s.summary      = "Title Bar Gradient with the User to drag for ios."
s.homepage     = "https://github.com/wolfhous/HSUpdateApp"
s.license      = "MIT"
s.author             = { "wolfhous" => "120237979@qq.com" }
s.platform     = :ios, "9.0"
s.source       = { :git => "https://github.com/wolfhous/HSUpdateApp.git", :tag => "2.2.4" }

s.source_files  =  "HSUpdateApp/*.{h,m}"

s.framework  = "UIKit"

end
