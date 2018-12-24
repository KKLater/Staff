Pod::Spec.new do |s|
    s.name         = "Staff"
    s.version      = "0.0.1"
    s.summary      = "Staff creadted to verify UI layout"
    s.description  = <<-DESC
    Staff creadted to verify UI layout，
    Set enable Yes for Use
    DESC
    
    s.homepage     = "https://github.com/KKLater/Staff"
    s.license      = "MIT"
    s.author       = { "Later" => "lshxin89@126.com" }
    s.platform     = :ios, "8.0"
    s.source       = { :git => "https://github.com/KKLater/Staff.git", :tag => s.version }
    s.frameworks = "UIKit", "Foundation"
    s.requires_arc = true
    s.public_header_files = 'Staff/*.h'
    s.source_files = 'Staff/*.{h,m}'
    s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-all_load' }
end
