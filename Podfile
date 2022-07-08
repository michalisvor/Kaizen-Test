platform :ios, '12.0'

use_frameworks!
inhibit_all_warnings!

target 'Kaizen' do
  pod 'SwiftLint', '0.47.0'
  pod 'Alamofire'
  pod 'PromiseKit'
end

target 'KaizenTests' do
  pod 'Alamofire'
  pod 'PromiseKit'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SUPPORTS_MACCATALYST'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
