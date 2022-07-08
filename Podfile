platform :ios, '12.0'

use_frameworks!
inhibit_all_warnings!

def pods
  pod 'Alamofire'
  pod 'PromiseKit'
end

target 'Kaizen' do
  pod 'SwiftLint', '0.47.0'
  pods
end

target 'KaizenTests' do
  pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SUPPORTS_MACCATALYST'] = 'NO'
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
    end
  end
end
