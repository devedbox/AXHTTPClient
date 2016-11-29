Pod::Spec.new do |s|

  s.name         = 'AXHTTPClient'
  s.version      = '0.0.15'
  s.summary      = 'A networking manager kits.'
  s.description  = <<-DESC
                    A networking manager kits using on iOS platform.
                   DESC

  s.homepage     = 'https://github.com/devedbox/AXHTTPClient'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { 'aiXing' => '862099730@qq.com' }
  s.platform     = :ios, '7.0'

  s.source       = { :git => 'https://github.com/devedbox/AXHTTPClient.git', :tag => '0.0.15' }
  s.source_files  = 'AXHTTPClient/AXHTTPClient/*.{h,m}', 'AXHTTPClient/AXHTTPClient/Core/*.{h,m}', 'AXHTTPClient/AXHTTPClient/Core/Models/*.{h,m}'
#'AXHTTPClient/AXHTTPClient/Core/AESCrypt/*.{h,m}'

#  s.module_map = 'AXHTTPClient/module.modulemap'

  s.resource  = 'AXHTTPClient/AXHTTPClient/AXHTTPClient.bundle'

  s.frameworks = 'UIKit', 'Foundation'

#  s.header_mappings_dir = 'include'

  s.requires_arc = true

  s.dependency 'AFNetworking'
  s.dependency 'JYObjectModule'
  s.dependency 'AXAESCrypt'
  s.dependency 'AXExtensions'
end
